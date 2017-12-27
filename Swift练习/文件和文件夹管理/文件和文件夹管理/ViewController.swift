//
//  ViewController.swift
//  文件和文件夹管理
//
//  Created by EastElsoft on 2017/6/7.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1. 获取磁盘上最常用的文件夹路径
        getCommonUseFolderDirectory()
        
        //2. 对文件进行读写操作
        writeAndReadFileContent()
        
        //3. 在磁盘中创建文件夹
        createDirectory()
        
        //4. 枚举文件和文件夹
        enumFileAndFolder()
        
        let appBundleContents = contentsOfAppBundle()
        
        for url in appBundleContents {
            printUrlPropertiesToConsole(url: url)
        }
        
        //5. 删除文件和文件夹
        let txtFolder = NSTemporaryDirectory().appending("txt")
        createFolderAtPath(path: txtFolder)
        createFilesInFolder(folder: txtFolder)
        enumerateFilesInFolder(folder: txtFolder)
        deleteFilesInFolder(folder: txtFolder)
        enumerateFilesInFolder(folder: txtFolder)
        deleteFolderAtPath(path: txtFolder)
        
        //6. 将对象保存到文件中
        saveObectInFile()
        
    }

    func getCommonUseFolderDirectory() {
        
        
        let fileManager = FileManager()
        //Documents 文件夹
        let documentsURLs = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask) as [URL]
        
        if documentsURLs.count > 0 {
            let documentsFolder = documentsURLs[0]
            print("\(documentsFolder)")
            
        } else {
            print("Could not find the Documents folder")
        }
        
        //Caches 文件夹
        let cachesURLs = fileManager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask) as [URL]
        if cachesURLs.count > 0 {
            let cachesFolder = cachesURLs[0]
            print("\(cachesFolder)")
        } else {
            print("Could not find the Caches folder")
        }
        
        //tmp 文件夹
        let tempDirectory = NSTemporaryDirectory()
        if tempDirectory.characters.count > 0 {
            print("\(tempDirectory)")
        } else {
            print("Could not find the temp directory")
        }
    }
    
    func writeAndReadFileContent() {
        
        //写入 读取 String 对象
        let someText: NSString = "Put some string here"
        let destinationPath = NSTemporaryDirectory() + "MyFile.txt"
        do {
            try someText.write(toFile: destinationPath, atomically: true, encoding: String.Encoding.utf8.rawValue)

            print("Successfully stored the file at path \(destinationPath)")
            
            do {
                let readString = try String(contentsOfFile: destinationPath, encoding: String.Encoding.utf8)
                print("The read string is : \(readString)")

            } catch let error as NSError{
                print(error)
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        
        // 写入 读取 Array 对象
        let arrayPath = NSTemporaryDirectory() + "ArrayFile.txt"
        let arrayOfName:NSArray = ["Steve", "John", "Edward"]
        
        let arrayWriteResult: Bool =  arrayOfName.write(toFile: arrayPath, atomically: true)
        if arrayWriteResult {
            print("Successfully stored the array")
            let readArray: NSArray? = NSArray(contentsOfFile: arrayPath)
            if let array = readArray {
                print("Could read the array back = \(array)")
            } else {
                print("Failed to read the array back")
            }
        } else {
            print("Failed stored the array")

        }
        
        //写入 读取 Dictionary 对象
        let dicPath = NSTemporaryDirectory() + "DicFile.txt"
        let dic: NSDictionary = ["first name": "Steven", "middle name": "Paul", "last name": "Jobs"]
        let dicWriteResult: Bool = dic.write(toFile: dicPath, atomically: true)
        if dicWriteResult {
            print("Successfully stored the dictionary")
            let readDic: NSDictionary? = NSDictionary(contentsOfFile: dicPath)
            if let dictionary = readDic {
                print("Could read the dictionary back = \(dictionary)")
            } else {
                print("Failed read the dictionary")
            }
        } else {
            print("Failed stored the dictionary")
        }
    }
    
    func createDirectory() {
        let tempPath = NSTemporaryDirectory()

        let imagesPath = tempPath.appending("Images")
        
        let fileManager = FileManager()
        
        do {
            try fileManager.createDirectory(atPath: imagesPath, withIntermediateDirectories: true, attributes: nil)
            print("Created the directory :\(imagesPath)")
        } catch let error as NSError {
            print(error)
        }
    }
    
    func enumFileAndFolder() {
        let fileManager = FileManager()
        let bundleDir = Bundle.main.bundlePath
        
        do {
            let bundleContents = try fileManager.contentsOfDirectory(atPath: bundleDir)
            if bundleContents.count == 0 {
                print("The app bundle is empty!")
            } else {
                print("The app bundle contents = \(bundleContents)")
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func contentsOfAppBundle() -> [NSURL] {
        let propertitesToGet = [URLResourceKey.isDirectoryKey,
                                URLResourceKey.isReadableKey,
                                URLResourceKey.creationDateKey,
                                URLResourceKey.contentAccessDateKey,
                                URLResourceKey.contentModificationDateKey]
        var result: [NSURL]? = nil
        let fileManager = FileManager()
        let bundleUrl = Bundle.main.bundleURL
        
        do {
            result = try fileManager.contentsOfDirectory(at: bundleUrl, includingPropertiesForKeys: propertitesToGet, options: FileManager.DirectoryEnumerationOptions(rawValue: 0)) as [NSURL]
            if result?.count == 0 {
                print("The app bundle is empty!")
            } else {
                print("The app bundle contents = \(String(describing: result))")
            }
        } catch let error as NSError {
            print(error)
        }
        return result!
    }
    
    func stringValueOfBoolProperty(property: String, url: NSURL) -> String {
        var value: AnyObject? = nil
        do {
            try url.getResourceValue(&value, forKey: URLResourceKey(rawValue: property))
            let number = value as! NSNumber
            return number.boolValue ? "YES":"NO"
        } catch let error as NSError {
            print(error)
        }
        
        return "NO"
    }
    
    func isUrlDirectory(url: NSURL) -> String {
        return stringValueOfBoolProperty(property: URLResourceKey.isDirectoryKey.rawValue, url: url)
    }
    
    func isUrlReadable(url: NSURL) -> String {
        return stringValueOfBoolProperty(property: URLResourceKey.isReadableKey.rawValue, url: url)
    }
    
    func dateOfType(type: String, url: NSURL) -> NSDate? {
        var value: AnyObject? = nil
        do {
            try url.getResourceValue(&value, forKey: URLResourceKey(rawValue: type))
            return value as? NSDate
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    func printUrlPropertiesToConsole(url: NSURL) {
        print("URL name = \(String(describing: url.lastPathComponent)) \n")
        print("Is a directory? \(isUrlDirectory(url: url)) \n")
        print("Is readable? \(isUrlReadable(url: url)) \n")
        
        if let createDate = dateOfType(type: URLResourceKey.creationDateKey.rawValue, url: url) {
            print("Creation Date = \(createDate) \n")
        }
        
        if let assessDate = dateOfType(type: URLResourceKey.contentAccessDateKey.rawValue, url: url) {
            print("Access Date = \(assessDate) \n")
        }
        
        if let modificationDate = dateOfType(type: URLResourceKey.contentModificationDateKey.rawValue, url: url) {
            print("Access Date = \(modificationDate) \n")
        }
        
        print("-------------------------------------------")
        
        
    }
    

    func createFolderAtPath(path: String) {
        let fileManger = FileManager()
        do {
            try fileManger.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            print("Create Folder success")
        } catch let error as NSError {
            print(error)
        }
    }
    
    func createFilesInFolder(folder: String) {
        for counter in 1...5 {
            let fileName = NSString(format: "%lu.txt", counter)
            let path = folder.appending(fileName as String)
            let fileContents = "Some text in \(fileName)"
            
            do {
                try fileContents.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                print("Create file success")
            } catch let error as NSError {
                print(error)
            }
        }
    }

    /* 遍历给定路径的全部文件/文件夹 */
    func enumerateFilesInFolder(folder: String) {
        let fileManager = FileManager()
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: folder)
            if contents.count > 0 {
                print("Contents of path \(folder) = \(contents)")
            }
        } catch let error as NSError {
            print(error)
        }
    }

    /* 删除给定路径的全部文件/文件夹 */
    func deleteFilesInFolder(folder: String) {
        let fileManager = FileManager()
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: folder)
            if contents.count > 0 {
                for fileName in contents {
                    let filePath = folder.appending(fileName)
                    do {
                        try fileManager.removeItem(atPath: filePath)
                        print("Successfully removed item at path \(filePath)")
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    /* Delete a folder in a given path */
    func deleteFolderAtPath(path: String) {
        let fileManager = FileManager()
        do {
            try fileManager.removeItem(atPath: path)
            print("Successfully deleted the path \(path)")
        } catch let error as NSError {
            print(error)
        }
    }
    
    func saveObectInFile() {
        let path = NSTemporaryDirectory() + "Person"
        let firstPerson = Person()
        let archiverResult = NSKeyedArchiver.archiveRootObject(firstPerson, toFile: path)
        if archiverResult {
            print("Successfully saved object")
        } else {
            print("Failed saved object")
        }
        
        let secondPerson = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! Person
        
        if firstPerson == secondPerson {
           print("Both persons are the same")
        } else {
          print("Could not read the archive")
        }
        
        
        
    }
}

