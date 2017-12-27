//
//  SubViewController.swift
//  传值
//
//  Created by EastElsoft on 2017/2/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    let textField = UITextField()
    //接收属性
    var vc: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        self.view.backgroundColor = UIColor.cyan
        textField.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        self.view.addSubview(textField)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.dismiss(animated: true) { 
        //利用系统闭包来回传数据
        self.vc?.textLabel.text = self.textField.text
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
