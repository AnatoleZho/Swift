//
//  ViewController.swift
//  UITextField
//
//  Created by EastElsoft on 2017/5/8.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {

    var textField: UITextField!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LeftView，RightView

        
        

        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
        textField.borderStyle = .roundedRect
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.text = "Sir richard Branson"
        textField.center = view.center
        
        textField.delegate = self
        view.addSubview(textField)
        
        label = UILabel(frame: CGRect(x: 38, y: 61, width: 220, height: 31))
        view.addSubview(label)
        calculateAndDisplayTextFieldLengthWithText(text: textField.text!)
        
        
        //如果userName为空，进入else里面
        guard let userName = textField.text else {
            print("textField.text为空！")
            return
        }
        
        print("%s",userName)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func calculateAndDisplayTextFieldLengthWithText(text: String) {
        var characterOtCharacters  = "Charachter"
        if text.characters.count != 1 {
            characterOtCharacters += "s"
        }
        let stringLength = text.characters.count
        label.text = "\(stringLength) \(characterOtCharacters)"
        
        
    }
    
    // MARK: - 生成分隔线 UITextFiledDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        NSLog("textFieldShouldBeginEditing");
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLog("textFieldDidBeginEditing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NSLog("textFieldShouldEndEditing")
         return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NSLog("textFieldDidEndEditing")
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSLog("shouldChangeCharactersIn")
        
        let text = textField.text;
        
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        NSLog("textFieldShouldClear")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NSLog("%s", #function)
        NSLog("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

