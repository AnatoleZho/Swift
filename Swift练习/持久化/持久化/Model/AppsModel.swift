//
//  AppsModel.swift
//  MVC
//
//  Created by EastElsoft on 2017/5/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit



class AppsModel: NSObject, NSCoding {
   
    //定义模型的三个属性
    var imageName: String!
    var appName: String!
    var appDescription: String!
    
    //自定义便利构造器
    init(imageName imageN: String, appName appN: String, appDescription appD: String) {
        self.imageName = imageN
        self.appName = appN
        self.appDescription = appD
    }
    
    private let M_imageName = "M_imageName"
    private let M_appName = "M_appName"
    private let M_appDescription = "M_appDescription"
    
    //MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.imageName, forKey: M_imageName)
        aCoder.encode(self.appName, forKey: M_appName)
        aCoder.encode(self.appDescription, forKey: M_appDescription)
    }

    required init?(coder aDecoder: NSCoder) {
        imageName = aDecoder.decodeObject(forKey: M_imageName) as! String
        appName = aDecoder.decodeObject(forKey: M_appName) as! String
        appDescription = aDecoder.decodeObject(forKey: M_appDescription) as! String
    }
}
