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
    
    //声明一个闭包
    var backValueClusore: ((_ text: String) -> Void)?
    
    
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
        //直接执行闭包
        self.backValueClusore!(self.textField.text!)
        self.dismiss(animated: true, completion: nil)
        
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
