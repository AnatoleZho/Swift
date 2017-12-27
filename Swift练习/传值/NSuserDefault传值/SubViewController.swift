//
//  SubViewController.swift
//  传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    var btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.cyan
        for i in 0..<5 {
            let button = UIButton(type: .system)
            button.setTitle("第\(i + 1)个按钮", for: UIControlState())
            button.frame = CGRect(x: 20, y: CGFloat(150 + i * 100), width: self.view.frame.size.width - 40, height: 100)
            button.tag = 100 + i
               
            button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }

    func buttonAction(_ sender: UIButton) {
        for i in 0..<5 {
            let btn = self.view.viewWithTag(100 + i) as! UIButton
            btn.isSelected = false
        }
        sender.isSelected = true
        
        //使用NSUserDefaults来记录选中的按钮
        //首先获取NSUserDefaults对象，这个对象是一个单例对象
        let userDefaults = UserDefaults.standard
        
        //将按钮的tag做成数据记录
        //开始写入
        userDefaults.set(sender.tag, forKey: "selectedIndex")
        
        //回写文件
        userDefaults.synchronize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let userDefaults = UserDefaults.standard
        let si = userDefaults.integer(forKey: "selectedIndex")
        let tag = (si as AnyObject).int32Value

        if let btnTag = tag {
            NSLog("btnTag=====%d", btnTag)
        }
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
