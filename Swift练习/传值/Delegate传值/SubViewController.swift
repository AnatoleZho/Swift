
//
//  SubViewController.swift
//  传值
//
//  Created by EastElsoft on 2017/2/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

//在B页面中制定协议

protocol BackValueProtocol {
    //制定一个没有返回值，但是有一个参数的协议方法
    func backValue(_ text: String, _ color: UIColor)
}

class SubViewController: UIViewController {

    let textFiled = UITextField()
    //声明一个属性，用来接受一个遵守了回传数据协议的代理
    var delegate:  BackValueProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.cyan
        textFiled.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 40, height: 50)
        textFiled.borderStyle = .roundedRect
        textFiled.layer.borderWidth = 1
        self.view.addSubview(textFiled)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let color = UIColor.red
        self.delegate?.backValue(self.textFiled.text!, color)
        self.dismiss(animated: true, completion: nil)
        
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
