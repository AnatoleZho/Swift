//
//  ViewController.swift
//  SQLite3数据存储读取
//
//  Created by EastElsoft on 2017/5/17.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //数据库复制到 Documents 下
        let path = DadabaseOperations.loadDBPath()
        
        print(path)
        
        //打开数据库
        let dbOperation = DadabaseOperations(dbPath: path)

        //添加一张表
        let createResult = dbOperation.createTable()
        print("create Table Result: \(createResult)")
        
        //插入一条信息，通过 Person 对象来传值
        let person: Person = Person(name: "刘明阳", password:"liumingyang", email: "liumingyang@leadingdo.com", age: 30)
        let addResult = dbOperation.addUser(person)
        print("add user Result: \(addResult)")
        
        //查询
        let personArray:[Person] = dbOperation.readAllUsers()
        print("共搜索到：\(personArray.description)")
        
        //更新
        let updateResult = dbOperation.updateUser(name: "刘明阳", toName: "刘阳明")
        print("update User result：\(updateResult)")
        
        //删除
        let deleteResult = dbOperation.deleteUser(username: "刘阳明")
        print("delete user result: \(deleteResult)")
        
        //关闭数据库
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

