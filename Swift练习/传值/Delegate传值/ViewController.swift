//
//  ViewController.swift
//  Delegate传值
//
//  Created by EastElsoft on 2017/2/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textLabel.frame = CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 50)
        textLabel.text = "AB页面协议传值"
        textLabel.textAlignment = .center
        self.view.addSubview(textLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let subVC = SubViewController()
        self.present(subVC, animated: true, completion: nil)
        subVC.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: BackValueProtocol {
    func backValue(_ text: String, _ color: UIColor) {
        textLabel.text = text
        self.view.backgroundColor = color
    }
}

