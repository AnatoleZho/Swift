//
//  ViewController.swift
//  NSuserDefault传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //输出家目录地址
        print(NSHomeDirectory())
        //NSUserDefaults是一个系统对plist文件封装好的一个类，在HomeDirectory/Library/preferences/xxx.userdefaults.plist
        //可以通过类来进行对这个文件进行读写
        
        self.view.backgroundColor = UIColor.red
        label.frame = CGRect(x: 20, y: 200, width: self.view.frame.size.width - 40, height: 50)
        label.textAlignment = .center
        self.view.addSubview(label)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subVC = SubViewController()
        self.present(subVC, animated: true) {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //获取NSUserDefaults
        let userDefaults = UserDefaults.standard
        
        //取出数据
        let si = userDefaults.integer(forKey: "selectedIndex")
        let tag = (si as AnyObject).int32Value
        
        //直接修改label的值
        if let btnTag = tag {
            self.label.text = "第\(btnTag - 99)个按钮是选中状态"
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

