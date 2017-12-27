//
//  ViewControllerA.swift
//  传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //在这里，向数据源中去增加数据，并发送通知
        let num = arc4random_uniform(100)
        print(num)
        //获取数据
        ((UIApplication.shared.delegate) as! AppDelegate).datas.append(Int(num))

        //获取通知中心
        let notificationCenter = NotificationCenter.default
        //发送通知
        notificationCenter.post(name: Notification.Name(rawValue: "又有新数据啦！"), object: nil)
        
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

