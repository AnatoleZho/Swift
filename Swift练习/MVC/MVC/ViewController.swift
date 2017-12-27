//
//  ViewController.swift
//  MVC
//
//  Created by EastElsoft on 2017/5/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //定义数组
    var  items: [AppsModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //定义三个模型对象
        let model1:AppsModel = AppsModel(imageName: "appIcon1.png", appName: "Football Maze", appDescription: "足球迷宫，迷宫的新玩法，益智虚拟迷宫游戏。快来挑战你的空间想象，足球迷宫带你到一个不同的世界… 迷宫大家都在玩，你还在等什么。")
        let model2:AppsModel = AppsModel(imageName: "appIcon2.png", appName: "租房点评", appDescription: "租房被骗？现在开始，你来改变这一切！《租房点评》为你而备，租房无忧！")
        let model3:AppsModel = AppsModel(imageName: "appIcon3.png", appName: "iJump", appDescription: "摇动手机，松鼠就可以运动啦，越跳越高，注意会有虫子咬坏跳板哦，祝你玩得开心")
        let model4:AppsModel = AppsModel(imageName: "appIcon4.png", appName: "哪里逃", appDescription: "哪里逃 是一款躲避类游戏，拖动美女图片，躲避，追来的帅锅，帅锅人数越来越多，不要被追到哦。")
        
        items = [model1, model2, model3, model4]
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CELLIDENTIFIER"
        
        var cell: TableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell
        
        if cell == nil {
            cell = TableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        let cellModel: AppsModel = items[indexPath.row]
        
        cell?.showAppInfo(with: cellModel)
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

