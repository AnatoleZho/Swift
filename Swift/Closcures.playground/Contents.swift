//: Playground - noun: a place where people can play

import UIKit

/*
 *闭包表达式（Closure Expressions）
 *尾随闭包（Trailing Closure）
 *值捕捉（Capturing Vaules）
 *闭包是引用类型（Closure Are Reference Types）
 *非逃逸闭包（Noneescaping Closure）
 *自动闭包（Autoclosures）
 */

/*
 闭包是自包含的函数代码块,可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块(blocks)以及其他一些编程语言中的匿名函数比较相似。
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭合并包裹着这些常量和变量,俗称 闭包。Swift会为您管理在捕获过程中涉及到的所有内存操作。
 注意
 如果您不熟悉捕获(capturing)这个概念也不用担心
 */

/*
 在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包,闭包采取如下三种形式之一:
 • 全局函数是一个有名字但不会捕获任何值的闭包
 • 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 • 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
 
 
 Swift 的闭包表达式拥有简洁的风格,并鼓励在常见场景中进行语法优化,主要优化如下:
 • 利用上下文推断参数和返回值类型
 • 隐式返回单表达式闭包,即单表达式闭包可以省略 return 关键字 
 • 参数名称缩写
 • 尾随(Trailing)闭包语法
 */

//\\\\\\\\\\\\\\\\闭包表达式（Closure Expressions）
/*
 
 嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式。当然,有时候撰写小巧的没有完整定义和命名的类函数结构也是很有用处的,尤其是在您处理一些函数并需要将另外一些函数作为该函数的参数时。
 闭包表达式是一种利用简洁语法构建内联闭包的方式。闭包表达式提供了一些语法优化,使得撰写闭包变得简单明了。下面闭包表达式的例子通过使用几次迭代展示了 sort(_:) 方法定义和语法优化的方式。每一次迭代都用更 简洁的方式描述了相同的功能。
 */


//sort方法（The Sort Method）
//Swift 标准库提供了名为 sort 的方法,会根据您提供的用于排序的闭包函数将已知类型数组中的值进行排序。一旦排序完成, sort(_:) 方法会返回一个与原数组大小相同,包含同类型元素且元素已正确排序的新数组。    原数组不会被sort(_:) 方法修改。
//sort(_:) 方法接受一个闭包,该闭包函数需要传入与数组元素类型相同的两个值,并返回一个布尔类型值来表明 当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面,排 序闭包函数需要返回 true ,反之返回 false 。

let name = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1:String, s2:String) -> Bool {
    return s1 > s2
}
//如果第一个字符串( s1 )大于第二个字符串( s2 ), backwards(_:_:) 函数返回 true ,表示在新的数组中 应该出现在 s2 前
var reversed = name.sorted(by: backwards)

//闭包表达式语法（Closure Expression Syntax）
//一般表达式
//{ (paremeters) -> returnType in
//     statements
//}

//闭包的函数体部分由关键字 in 引入。该关键字表示闭包的参数和返回值类型定义已经完成,闭包函数体即将开 始。
reversed = name.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

reversed = name.sorted(by: {(s1: String, s2: String) -> Bool in return s1 > s2})

//根据上下文推断类型（Inferring Type From Context）


/*
 因为排序闭包函数是作为 sort(_:) 方法的参数传入的,Swift 可以推断其参数和返回值的类型。 sort(_:) 方法 被一个字符串数组调用,因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断,返回箭头( -> )和 围绕在参数周围的括号也可以被省略
 */
reversed = name.sorted(by: {s1, s2 in return s1 > s2})

//单表达式闭包隐式返回（Implicit Return From Single-Expression Closures）

//单表达式闭包可以通过省略return关键字来隐式返回单行表达式的结果

reversed = name.sorted( by: {s1, s2 in s1 > s2} )

//参数名称缩写 （Shorthand Argument Names）

//Swift 自动为内联闭包提供了参数名称缩写功能,您可以直接通过 $0 , $1 , $2 来顺序调用闭包的参数,以此 类推。

reversed = name.sorted( by: { $0 > $1} )

//运算符函数（Operator Functions）

reversed = name.sorted( by: > )
/*
 Swift 的 String 类型定义了关于大于
 号( > )的字符串实现,其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sort(_:) 方法的第二个参数需要的函数类型相符合。
 */

//\\\\\\\\\\\\\\\\尾随闭包（Trailing Closures）
/*
 如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性。尾
 随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用:
 */

func someFunctionThatTakesAClosure(closure: () -> Void) {
    //函数体部分
}
//使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(){
   //闭包主体部分
}

reversed = name.sorted() { $0 > $1 }

//array中的map(_:)函数
/*
下例介绍了如何在 map(_:) 方法中使用尾随闭包将 Int 类型数组 [16, 58, 510] 转换为包含对应 String 类型的值 的数组 ["OneSix", "FiveEight", "FiveOneZero"] :
*/
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5:"Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]
//如上代码创建了一个数字位和它们英文版本名字相映射的字典。同时还定义了一个准备转换为字符串数组的整型数组

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

//\\\\\\\\\\\\\\\\捕获值（Capturing Values）
/*
闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在,闭包仍然可以在闭包函数体内引用和修改这些值。

Swift 中,可以捕获值的闭包的最简单形式是嵌套函数,也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量
 
makeIncrementor的函数,其包含了一个叫做 incrementor 的嵌套函数。嵌套函数 incrementor() 从上下文中捕获了两个值, runningTotal 和 amount 。捕获这些值之后, makeIncrementor 将 incrementor 作为闭包返回。每次调用 incrementor 时,其会以 amount 作为增量增加 runningTotal 的值。
*/
func makeIncrementer(forIncrement amount: Int)  -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
//函数的返回值从第一个箭头开始
/*
 makeIncrementor 返回类型为 () -> Int 。这意味着其返回的是一个函数,而不是一个简单类型的值。该函数在每次调用时不接受参数,
 makeIncrementor(forIncrement:)函数定义了一个初始值为0的整型变量 runingTotal, 用来保存当前跑步的总数，改值通过incrementor返回
 makeIncrementor(forIncrement:)有一个Int类型的参数，其外部参数名为forIncrement， 内部参数名为amount，该参数便是每次incrementor 被电泳是runingTotal将要增加的量。
 嵌套函数incrementor用来只想实际增加操作。该函数简单的使用rungingTotal 增加amount，并将其返回。
 
 func incrementor() -> Int {
 runningTotal += amount
 return runningTotal
 }
 函数并没有任何参数,但是在函数体内访问了runningTotal和amount变量 函数捕获了 runningTotal和amount变量的引用。捕获引用保证了
 
 为了优化,如果一个值是不可变的,Swift 可能会改为捕获并保存一份对值的拷贝。 Swift 也会负责被捕获变量的所有内存管理工作,包括释放不再需要的变量。
*/
func makeIncrementer1(forIncrement amount: Int) -> () -> Int {
    var runingTotal = 0
    func incrementer() -> Int {
       runingTotal += amount
        return runingTotal
    }
    return incrementer
}
//该例子定义了一个叫做 incrementByTen 的常量,该常量指向一个每次调用会将 runningTotal 变量增加 10 的 ementor 函数。
let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
incrementByTen()
incrementByTen()

//如果您创建了另一个 incrementor ,它会有属于它自己的一个全新、独立的 runningTotal 变量的引用
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()
/*
 注意 
 如果您将闭包赋值给一个类实例的属性,并且该闭包通过访问该实例或其成员而捕获了该实例,您将创建一个在闭包和该实例间的循环强引用。Swift 使用捕获列表来打破这种循环强引用。
 */

//\\\\\\\\\\\\\\\\\\\\\闭包是引用类型（Closures Are Reference types）

/*
 incrementBySeven 和 incrementByTen 是常量,但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
 无论您将函数或闭包赋值给一个常量还是变量,实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中,指向闭包的引用 incrementByTen 是一个常量,而并非闭包内容本身。
 这也意味着如果将闭包赋值给了两个不同的常量或变量,两个值都会指向同一个闭包
 */

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

//\\\\\\\\\\\\\\\\\\\\\非逃逸闭包（Nonescaping Closures）
/*
 当一个闭包作为参数传到一个函数中,但是这个闭包在函数返回之后才被执行,我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时,你可以在参数名之前标注 @noescape ,用来指明这个闭包是不允许“逃 逸”出这个函数的。将闭包标注 @noescape 能使编译器知道这个闭包的生命周期(译者注:闭包只能在函数体中被执行,不能脱离函数体执行,所以编译器明确知道运行时的上下文),从而可以进行一些比较激进的优化。
*/

func someFunctionWithNoescapeClosure( closure: () -> Void) {
    closure();
}
//举个例子, sort(_:) 方法接受一个用来进行元素比较的闭包作为参数。这个参数被标注了 @noescape ,因为它确保自己在排序结束之后就没用了。
/*
 一种能使闭包“逃逸”出函数的方法是,将这个闭包保存在一个函数外部定义的变量中。举个例子,很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回,但是闭包 直到异步操作结束后才会被调用。在这种情况下,闭包需要“逃逸”出函数,因为闭包需要在函数返回之后被调 用。例如:
 */

var completionHandlers:[() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler:@escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
/*
 someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数,该闭包被添加到一个函数外定义的数组中。如果你试图将这个参数标注为 @noescape ,你将会获得一个编译错误。
 将闭包标注为 @noescape 使你能在闭包中隐式地引用 self 。
 将闭包标注为 @escaping 必须在闭包中显式地引用 self .
 */
class SomeClass {
    var x = 10
    func doSomeThing() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNoescapeClosure { x = 200 }
    }
}

let instance = SomeClass()

instance.doSomeThing()
print(instance.x)

completionHandlers.first?()
print(instance.x)


//\\\\\\\\\\\\\\\\\\\\\\\\\自动闭包（Autoclosures）
/*
 自动闭包是一种自动创建的闭包,用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数,当它被调
 用的时候,会返回被包装在其中的表达式的值。这种便利语法让你能够用一个普通的表达式来代替显式的闭
 包,从而省略闭包的花括号。
 我们经常会调用一个接受闭包作为参数的函数,但是很少实现那样的函数。举个例子来说,
 sage:file:line:) 函数接受闭包作为它的 condition 参数和 message 参数;它的 condition 参数仅会在 debug 模式下被求值,它的 message 参数仅当 condition 参数为 false 时被计算求值。
 自动闭包让你能够延迟求值,因为代码段不会被执行直到你调用这个闭包。延迟求值对于那些有副作用(Side Effect)和代价昂贵的代码来说是很有益处的,因为你能控制代码什么时候执行。下面的代码展示了闭包如何延时求值。
 */


var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")

print(customersInLine.count)

/*
 尽管在闭包的代码中, customersInLine 的第一个元素被移除了,不过在闭包被调用之前,这个元素是不会被移除的。如果这个闭包永远不被调用,那么在闭包里面的表达式将永远不会执行,那意味着列表中的元素永远不会被移除。
 请注意, customerProvider 的类型不是 String ,而是 () -> String ,一个没有参数且返回值为 String 的函数。
 
 
 将闭包作为参数传递给函数时,你能获得同样的延时求值行为。
 */
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// 打印出 "Now serving Alex!"


/*
  serveCustomer(_:)接受一个返回顾客名字的显式的闭包。下面这个版本的serveCustomer(_:) 完成了相同的操作,不过它并没有接受一个显式的闭包,而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以 将该函数当做接受String 类型参数的函数来调用。customerProvider 参数将自动转化为一个闭包,因为该参数 被标记了@autoclosure 特性。
 */

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// 打印 "Now serving Ewa!"
/*
 
 注意
 过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行 的。
如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。@escaping 属性的讲解见上面的逃逸闭包。 */

var customerProviders: [() -> String] = []
func collectCustomerProviders( customerProvider: @autoclosure @escaping () -> String ) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customerProvider: customersInLine.remove(at: 0))
collectCustomerProviders(customerProvider: customersInLine.remove(at: 0))
print("Collected \(customerProviders.count) closures")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
/*
 在上面的代码中, collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包,而是将闭包追 加到了 customerProviders 数组中。这个数组定义在函数作用域范围外,这意味着数组内的闭包将会在函数返回之 后被调用。因此, customerProvider 参数必须允许“逃逸”出函数作用域。
 */































