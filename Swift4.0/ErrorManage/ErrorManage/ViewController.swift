//
//  ViewController.swift
//  ErrorManage
//
//  Created by EastElsoft on 2018/1/27.
//  Copyright © 2018年 AnatoleZho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         iOS 开发中，一些函数和方法不能保证执行完所有的代码后都产生有用的输出，此时可以使用可选型。可选型可以用来表示值缺失，但是当某个操作失败时，最好能得知失败的原因，从而可以做出正确的判断处理。
         */
        
        // 1. 错误抛出
        /*
         在 Swift 中，错误用符合 Error 协议的值表示，这是一个空的协议，表明这个类型可以用作错误处理。 Swift 枚举特别适合把一些列相关的错误组合在一起，同时把一些相关的值和错误关联起来，因此，编译器会为实现 Error 协议的 Swift 枚举类型自动实现相应的合成。
         */
        
       
        
        // 抛出一个错误是指意想不到的事情发生，执行的正常流程无法继续，可以使用 throw 语句来抛出一个错误
       // throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
        
        // 错误抛出通过在函数或方法声明的参数上加上 throw 关键字，表明这个函数或方法可以抛出错误。如果执行一个有返回值的函数或方法，可以把 throw 关键字放在表示返回箭头的前面，语法格式如下：
       // func myMethodReturnInt() throw -> Double
       // 无返回值时抛出异常，语法格式如下：
       // func myMethodReturnInt() throw
        
        // 当调用抛出函数时，在调用前加 try 关键字，辨明幻术可以抛出错误，而且 try 后面的代码将不会执行
        let favoriteSancks = ["Alice": "Chips",
                              "Bob": "Licorice",
                              "Eve": "Pretzels"]
        // 查找某人喜欢的零食，然后尝试买给他。
        func buyFavoriteSnak(person: String, vendingMackine: VendingMachine) throws {
            // 如果列表中没有这个人喜欢的零食，就会购买 "Candy Bar"
            let snackName = favoriteSancks[person] ?? "Candy Bar"
            // 调用之前加上 try 是因为 buyFavoriteSnak 函数也是一个 抛出函数，所以 vend 函数抛出的任何错误都会向上传递到 buyFavoriteSnak 被调用的地方
            try vendingMackine.vend(itemNamed: snackName)
        }
 
        // 2. 错误的捕捉和处理
        /*
         在 Swift 中，调用抛出错误方法需要明确的错误处理。使用 do-catch 机制来获取和处理异常
         do {
           try expression
           statements
         } catch pattern 1 {
            statements
         } catch pattern 2 where condition {
           statements
         }
         
         如果一个错误被抛出，这个错误会被传递到外部域，直到被 catch 分句处理。一个 catch 分句包含一个 catch 关键字，后接一个 pattern 来匹配错误和相应的执行语句。类似于 Switch 语句，编译器会检查 catch 分句能否处理全部的错误。如果能够处理所有的错误情况，就人物这个错误被完全处理。否则，包含这个抛出函数的所在域就要处理这个错误，或者包含这个抛出函数的函数也要用 throws 声明。为保证错误被处理，用一个带有 pattern 的 catch 分句 匹配所有的错误，如果一个 catch 分句没有执行样式，这个分句会陪并绑定任何错误到一个本地 error 常量。
         */
        
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            try buyFavoriteSnak(person: "Alice", vendingMackine: vendingMachine)
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stack")
        } catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded) {
            print("Insurricent funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            
        }
        
        // 3. 错误与可选型
        /*
         在 Swift 中，我们可以通过 try？ 改变抛出的表达来返回一个可选类型的值来处理问题，判断她的值是否为 nil
         */
        func someThrowingFunction() throws -> Int {
            // .....
            return 5
        }
        
        let x = try? someThrowingFunction()
        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
        }
        /* 此时 x, y 都是可选的整数 */
        
        
        // 4. 拦截错误传导
        /*
         在运行时，在几种情况抛出函数，但事实上是不会抛出错误的。在这几种情况下可以通过 try！ 来调用抛出函数或者方法禁止错误传递，并且在运行时将调用包装断言，这样就不会抛出错误。如果真的抛出错误了，会触发运行时如下的错误：
         let photo = try! loadImage(atPath: "./Resource/John Appleseed.jpg")
         */
        
        // 5. 收尾操作
        /*
         在 Swift 中，使用 defer 语句在即将离开当前代码时执行一系列语句，该语句可移植性一些收尾操作，也就是清理工作。而且 defer 语句把执行推迟到当前作用域退出之前，该语句由 defer 关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如 break 或 return 语句，或者通过抛出一个异常。延迟操作的执行顺序和他们的定义顺序相反，也就是说，在第一个语句的 defer 语句中的代码在第二个 defer 语句的代码之后执行。示例如下：
         */
        /*
         func processFile(fileName: String) throws {
             if exists(fileName) {
                let file = open(fileName)
                 defer {
                    close(file)
                 }
                 while let line = try file.readline(){
                    // Work with the file.
                 }
                 // close(file) is called here, at the end of the scope.
             }
         }
         上述代码使用 defer 语句来保证 open 有对应的 close，这个调用不管是否有抛出都会被执行。
         */
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct Item {
    var price: Int // 价格
    var count: Int // 数量
}

class VendingMachine {
    var inventory = ["Candy Bar": Item.init(price: 12, count: 7),
                     "Chips": Item.init(price: 10, count: 4),
                     "Pretzels": Item.init(price: 7, count: 11)]
    var coinsDeposited = 0 // 可以支付的金额为 0
    // 如果贩卖机请求的物品不存在或者买完了、超出投入金额，该方法就会抛出异常
    func vend(itemNamed name: String) throws {
        // 用来绑定 item 常量在库存中对应的值
        guard let item = inventory[name] else {
            // 否则抛出物品不在库存中错误
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        // 当所有的购买条件都满足时，物品才会出售
        coinsDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        print("Dispensing \(name)")
    }
    
}

// 操作自动贩卖机可能出现的错误
enum VendingMachineError: Error {
    case invalidSelection // 物品不存在
    case insufficientFunds(coinsNeeded: Int) // 物品价格高于投入金额，Int 类型数据表示还需要多少钱开完成这次交易
    case outOfStock // 物品已卖完
}


struct PurchaseSnack {
    let name: String
    init(name: String, vendingMachin: VendingMachine) throws {
        try vendingMachin.vend(itemNamed: name)
        self.name = name
    }

    
}













