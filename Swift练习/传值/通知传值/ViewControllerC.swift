//
//  ViewControllerC.swift
//  传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewControllerC: UIViewController {

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

extension ViewControllerC {
    
    //成为观察者的方法
    func becomeObserber() {
        //首先获取通知中心的单例
        let notificationCenter = NotificationCenter.default
        //向通知中心加入观察者
        notificationCenter.addObserver(self, selector: #selector(ViewControllerC.avg), name: NSNotification.Name(rawValue: "又有新数据啦！"), object: nil)
        
    }
    func avg() {
        let datas = ((UIApplication.shared.delegate)as!AppDelegate).datas
        var sum = 0
        for i in datas {
            sum += i
        }
        print("视图C计算平均值：\(sum / datas.count)")
    }
    
}
