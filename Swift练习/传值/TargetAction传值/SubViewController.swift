//
//  SubViewController.swift
//  传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    //用来去接收传值的目标是任意目标
    var target: AnyObject?
    
    //用来去接收传值的方法
    var action: Selector?
    
    let textField = UITextField()
    

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
        //B界面根本不需要考虑传值的目标和方法具体是谁，直接去掉用自己的属性即可
        //这种方法称为回调，让目标调用目标的方法，参数为传入的textFiled的值
//        self.target?.perform(self.action!, with: self.textField.text)
        self.target?.performSelector(inBackground: self.action!, with: self.textField.text)
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
