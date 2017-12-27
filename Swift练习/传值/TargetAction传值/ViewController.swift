//
//  ViewController.swift
//  TargetAction传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textLabel.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        textLabel.text = "A界面的原始数据"
        textLabel.textAlignment = .center
        self.view.addSubview(textLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subVC = SubViewController()
        subVC.target = self
        subVC.action = NSSelectorFromString("backValue:")
        self.present(subVC, animated: true) {
            
        }
    }
    
    //定义一个用来回传数据的方法
    func backValue(_ string: String) {
        //通过传过来的参数，给label赋值
        textLabel.text = string
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

