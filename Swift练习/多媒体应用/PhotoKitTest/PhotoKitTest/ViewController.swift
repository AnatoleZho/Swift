//
//  ViewController.swift
//  PhotoKitTest
//
//  Created by lmy on 16/1/25.
//  Copyright © 2016年 http://www.bjwxhl.com. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBAction  func presentImagePickerSheet() {
        
        // 获取当前应用对照片的访问授权状态
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.presentImagePickerSheet()
                })
            })
            
            return
        }
        
        //允许访问相册
        if authorization == .authorized {
            
            
            let viewCtl  = AllPicController(nibName: "AllPicController", bundle: Bundle.main)
            self.present(viewCtl, animated: true, completion: { () -> Void in
                
            })
        }
        else {
            
            //用户禁止访问相册
            let alertController = UIAlertController(title: "提醒", message: "用户禁止访问相册", preferredStyle: UIAlertControllerStyle.alert)
            
            
            // Create the actions.
            let cancelAction = UIAlertAction(title:  "取消", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) -> Void in
                
            })
            
            
            // Add the actions.
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: { () -> Void in
                
            })
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

