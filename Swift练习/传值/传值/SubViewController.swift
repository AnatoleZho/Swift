//
//  SubViewController.swift
//  传值
//
//  Created by EastElsoft on 2017/2/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    var vc: ViewController?
    
    @IBOutlet weak var isSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        isSwitch.isOn = self.vc?.isStatusLabel.text == "ON" ? true : false
        isSwitch.addTarget(self, action: #selector(self.switchAction), for: .valueChanged)
    }
    
    func switchAction() {
        //判断状态
        if isSwitch.isOn {
            isSwitch.isOn = false
        } else {
            isSwitch.isOn = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //判断状态
        
        self.vc?.isStatusLabel.text = isSwitch.isOn ? "ON" : "OFF"
        
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
