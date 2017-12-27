//
//  ViewController.swift
//  自定义闭包传值
//
//  Created by EastElsoft on 2017/2/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textLabel.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        textLabel.text = "AB页面自定义闭包传值"
        textLabel.textAlignment = .center
        self.view.addSubview(textLabel)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subVC = SubViewController()
        self.present(subVC, animated: true, completion: nil)
        
        subVC.backValueClusore = {(text: String) -> Void in
               self.textLabel.text = text
            }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

