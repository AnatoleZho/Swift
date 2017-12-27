
//
//  CityTableViewController.swift
//  SearchController
//
//  Created by EastElsoft on 2017/5/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController, UISearchResultsUpdating {

    //显示城市的数组
    var cityArray: NSArray = NSArray()
    //搜索类
    var searchController: UISearchController!
    //搜索结果数组
    var searchResults: NSMutableArray = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "CityData", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        
//        do{
//            let result = try? JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
//            print(result ?? "")
//        }catch {
//            print(error.localizedDescription)  //注意这里:error是抛出的Error对象，这个对象没有通过var error:Error创建，在catch的大括号里直接就能拿到，如果想要取得错误信息，直接处理error就可以，这一点真的有点奇葩，这也是我前面说的网上大多数资料都没说清楚的地方，也可能是我比较渣的原因。。。
//        }
        
        //try! ...这种写法适用确定一定会成功的情况，不用写do{}catch{}，需要确定一定不会出现有异常抛出的情况，这种写法建议不要用或者少用。
//        let array = try! JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
        //try? ...与上面的写法类似，不同的地方在于，当有错误或者异常时不会抛出异常，而是给结果反回nil，这种写法适用于不需要处理异常的情况，成功就返回结果，失败返回nil，忽略异常信息。
        let arrayA = try? JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
     
        self.cityArray = arrayA as! NSArray
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        //初始化结果类
        let viewCtl: SearchResultTableViewController = storyBoard.instantiateViewController(withIdentifier: "SearchResultTableViewController") as! SearchResultTableViewController
        
        //初始化UINavigationController
        let navCtl: UINavigationController = UINavigationController(rootViewController: viewCtl)
        
        //通过UINavigationController来初始化UISearchController
        searchController = UISearchController(searchResultsController: navCtl)
        
        //设置搜索代理
        searchController.searchResultsUpdater = self
        
        //设置搜索框frame
        searchController.searchBar.frame = CGRect(
                                                    x: searchController.searchBar.frame.origin.x,
                                                    y: searchController.searchBar.frame.origin.y,
                                                    width: searchController.searchBar.frame.size.width,
                                                    height: 44.0);
        
        tableView.tableHeaderView = searchController.searchBar
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "CELLIDENTIFIER"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)

        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
            cell?.selectionStyle = .none
            cell?.backgroundView?.backgroundColor = UIColor.clear
            cell?.accessoryType = UITableViewCellAccessoryType.none
        }
        let dic: NSDictionary = cityArray.object(at: indexPath.row) as! NSDictionary
        
        cell?.textLabel?.text = dic.object(forKey: "name") as? String

        return cell!
    }

    //MAEK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        //获取搜索内容
        let searchString = self.searchController.searchBar.text
        
        //搜索方法
        self.updateFilteredContent(for: searchString!)
        
        //判断搜索界面存在
        if self.searchController.searchResultsController != nil {
            let navController: UINavigationController = (self.searchController.searchResultsController as? UINavigationController)!
            
            //获取搜索界面
            let vc: SearchResultTableViewController = navController.topViewController as! SearchResultTableViewController
            
            //设置搜索结果
            vc.searchResults = self.searchResults
            
            vc.tableView.reloadData()
            
            
        }
        
    }
    
    //搜索方法实现
    func updateFilteredContent(for cityName: String) {
        //删除之前所有的搜索内容
        self.searchResults.removeAllObjects()
        
        //如果搜索内容为空，显示全部成功
        if cityName == "" {
            self.searchResults.addObjects(from: cityArray as [AnyObject])
        } else {
            //搜索名称匹配的城市
            for i in 0..<self.cityArray.count  {
                let dic: NSDictionary = cityArray.object(at: i) as! NSDictionary

                let oneName: String = (dic.object(forKey: "name") as? String)!

                if oneName.contains(cityName) {
                    self.searchResults.add(oneName)
                }
            }
        }
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
