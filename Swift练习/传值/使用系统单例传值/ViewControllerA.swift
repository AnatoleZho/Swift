//
//  ViewControllerA.swift
//  传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {

    //用来计数的一个变量
    var n = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //UIApplication 是一个单例类
        //AppDelegate 并不是一个单例类，但是共享的数据放在这个类里
        
        //获取单例
        let application = UIApplication.shared;
        
        //通过这个单例获取AppDelegate这个对象
        let appDelegate = application.delegate as! AppDelegate
        
        //通过这个AppDelegate来操作共享的datas数组
        appDelegate.datas.append("VCA-\(n + 1)")
        print(appDelegate.datas)
        
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
