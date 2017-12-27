//
//  ViewControllerB.swift
//  传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension ViewControllerB {
    //成为观察者的方法
    func becomeObserver() {
        //获取通知中心的单例
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(ViewControllerB.sum), name: NSNotification.Name(rawValue: "又有新数据啦！"), object: nil)
    }

    //观察者相应的方法
    func sum() {
        let datas = ((UIApplication.shared.delegate) as! AppDelegate).datas
        var sum = 0
        
        for i in datas {
            sum += i
        }
        print("视图B计算求和得：\(sum)")
        
    }
}
