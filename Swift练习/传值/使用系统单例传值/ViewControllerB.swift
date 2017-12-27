//
//  ViewControllerB.swift
//  传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {
    
    var n = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let application = UIApplication.shared
        let appDelegate = application.delegate as! AppDelegate
        
        appDelegate.datas.append("VCB-\(n + 1)")
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
