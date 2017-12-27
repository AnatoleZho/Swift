//
//  ViewController.swift
//  AB面属性反向传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        label.text = "ViewControllerA"
        label.textAlignment = .center
        self.view.addSubview(label)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subVC = SubViewController()
        
        //给B页面的属性赋值，这个赋值的作用是保存回传数据的目标对象
        subVC.backVC = self;
        subVC.textField.text = label.text
        self.present(subVC, animated: true) { 
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

