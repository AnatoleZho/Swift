//
//  ViewController.swift
//  使用TouchID验证用户
//
//  Created by EastElsoft on 2017/5/26.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

import LocalAuthentication


class ViewController: UIViewController {

    @IBOutlet weak var checkTouchIDBTN: UIButton!
    
    @IBOutlet weak var useTouchIDBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkTouchIDAvailibility(_ sender: Any) {
        let context = LAContext()
        
        var error: NSError?
        
        let isTouchIDAvailable = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        useTouchIDBTN.isEnabled = isTouchIDAvailable
        
        /* Touch ID 不可用情况 */
        if isTouchIDAvailable == false{
            let alertController = UIAlertController.init(title: "Touch ID", message: "Touch ID is not avilable", preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            let alertController = UIAlertController.init(title: "Touch ID", message: "Touch ID is avilable", preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)        }
    }

    @IBAction func useTouchID(_ sender: Any) {
        let context = LAContext()
        let reason = "Please authenticate with Touch ID" + "to access your private information"
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
            if success {
                print("用户已经通过验证")
            } else {
                let theError = error! as NSError
                print(theError);
                print(theError.code);
                print("errorStr ======\(String(describing: theError.userInfo[NSLocalizedDescriptionKey]))");
                if (theError.code == -2) {//点击了取消按钮
                    print("点击了取消按钮");
                }else if (theError.code == -3){//点输入密码按钮
                    print("点输入密码按钮");
                }else if (theError.code == -1){//连续三次指纹识别错误
                    print("连续三次指纹识别错误");
                }else if (theError.code == -4){//按下电源键
                    print("按下电源键");
                }else if (theError.code == -8){//Touch ID功能被锁定，下一次需要输入系统密码
                    print("Touch ID功能被锁定，下一次需要输入系统密码");
                }
                NSLog("未通过Touch Id指纹验证");
            }

        }
        
        
    }

}

