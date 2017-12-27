//
//  ViewController.swift
//  MultiTouchTest
//
//  Created by lmy on 16/1/1.
//  Copyright © 2016年 http://www.bjwxhl.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //点击事件
        let atap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapDo(_:)))
        self.view.addGestureRecognizer(atap)
        atap.numberOfTapsRequired = 1 //单击次数
        atap.numberOfTouchesRequired = 1 //手指个数
        
        //拖动事件
        let aPan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlenPan(_:)))
        self.view.addGestureRecognizer(aPan)
        aPan.minimumNumberOfTouches = 1 //最少手指个数
        aPan.maximumNumberOfTouches = 3 //最多手指个数
        
        //长按事件
        let aLongPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(_:)))
        self.view.addGestureRecognizer(aLongPress)
        aLongPress.minimumPressDuration = 1 //需要长按的时间，最小0.5s
        
        //捏合事件
        let aPinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinchDo(_:)))
        self.view.addGestureRecognizer(aPinch)
        
        //旋转事件
        let aRotation = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotatePiece(_:)))
        self.view.addGestureRecognizer(aRotation)
        
        //轻扫事件--左轻扫
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwipe(_:)))
        self.view.addGestureRecognizer(leftSwipe)
        leftSwipe.direction =  UISwipeGestureRecognizerDirection.left
        
        //轻扫事件--右轻扫
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.rightSwipe(_:)))
        self.view.addGestureRecognizer(rightSwipe)
        rightSwipe.direction =  UISwipeGestureRecognizerDirection.right
        
        //轻扫事件--上轻扫
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.upSwipe(_:)))
        self.view.addGestureRecognizer(upSwipe)
        upSwipe.direction =  UISwipeGestureRecognizerDirection.up
        
        //轻扫事件--下轻扫
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.downSwipe(_:)))
        self.view.addGestureRecognizer(downSwipe)
        downSwipe.direction =  UISwipeGestureRecognizerDirection.down
    }
    
    
    
    //触摸事件
    
    //手指首次触摸到屏幕
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesBegan")
        
        //获取touches数量
        let numTouches = touches.count
        
        //获取点击屏幕的次数
        let tapTouches = ((touches as NSSet).anyObject() as AnyObject).tapCount
        
        //获取事件发生时间
        let timestamp = event!.timestamp
        
        //获取当前相对于self.view的坐标
        let locationPoint = ((touches as NSSet).anyObject() as AnyObject).location(in: self.view)
        
        //获取上一次相对于self.view的坐标
        let previousPoint = ((touches as NSSet).anyObject() as AnyObject).previousLocation(in: self.view)
        
        //允许使用手势
        self.view.isUserInteractionEnabled = true
        
        //支持多点触摸
        self.view.isMultipleTouchEnabled = true
        
        print("\(tapTouches)")
        
        
        //判断如果有两个触摸点
        if touches.count == 2
        {
            //获取触摸集合
            let twoTouches = (touches as NSSet).allObjects
            
            //获取触摸数组
            let first:UITouch = twoTouches[0] as! UITouch //第1个触摸点
            let second:UITouch = twoTouches[1]as! UITouch //第2个触摸点
            
            //获取第1个点相对于self.view的坐标
            let firstPoint:CGPoint = first.location(in: self.view)
            
            //获取第1个点相对于self.view的坐标
            let secondPoint:CGPoint = second.location(in: self.view)
            
            //计算两点之间的距离
            let deltaX = secondPoint.x - firstPoint.x;
            let deltaY = secondPoint.y - firstPoint.y;
            let initialDistance = sqrt(deltaX*deltaX + deltaY*deltaY )
            
            print("两点间距离是：\(initialDistance)")
        }
    }
    
    //手指在移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesMoved")
    }
    
    //触摸结束
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesEnded")
    }
    
    //触摸意外终止
    //模拟器演示：鼠标拖动的同时，按键盘command+shift+h 相当于点击手机home键，退出应用，触发touchesCancelled事件，在打电话、等情况下也会触发
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesCancelled")
    }
    
    
    
    
    
    
    //手势
    
    //点击事件
    func tapDo(_ sender:UITapGestureRecognizer)
    {
        
        print("点击事件")
    }
    
    //拖动事件
    func handlenPan(_ sender:UIPanGestureRecognizer)
    {
        print("拖动事件")
        
        if sender.state == .began
        {
            //拖动开始
        }
        else if sender.state == .changed
        {
            //拖动过程
        }
        else if sender.state == .ended
        {
            //拖动结束
        }
    }
    
    //长摁事件
    func longPress(_ sender:UILongPressGestureRecognizer)
    {
        print("长摁事件")
        
        
    }
    
    //捏合事件
    func pinchDo(_ sender:UIPinchGestureRecognizer)
    {
        print("捏合")
    }
    
    //旋转事件
    func rotatePiece(_ sender:UIRotationGestureRecognizer)
    {
        print("旋转")
    }
    
    
    //轻扫事件--左轻扫
    func leftSwipe(_ sender:UISwipeGestureRecognizer)
    {
        print("左轻扫")
    }
    
    //轻扫事件--右轻扫
    func rightSwipe(_ sender:UISwipeGestureRecognizer)
    {
        print("右轻扫")
    }
    
    //轻扫事件--上轻扫
    func upSwipe(_ sender:UISwipeGestureRecognizer)
    {
        print("上轻扫")
    }
    
    //轻扫事件--下轻扫
    func downSwipe(_ sender:UISwipeGestureRecognizer)
    {
        print("下轻扫")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

