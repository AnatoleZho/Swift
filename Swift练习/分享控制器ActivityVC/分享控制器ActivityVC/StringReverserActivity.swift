//
//  StringReverserActivity.swift
//  分享控制器ActivityVC
//
//  Created by EastElsoft on 2017/5/7.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit


class StringReverserActivity : UIActivity {
   //用于存储传递过来需要分享的数据
    var text: String!
    var url: URL!
    var image: UIImage!
    
    //重写UIActivity类中的属性方法
    //1.显示在分享框里面的名称
    override var activityTitle: String? {
       return "息烽"
    }
    
    //2.分享框中的图片
    override var activityImage: UIImage? {
       return UIImage(named: "xifeng.png")
    }
    
    //分享类型，在UIActivityViewController.completionHandler回调里可以用于判断，一般取当前类名
    override var activityType: UIActivityType? {
        return  UIActivityType(rawValue: StringReverserActivity.self.description())
    }
    
    //按钮类型（分享按钮：在第一行，彩色，动作按钮：在第二行，黑白）
    override class var activityCategory:UIActivityCategory {
       return .share
    }
    
    //是否显示分享按钮，这里一般根据用户是否授权，或分享内容是否正确来等决定是否要隐藏分享按钮
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if item is UIImage {
                return true
            }
            if item is URL {
                return true
            }
            if item is String {
                return true
            }
        }

        return false
    }

    //解析分享数据时调用，可以进行一定的处理
    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if item is UIImage {
                image = item as! UIImage
            }
            if item is String {
                text = item as! String
            }
            if item is URL {
                url = item as! URL
            }
        }
    }
    
    //执行分享行为
    //这里根据自己的应用做相应的处理
    //例如你可以分享到另外的app例如微信分享，也可以保存数据到照片或其他地方，甚至分享到网络
    override func perform() {
        print("performAtivity: xifeng")
        //具体的执行代码在这里先省略
        
        activityDidFinish(true)
    }
    
    //分享是调用
    override var activityViewController: UIViewController? {
        print("activityViewController: xifeng")
        return nil
    }
    
    //分享完成后调用
    override func activityDidFinish(_ completed: Bool) {
        
        print("activityDidFinish: xifeng")
    }

    //解析分享数据时调用，可以进行一定的处理

    
    
    //是否显示分享按钮，这里一般根据用户是否授权,或分享内容是否正确等来决定是否要隐藏分享按钮


    
    
    
    
}
