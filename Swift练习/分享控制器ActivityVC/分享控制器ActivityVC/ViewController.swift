//
//  ViewController.swift
//  分享控制器ActivityVC
//
//  Created by EastElsoft on 2017/5/7.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var textField: UITextField!
    var buttonShare: UIButton!
    var activityViewController: UIActivityViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField()
        createButtonShare()
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonAction(_:)))
        
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func rightBarButtonAction(_ sender: UIButton) {
        print(".........")
    }
    
    func createTextField() {
        textField = UITextField(frame: CGRect(x: 20, y : 35, width: 280, height: 30))
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text to share...."
        textField.delegate = self
        view.addSubview(textField)
    }
    
    func createButtonShare() {
        buttonShare = UIButton(type: .system)
        buttonShare.frame = CGRect(x: 20, y: 80, width: 280, height: 44)
        buttonShare.setTitle("分享", for: .normal)
        buttonShare.addTarget(self, action: #selector(handleShare(sender:)), for: .touchUpInside)
        view.addSubview(buttonShare)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func handleShare(sender: UIButton) {
        if (textField.text?.isEmpty)! {
            let message = "Please enter a text and then press Share"
            
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            return

        }
        
        let items:[Any] = ["航歌", UIImage(named: "toSendImage.jpg")!, URL(fileURLWithPath:"http:hangge.com")]
        
        let acts = [WeChatActivity(), HanggeActivity(), StringReverserActivity()]
        
        
        
        
        /*将String 转换成NSString 否则控制器不能显示合适的分享选项*/
        
//        activityViewController = UIActivityViewController(activityItems: [textField.text! as NSString], applicationActivities:nil)
                activityViewController = UIActivityViewController(activityItems: items, applicationActivities:acts)

        
        self.present(activityViewController, animated: true) { 
            
        }
    }
    
    
}


