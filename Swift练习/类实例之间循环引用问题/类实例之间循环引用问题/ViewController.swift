//
//  ViewController.swift
//  类实例之间循环引用问题
//
//  Created by EastElsoft on 2017/5/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var teacher: Teacher?
    var student: Student?
    var school: School?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //测试weak 若引用
        teacher = Teacher(name: "汪老师")
        
        student = Student(name: "张三同学")
        
        teacher?.student = student
        student?.teacher = teacher
        
        teacher = nil
        student = nil
        
        //测试 unowned 无主引用
        
        //使用无主引用时，要特别小心，以防一个对象在释放时一起释放了强引用对象
        student = Student(name: "李四同学")
        school = School(name: "杭州", stu: student!)
        
        student?.school = school
        school?.student = student!
        
        school = nil
        student = nil
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// 1. 弱引用， 在其中一个类中属性或变量声明使用 weak关键字解决循环引用

class Teacher {
    var tName: String = ""
    weak var student: Student? //添加学生对象，初始化时为nil
    
    init(name: String) {
        tName = name
        print("Teacher \(tName) 实例初始化完成。")
    }
    
    func getName() -> String {
        return tName
    }
    
    deinit {
        print("Teaher \(tName) 实例反初始化成功。")
    }
}

class Student {
    var sName: String = ""
    var teacher: Teacher? //添加老师对象，初始化时为nil
    var school: School?
    
    
    init(name: String) {
        sName = name
        print("Student \(sName) 实例化完成。")
    }
    
    func getName() -> String {
        return sName
    }
    
    deinit {
        print("Student \(sName) 实例反初始化成功。")
    }
}

// 2. 无主引用 在变量或属性声明的时候 前面添加关键字 unowned  即为无主引用


/*
   无主引用是非可类型，使用无主引用时不必解包
   但是当无主引用所指实例被释放时，ARC并不能将引用值设置为nil，因为非可选类型不能设置为nil
 
 
 */

class School {
    var sName: String
    unowned var student: Student
    
    init(name: String, stu: Student ) {
        sName = name
        student = stu  //因为是无宿主引用不能设为可选型，所以必须要进行初始化
        print("School \(sName) 实例初始化完成。")
    }
    
    func getName() -> String {
        return sName
    }
    
    deinit {
        print("School \(sName) 实例反初始化完成。")
    }
    
}
