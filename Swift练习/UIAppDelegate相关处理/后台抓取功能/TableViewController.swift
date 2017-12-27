//
//  TableViewController.swift
//  UIAppDelegate相关处理
//
//  Created by EastElsoft on 2017/5/25.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //2.5
    var mustReloadView = false
    
    //2.6 /* 从委托中得到数据 */
    var newsItems: [NewsItem]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.newsItems
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //2.7 /* 监听数据的改变 */
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewItemsChange(_:)), name: NSNotification.Name(rawValue: AppDelegate.newsItemsChangedNotification()), object: nil)
        
        //2.8 /* 当应用返回前台时处理的事件 */
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppIsBroughtToForground(_:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    //2.8 /* 如果返回前台需要重新加载，执行以下代码 */
    func handleAppIsBroughtToForground(_ notification: Notification) {
        if mustReloadView {
            tableView.reloadData()
        }
    }
    
    //2.9 /* 被告知有新的可用数据，重新加载表格视图 */
    func handleNewItemsChange(_ notification: Notification) {
        if self.isBeingPresented {
            tableView.reloadData()
        } else {
            mustReloadView = true
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        cell.textLabel?.text = newsItems[indexPath.row].text

        return cell
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
