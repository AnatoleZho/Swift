//
//  ViewController.swift
//  持久化
//
//  Created by EastElsoft on 2017/5/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userDefaults: UserDefaults!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //两种初始化方法，由于是单例，创建的对象地址是一样的
        userDefaults = UserDefaults.standard
        
        let userDefaultsSuit: UserDefaults! = UserDefaults(suiteName: "SwiftClass")
        print(userDefaults.dictionaryRepresentation())
        print("SwiftClass  \(userDefaultsSuit.dictionaryRepresentation())")
        
        //设置类型：Int、 Float、 Double、 Bool、 URL、 Date 
        userDefaults.set(URL(string: "http:www.baidu.com")!, forKey: "URL")
        //读取
        let urlVaule = userDefaults.url(forKey: "URL")
        print(urlVaule ?? "url is nil")
        
        
        //系统对象实现存储，转换成 Data 作为载体才能可以存储
        //将对象转换成 Data 流
        let imageData: Data! = UIImageJPEGRepresentation(UIImage(named: "南京.jpg")!, 1.0)
    
        userDefaults.setValue(imageData, forKey: "ImageData")
        
        //获取data
        let objData:Data! = userDefaults.object(forKey: "ImageData") as! Data
        print(objData)
        //还原对象，初始一个UIImage对象
        let image: UIImage = UIImage(data: objData)!
        
        
        print(image)
        
        //创建 AppsModel 的实例
        let model: AppsModel = AppsModel.init(imageName: "南京.jpg", appName: "租房点评", appDescription: "租房被骗？ 现在开始，你来改变着一切！《租房点评》为你而备，租房无忧！")
        //实现对象转换成 Data
        let modelData: Data = NSKeyedArchiver.archivedData(withRootObject: model)
        //存储 Dada 对象
        userDefaults.setValue(modelData, forKey: "AppsModel")
        
        let readModelData: Data = userDefaults.object(forKey: "AppsModel") as! Data
        let readModel: AppsModel = NSKeyedUnarchiver.unarchiveObject(with: readModelData) as! AppsModel
        print(readModel.appDescription)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

