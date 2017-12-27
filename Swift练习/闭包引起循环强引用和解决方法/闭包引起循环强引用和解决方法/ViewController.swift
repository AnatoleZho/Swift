//
//  ViewController.swift
//  闭包引起循环强引用和解决方法
//
//  Created by EastElsoft on 2017/5/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //由于JsonELement 类的实现会在 JsonElement 实例和闭包所使用的默认 asJson 之间造成循环引用
        var paragraph: JsonElement? = JsonElement(name: "p", text: "hello world")
        print(paragraph?.asJson() ?? "text 无值")
        
        //虽然将paragraph设置成 nil， 但是没有打印 deinit 里面的信息， 表示 JsonElement 实例并没有释放
        paragraph = nil
        
        
        var paragraphT: JsonElementT? = JsonElementT(name: "p", text: "hello")
        
        print(paragraphT?.asJson() ?? "text 无值")
        paragraphT = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
 将闭包赋值给一个类实例的某个属性，并且这个闭包体中又使用了类实例，也会发生强引用的循环
 
 这个闭包访问了类实例的属性或是在闭包中调用了实例的某个方法，因为闭包也是引用类型，从而产生了强引用循环。
 
 强引用循环的存在是因为闭包和类都是引用类型
 
 Swift提供了一个优美的解决方案-----闭包捕获列表
 */


/*  
 类 JsonElement 中定义了一个 lazy 属性 asJson 是一个闭包， 这个闭包结合 name 和 text 形成一个 Json 代码字符串。
 
 这个属性类型是 () -> String, 表示一个函数不需要任何参数返回一个字符串值
 */
class JsonElement {
    let name: String
    let jValue: String?
    lazy var asJson: () -> String = {
        if let text = self.jValue {
           return "\(self.name):\(text)"
        } else {
           return "text is nil"
        }
    }
    
    init(name: String, text: String?) {
        self.name = name
        self.jValue = text
        print("初始化闭包")
    }
    
    deinit {
        print("闭包释放")
    }
}

/*
 通过为闭包的一部分定义捕获列表可以解决闭包和类实例之间的强引用循环。
 
 捕获列表定义了在闭包体内 何时捕获 一个或多个引用类型的规则。 像解决两个雷实例之间的强引用循环一样，声明每个捕获引用为弱引用或者无主引用。 捕获列表中的每个元素有有一对 weak/unowned 关键字和类实例 （self 或 someInstance） 的引用组成，这些内容由方括号括起来，并由空格分隔
 */

class JsonElementT {
    let name: String
    let jValue: String?
    
    //将捕获列表放在闭包参数列表和返回类型的前面
    lazy var oneClosure: (Int, String) -> String = {
        [unowned self] (index: Int, stringT: String) -> String in
        return ""
    }
    
    /*
       当闭包和实例之间总是引用对方，并且同时释放时，定义闭包的捕获列表为无主引用。 当捕获引用可能为 nil 时，定义捕获列表为弱引用。弱引用通常是可选型，并且在实例释放后被设置为 nil
     */
    
    //如果闭包没有包含参数列表和返回值，但可以从上下文中推断出来，就可以将捕获列表放在闭包的前面，后面跟关键字 in
    lazy var asJson: () -> String = {
        [unowned self] in //使用无主引用来解决强引用循环
        if let text = self.jValue {
           return "\(self.name):\(text)"
        } else {
           return "text is nil"
        }
    }
    
    init(name: String, text: String?) {
        self.name = name
        self.jValue = text
        print("初始化闭包完成。")
    }
    
    deinit {
        print("闭包释放")
    }
}
