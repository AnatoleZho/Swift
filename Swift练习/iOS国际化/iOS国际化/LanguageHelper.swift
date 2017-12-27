//
//  LanguageHelper.swift
//  iOS国际化
//
//  Created by EastElsoft on 2017/6/24.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

let UserLanguage = "UserLanguege"
let AppleLanguages = "AppleLanguages"

class LanguageHelper: NSObject {

    static let shareInstance = LanguageHelper()
    let defaults = UserDefaults.standard
    var bundle: Bundle?
    
    class func getString(key: String) -> String {
        let bundle = LanguageHelper.shareInstance.bundle
        let str = bundle?.localizedString(forKey: key, value: nil, table: nil)
        return str!
    }
    
    func initUserLanguage() {
        var string: String = defaults.value(forKey: UserLanguage) as! String
        if string == "" {
            let languages = defaults.object(forKey: AppleLanguages) as! NSArray
            
            if languages.count != 0 {
                let current = languages.object(at: 0) as! String
                if current != "" {
                    string = current
                    defaults.set(current, forKey: UserLanguage)
                    defaults.synchronize()
                }
            }
        }
        string = string.replacingOccurrences(of: "-CN", with: "")
        string = string.replacingOccurrences(of: "-US", with: "")
        var path = Bundle.main.path(forResource: string, ofType: "lproj")
        if path == nil {
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
        }
        bundle = Bundle.init(path: path!)
    }
    
    func setLanguage(language: String) {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        bundle = Bundle.init(path: path!)
        defaults.set(language, forKey: UserLanguage)
        defaults.synchronize()
    }
}
