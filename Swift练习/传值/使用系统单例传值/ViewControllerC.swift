//
//  ViewControllerC.swift
//  传值
//
//  Created by EastElsoft on 2017/2/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewControllerC: UIViewController {
    var n = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let applicaton = UIApplication.shared
        
        let appDeledate = applicaton.delegate as! AppDelegate
        appDeledate.datas.append("VCC-\(n + 1)")
        print(appDeledate.datas)
        
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
