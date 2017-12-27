//
//  SubViewController.swift
//  传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    //在B界面里，声明一个用来去接收回传对象的变量
    var backVC: ViewController?
    
    let textField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.cyan
        textField.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        textField.borderStyle = .roundedRect
        
        self.view.addSubview(textField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //在页面小时之前，将数据传回
        self.backVC?.label.text = self.textField.text
        self.dismiss(animated: true) { 
            
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
