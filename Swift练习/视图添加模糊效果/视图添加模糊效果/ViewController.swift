//
//  ViewController.swift
//  视图添加模糊效果
//
//  Created by EastElsoft on 2017/5/7.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIBlurEffect 表示效果的类，是UIVisualEffect 的子类， 创建的时候需要传入UIBlurEffectStyle类型的参数值
        
        //UIVisualEffectView 是UIView的子类，接收并并应用UIVisulEffect 类型的诗句效果
        
        //UIBlurEffectStyle 枚举类型 .extraLight  .light  .dark
        
        //另外一个月UIBlurEffect相似的类UIVibrancyEffect 会将后面图层的颜色显示出来，使用弹出框的时候效果比较好
        let blurEffect = UIBlurEffect(style: .light)
        
        
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame.size = CGSize(width: 200, height: 200)
        blurView.center = CGPoint(x: 100, y: view.center.y)
        
        view.addSubview(blurView)
        
        
        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: blurEffect)
        let blurRightView = UIVisualEffectView(effect: vibrancyEffect)
        blurRightView.frame.size = CGSize(width: 200, height: 200)
        blurRightView.center = CGPoint(x: view.center.x, y: view.center.y)
        
        view.addSubview(blurRightView)
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

