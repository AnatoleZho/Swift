/*
Copyright (C) 2016 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
A `NSViewController` subclass to manage a table view that displays a collection of quakes.

When requested (by clicking the Fetch Quakes button), the controller creates an asynchronous `NSURLSession` task to retrieve JSON data about earthquakes. Earthquake data are compared with any existing managed objects to determine whether there are new quakes. New managed objects are created to represent new data, and saved to the persistent store on a private queue.
*/

import Cocoa

// An enumeration to specify codes for error conditions.
//
private enum QuakeViewControllerErrorCode: Int {
    case ServerConnectionFailed = 101
    case UnpackingJSONFailed = 102
    case ProcessingQuakeDataFailed = 103
    case FetchRequestFailed = 104
}


class QuakesViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    // MARK: Types
    
    // An enumeration to specify the names of earthquake properties that should
    // be displayed in the table view.
    //
    private enum QuakeDisplayProperty: String {
        case Place      = "placeName"
        case Time       = "time"
        case Magnitude  = "magnitude"
    }
    
    // MARK: Properties
    
    @IBOutlet private weak var tableView: NSTableView!
    @IBOutlet private weak var fetchQuakesButton: NSButton!
    @IBOutlet private weak var progressIndicator: NSProgressIndicator!

    private var quakes = [Quake]()
    
    // Managed object context for the view controller (which is bound to the
    // persistent store coordinator for the application).
    //
    private var managedObjectContext = CoreDataStackManager.sharedManager.mainQueueContext
    
    // MARK: View Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(QuakesViewController.contextDidSaveNotificationHandler(_:)),
            name: NSManagedObjectContextDidSaveNotification, object: nil)

        reloadTableView()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: Core Data Batching
    //
    @IBAction func fetchQuakes(sender: AnyObject) {
        
        // Ensure the button can't be pressed again until the fetch is complete.
        //
        fetchQuakesButton.enabled = false
        progressIndicator.hidden = false
        progressIndicator.startAnimation(nil)
        
        // Create an `NSURLSession` and then session task to contact the earthquake
        // server and retrieve JSON data. Because this server is out of our control
        // and does not offer a secure communication channel, we'll use the http
        // version of the URL and add "earthquake.usgs.gov" to the "NSExceptionDomains"
        // value in the apps's info.plist. When you commmunicate with your own
        // servers, or when the services you use offer a secure communication
        // option, you should always prefer to use HTTPS.
        //
        let jsonURL = NSURL(string: "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")!
        
        let sessionConfiguration = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let task = session.dataTaskWithURL(jsonURL) { dataOptional, response, error in
            // Enable the button and reload the table view when the operation finishes.
            //
            defer {
                dispatch_async(dispatch_get_main_queue()) {
                    self.fetchQuakesButton.enabled = true
                    self.progressIndicator.stopAnimation(nil)
                    self.progressIndicator.hidden = true
                    self.reloadTableView()
                }
            }
            
            // If we don't get data back, alert the user.
            //
            guard let data = dataOptional else {
                let description = NSLocalizedString("Could not get data from the remote server", comment: "Failed to connect to server")
                self.presentError(description, code: .ServerConnectionFailed, underlyingError: error)
                return
            }
            
            // If we get data but can't unpack it as JSON, alert the user.
            //
            let jsonDictionary: [NSObject: AnyObject]
            
            do {
                jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [NSObject: AnyObject]
            }
            catch {
                let description = NSLocalizedString("Could not analyze earthquake data", comment: "Failed to unpack JSON")
                self.presentError(description, code: .UnpackingJSONFailed, underlyingError: error)
                return
            }
            
            // If we can't process the data and save it, alert the user.
            //
            do {
                try self.importFromJsonDictionary(jsonDictionary)
            }
            catch {
                let description = NSLocalizedString("Could not process earthquake data", comment: "Could not process updates")
                self.presentError(description, code: .ProcessingQuakeDataFailed, underlyingError: error)
                return
            }
        }
        
        // If the task is created, start it by calling resume.
        //
        task.resume()
    }
    
    // MARK: Convenience Methods
    
    // Fetch quakes ordered in time and reload the table view.
    //
    private func reloadTableView() {
        let request = NSFetchRequest(entityName:"Quake")
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending:false)]
        
        do {
            quakes = try managedObjectContext.executeFetchRequest(request) as! [Quake]
        }
        catch {
            let localizedDescription = NSLocalizedString("Error attempting to update data", comment: "Failed to fetch data")
            presentError(localizedDescription, code: .FetchRequestFailed, underlyingError: error)
            return
        }
        tableView.reloadData()
    }
    
    private func presentError(description: String, code: QuakeViewControllerErrorCode, underlyingError error: ErrorType?) {

        var userInfo: [String: AnyObject] = [
            NSLocalizedDescriptionKey: description
        ]

        if let error = error as? NSError {
            userInfo[NSUnderlyingErrorKey] = error
        }
        
        let creationError = NSError(domain: EarthQuakesErrorDomain, code: code.rawValue, userInfo: userInfo)
        
        dispatch_async(dispatch_get_main_queue()) {
            NSApp.presentError(creationError)
        }
    }
    
    private func importFromJsonDictionary(jsonDictionary: [NSObject: AnyObject]) throws {
        // Any errors enountered in this function are passed back to the caller.
        
        // Create a context on a private queue to:
        // - Fetch existing quakes to compare with incoming data.
        // - Create new quakes as required.
        //
        let taskContext = try CoreDataStackManager.sharedManager.newPrivateQueueContextWithNewPSC()
        
        // Sort the dictionaries by code so they can be compared in parallel with
        // existing quakes.
        //
        let quakeDictionaries = jsonDictionary["features"] as! [[String: AnyObject]]
        
        let sortedQuakeDictionaries = quakeDictionaries.sort { lhs, rhs in
            let lhsResult = lhs["properties"]?["code"] as! String
            let rhsResult = rhs["properties"]?["code"] as! String
            return lhsResult < rhsResult
        }
        
        // To avoid a high memory footprint, process records in batches.
        //
        let batchSize = 128
        let count = sortedQuakeDictionaries.count
        
        var numBatches = count / batchSize
        numBatches += count % batchSize > 0 ? 1 : 0
        
        for batchNumber in 0..<numBatches {
            let batchStart = batchNumber * batchSize
            let batchEnd = batchStart + min(batchSize, count - batchNumber * batchSize)
            let range = batchStart..<batchEnd
            
            let quakesBatch = Array(sortedQuakeDictionaries[range])
            
            if !importFromFeaturesArray(quakesBatch, usingContext: taskContext) {
                return;
            }
        }
    }
    
    private func importFromFeaturesArray(results: [[String: AnyObject]], usingContext taskContext: NSManagedObjectContext) ->Bool {

        var success = false
        taskContext.performBlockAndWait() {
            // Fetch the existing records with the same code and remove them to avoid duplication.
            // Since we have the duplicated codes, this is probably a better way than others (like using an unique constraint)
            //
            let matchingQuakeRequest = NSFetchRequest(entityName: "Quake")
            let codes: [String] = results.map { dictionary in
                return dictionary["properties"]?["code"] as! String
            }
            
            matchingQuakeRequest.predicate = NSPredicate(format: "code in %@", argumentArray: [codes])
            do {
                let existingingQuakes = try taskContext.executeFetchRequest(matchingQuakeRequest)
                for existingQuake in existingingQuakes {
                    taskContext.deleteObject(existingQuake as! NSManagedObject)
                }
            }
            catch {
                print("Error: \(error)\nCould not fetch from the store.")
                return
            }
            // Create new records
            //
            for quakeDictionary in results {
                let quake = NSEntityDescription.insertNewObjectForEntityForName("Quake", inManagedObjectContext: taskContext) as! Quake
                // Set the attribute values the quake object.
                // If the data is not valid, delete the object and continue to process the next one.
                //
                do {
                    try quake.updateFromDictionary(quakeDictionary)
                }
                catch {
                    taskContext.deleteObject(quake)
                }
            }
            // Save all the changes just made and reset the taskContext to free the cache.
            //
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                }
                catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                    return
                }
                taskContext.reset()
            }
            success = true
        }
        return success
    }

    // Handler for NSManagedObjectContextDidSaveNotification.
    // Observe NSManagedObjectContextDidSaveNotification and merge the changes to the main context from other contexts.
    // We rely on this to sync between contexts, thus avoid most of merge conflicts and keep UI refresh.
    // In the sample code, we don’t edit the main context so not syncing with the private queue context won’t trigger any issue.
    // However, a real app may not as simple as this. We normally need to handle this notificaiton.
    //
    func contextDidSaveNotificationHandler(notification: NSNotification){
        
        let sender = notification.object as! NSManagedObjectContext
        if sender !== managedObjectContext {
            managedObjectContext.performBlock {
                self.managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
            }
        }
    }
    
    // MARK: NSTableViewDataSource
    //
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return quakes.count
    }
    
    // MARK: NSTableViewDelegate
    //
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let returnView: NSView?
        let identifier = tableColumn!.identifier
        
        if let propertyEnum = QuakeDisplayProperty(rawValue: identifier) {
            let cellView = tableView.makeViewWithIdentifier(identifier, owner: self) as! NSTableCellView
            let textField = cellView.textField!
            
            let quake = quakes[row]
            
            switch propertyEnum {
            case .Place:
                textField.stringValue = quake.placeName
                
            case .Time:
                textField.objectValue = quake.time
                
            case .Magnitude:
                textField.objectValue = quake.magnitude
            }
            
            returnView = cellView
        }
        else {
            returnView = nil
        }
        return returnView
    }
}
