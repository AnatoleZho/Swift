//
//  Person.swift
//  文件和文件夹管理
//
//  Created by EastElsoft on 2017/6/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

/* Person 类派生于 NSObject ，因此，使用 @objc(name) 符号来确保该类的名字在 Swift 和 Objective-C 运行时的名字一致，使序列化器可以方便地序列化和反序列化该类 */

@objc(Person) class Person: NSObject, NSCoding {
    var firstName: String
    var lastName: String
    
    struct SerializationKey {
        static let firstName = "firstName"
        static let lastName = "lastName"
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        super.init()
    }
    
    convenience override init() {
        self.init(firstName: "Vandad", lastName: "Nahavandipoor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: SerializationKey.firstName) as!
             String
        self.lastName = aDecoder.decodeObject(forKey: SerializationKey.lastName) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey: SerializationKey.firstName)
        aCoder.encode(self.lastName, forKey: SerializationKey.lastName)
    }
    
    /* 实现一个相等操作符的重载，一般比较两个 Person 类来查看它们是否拥有相同的姓和名，由此推导出它们是否相等 */
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName ? true : false
    }
}
