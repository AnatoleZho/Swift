//
//  ViewController.swift
//  使用iCloud
//
//  Created by EastElsoft on 2017/6/21.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import CloudKit


class ViewController: UIViewController {

    let container = CKContainer.default()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func iCloudDocumentURL() -> URL? {
        let fileManager = FileManager.default
        if let url = fileManager.url(forUbiquityContainerIdentifier: nil) {
            return url.appendingPathComponent("Documents")
        }
        return nil
    }

}

