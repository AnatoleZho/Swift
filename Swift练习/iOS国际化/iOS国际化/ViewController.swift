//
//  ViewController.swift
//  iOS国际化
//
//  Created by EastElsoft on 2017/6/23.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage(notification:)), name: NSNotification.Name.init("LanguageChanged"), object: nil)
        
        button.setTitle(NSLocalizedString("test1", comment: ""), for: .normal)
        label.text = NSLocalizedString("test2", comment: "")

    }

    func changeLanguage(notification: Notification) {
        button.setTitle(LanguageHelper.getString(key: "test1"), for: .normal)
        label.text = LanguageHelper.getString(key: "test2")
        
    }
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        LanguageHelper.shareInstance.setLanguage(language: "en")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)

    }
    
  
    @IBAction func changeLanguage1(_ sender: UIButton) {
        LanguageHelper.shareInstance.setLanguage(language: "zh-Hans")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

