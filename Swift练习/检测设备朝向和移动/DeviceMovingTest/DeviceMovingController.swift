//
//  DeviceMovingController.swift
//  SwiftClassP2
//
//  Created by LiuMingYang on 14-10-29.
//  Copyright (c) 2014年 ___http://www.iphonetrain.com___. All rights reserved.
//

import UIKit
import CoreMotion




class DeviceMovingController: UIViewController {
    
    
    @IBOutlet var xLabel:UILabel!
    @IBOutlet var yLabel:UILabel!
    @IBOutlet var zLabel:UILabel!
    
    @IBOutlet var orientationLabel:UILabel!
    
    //加速计管理者-所有的操作都会由这个motionManager接管
    var motionManager:CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------ CoreMotion 加速计
        motionManager = CMMotionManager()//注意CMMotionManager不是单例
        motionManager.accelerometerUpdateInterval = 0.1//设置读取时间间隔
        
        if motionManager.isAccelerometerAvailable//判断是否可以使用加速度计
        {
            //获取主线程并发队列,在主线程里跟新UI
            
            motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
                guard let accelerometerData = accelerometerData else { return }
                if error != nil
                {
                    self.motionManager.stopAccelerometerUpdates()//停止使用加速度计
                }else {
                    
                    self.xLabel.text = "x:\(accelerometerData.acceleration.x)"
                    self.yLabel.text = "Y:\(accelerometerData.acceleration.y)"
                    self.zLabel.text = "Z:\(accelerometerData.acceleration.z)"
                }
            }

            
            
            
        } else {
            let aler = UIAlertView(title: "您的设备不支持加速计", message: nil, delegate: nil, cancelButtonTitle: "OK")
            aler.show()
        }
        
        
        
        //感知设备方向-开启监听设备方向
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        //添加通知，监听设备方向改变
        NotificationCenter.default.addObserver(self, selector: #selector(DeviceMovingController.receivedRotation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //关闭监听设备方向
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 判断设备方向代理方法
    func receivedRotation()
    {
        let device = UIDevice.current
        
        if device.orientation == UIDeviceOrientation.unknown
        {
            orientationLabel.text = "Unknown"
        }
        else if device.orientation == UIDeviceOrientation.portrait
        {
            orientationLabel.text = "Portrait"
        }
        else if device.orientation == UIDeviceOrientation.portraitUpsideDown
        {
             orientationLabel.text = "PortraitUpsideDown"
        }
        else if device.orientation == UIDeviceOrientation.landscapeLeft
        {
             orientationLabel.text = "LandscapeLeft"
        }
        else if device.orientation == UIDeviceOrientation.landscapeRight
        {
             orientationLabel.text = "LandscapeRight"
        }else if device.orientation == UIDeviceOrientation.faceUp
        {
             orientationLabel.text = "FaceUp"
        }
        else  if device.orientation == UIDeviceOrientation.faceDown
        {
             orientationLabel.text = "FaceDown"
        }
    }
    
    // MARK: - 摇晃事件
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        
        print("motionBegan")//开始摇晃
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        print("motionEnded")//摇晃结束
    }
    
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        print("motionCancelled")//摇晃被意外终止
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
