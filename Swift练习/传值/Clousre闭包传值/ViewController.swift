//
//  ViewController.swift
//  Clousre闭包传值
//
//  Created by EastElsoft on 2017/2/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //使用系统自带的闭包传值，这种传值方式传值会有延迟，因为在执行完界面切换之后再去进行传值
    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textLabel.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        textLabel.text = "AB页面闭包传值"
        textLabel.textAlignment = .center
        self.view.addSubview(textLabel)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subVC = SubViewController()
        self.present(subVC, animated: true) { 
            subVC.vc = self
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

