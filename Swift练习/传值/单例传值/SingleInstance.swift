//
//  SingleInstance.swift
//  传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
//创建一个单例类
class SingleInstance: NSObject {

    //在单例类中，用一个用来共享数据的数组
    var datas = [String]()
    
    //创建一个静态或者全局变量，保存当前单例的实例值
    fileprivate static let singleInstance = SingleInstance()
    
    //私有化构造方法
    fileprivate override init() {
        //给数组一个原始数据
        datas.append("SI")
    }
    
    //提供一个公开的用来获取单例的方法
    class func defaultSingleInstance() -> SingleInstance {
       //返回初始化好的静态变量的值
        return singleInstance
    }
}
