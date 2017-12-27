//
//  Person.swift
//  SQLite3数据存储读取
//
//  Created by EastElsoft on 2017/5/17.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import Foundation

class Person {
    var name: String?
    var password: String?
    var email: String?
    var age: Int?

    init() {}
    
    init(name: String, password: String, email: String, age: Int) {
        self.name = name
        self.password = password
        self.email = email
        self.age = age
    }
}
