//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\枚举（Enumerations）
/*
 • 枚举语法(Enumeration Syntax)
 • 使用 Switch 语句匹配枚举值(Matching Enumeration Values with a Switch Statement) 
 • 关联值(Associated Values)
 • 原始值(Raw Values)
 • 递归枚举(Recursive Enumerations)
 */

//枚举为一组相关的值定义了一个共同的类型,可以在代码中以类型安全的方式来使用这些值。

//Swift 中的枚举更加灵活,不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值(称为“原始”值),则该值的类型可以是字符串,字符,或是一个整型值或浮点数。

//枚举成员可以指定任意类型的关联值存储到枚举成员中,就像其他语言中的联合体(unions)和变体(var iants)。每一个枚举成员都可以有适当类型的关联值。
/*
 
 在 Swift 中,枚举类型是一等(first-class)类型。它们采用了很多在传统上只被类(class)所支持的特 性,例如计算型属性(computed properties),用于提供枚举值的附加信息,实例方法(instance method s),用于提供和枚举值相关联的功能。枚举也可以定义构造函数(initializers)来提供一个初始值;可以在原始实现的基础上扩展它们的功能;还可以遵守协议(protocols)来提供标准的功能。
 */

enum SomeEnumeration {
    //枚举定义放在这里
}

enum CompassPoint {
    case North
    case South
    case East
    case West
}
/*
 枚举中定义的值(如 North , South , East 和 West )是这个枚举的成员值(或成员)。你使用 case 关键字来定义一个新的枚举成员值。
 注意
 与 C 和 Objective-C 不同,Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的 CompassPoint 例子中, North , South , East 和 West 不会被隐式地赋值为 0 , 1 , 2 和 3 。相反,这些枚举成员本身就是完备的值,这些值的类型是已经明确定义好的 CompassPoint 类型。
 */

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Sarurn, Uranus
}

//每个枚举定义了一个全新的类型。像 Swift 中其他类型一样,它们的名字(例如 CompassPoint 和 Planet )必须 以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字,以便于读起来更加容易理解:

var directionToHead = CompassPoint.West
//directionToHead 的类型可以在被CompassPiont的某个值初始化时推断出来，一旦directionToHead 被声明为CompassPoint类型，可以使用更短的点语法将其设置为另一个CompassPoint的值
directionToHead  = .East

//当 directionToHead 的类型已知时,再次为其赋值可以省略枚举类型名。在使用具有显式类型的枚举值时,这种 写法让代码具有更好的可读性。


//\\\\\\\使用Switch语句匹配枚举值
//使用switch匹配单个枚举值：
directionToHead = .South

switch directionToHead {
case .North:
        print("Lots of planets have a north")
case .South:
      print("Watch out of penguins")
case .East:
      print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}


let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// 输出 "Mostly harmless”


//\\\\\\\\\\\关联值（Associated Values）
/*
 可以定义 Swift 枚举来存储任意类型的关联值,如果需要的话,每个枚举成员的关联值类型可以各不相同。枚举的这种特性跟其他语言中的可识别联合(discriminated unions),标签联合(tagged unions),或者变 体(variants)相似。
 */

//在Swift中，使用如下方式定义两种商品条形码的枚举：

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

//“定义一个名为 Barcode 的枚举类型,它的一个成员值是具有 (Int,Int,Int,Int) 类型关联值的 UPCA ,另一 个成员值是具有 String 类型关联值的 QRCode 。”

//这个定义不提供任何  Int 或 String  类型的关联值,它只是定义了,当Barcode 常量和变量等于 Barcode.UPCA 或Barcode.QRCode 时,可以存储的关联值的类型。
//创建一个名为productBarcode的变量，并将Barcode.UPCA赋值给它，关联的元组为(8, 85909, 51226, 3)
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

productBarcode = .QRCode("ABDCFGBFEDFWVRFSDVBFD")

//这时,原始的 和其整数关联值被新的 Barcode.UPCA  和其整数关联值被新的Barcode.QRCode 和其字符串关联值所替代。 Barcode  类型的常量和变量可以存储一个 .UPCA 或者一个 .QRCode   (连同它们的关联值),但是在同一时间只能存储这两个值中 的一个。

switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case .QRCode(let productCode):
    print("QR code: \(productCode)")
}

//如果一个枚举成员的所有关联值都被提取为常量,或者都被提取为变量,为了简洁,你可以只在成员名称前标注 一个 或者 :
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .QRCode(productCode):
    print("QR code: \(productCode)")
}

//\\\\\\\\\\\\\原始值（Raw Values）
//在关联值小节的条形码例子中,演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选 择,枚举成员可以被默认值(称为原始值)预填充,这些原始值的类型必须相同。


//使用ASCII码作为原始值的枚举：
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

/*
 枚举类型 ASCIIControlCharacter 的原始值类型被定义为 Character ,并设置了一些比较常见的 ASCII 控制字符。 Character 的描述详见字符串和字符部分。
 原始值可以是字符串,字符,或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
 注意
 原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值,像上述三个 ASCII 码。对于一个特定的枚举成员,它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值,枚举成员的关联值可以变化。

 */

//\\\\\初始值的隐式赋值（Implicitly Assigned Row Values）

//在使用原始值为整数或者字符串类型的枚举时,不需要显式地为每一个枚举成员设置原始值,Swift 将会自动为你赋值。例如,当使用整数作为原始值时,隐式赋值的值依次递增 1 。如果第一个枚举成员没有设置原始值,其原始值将 为0。

enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupite
}
// Plant.Mercury 的显式原始值为 1 , Planet.Venus 的隐式原始值为 2 ,依次类推。当使用字符串作为枚举类型的原始值时,每个枚举成员的隐式原始值为该枚举成员的名称。

enum CompassPoint1: String {
    case North, South, East, West
}
//上面例子中, CompassPoint.South 拥有隐式原始值 South ,依次类推。


//使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值:

let earthOrder = Planet1.Earth.rawValue
let sunsetDirection = CompassPoint1.West.rawValue

//\\\\\使用原始值初始化枚举实例（Initializing From a row Vaule）
/*
 如果定义枚举类型的时候使用了原始值，那么将会自动获取一个初始化方法，这个方法接收一个叫做rawVlaue的参数，参数类型即为原始值，返回值则是枚举成员或nil。可以使用这个初始化方法创建一个新的枚举实例
 */
let possiblePlanet = Planet1(rawValue:4)
//然而,并非所有 值都可以找到一个匹配的行星。因此,原始值构造器总是返回一个可选的枚举成员。在上面 的例子中,   是   类型,或者说“可选的 ”。
//注意 原始值构造器是一个可失败构造器,因为并不是每一个原始值都有与之对应的枚举成员。

let positionToFind = 9
if let somePlanet = Planet1(rawValue:positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmelss")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\递归枚举（Recursive Enumerations）
/*
 当各种可能的情况可以被穷举时,非常适合使用枚举进行数据建模,例如可以用枚举来表示用于简单整数运算的 操作符。这些操作符让你可以将简单的算术表达式,例如整数 ,结合为更为复杂的表达式,例如: 5 + 4
 算术表达式的一个重要特性是,表达式可以嵌套使用。例如,表达式 (5 + 4) * 2 ,乘号右边是一个数字,左边 则是另一个表达式。因为数据是嵌套的,因而用来存储数据的枚举类型也需要支持这种嵌套——这意味着枚举类 型需要支持递归。
 递归枚举(recursive enumeration)是一种枚举类型,它有一个或多个枚举成员使用该枚举类型的实例作为关联 值。使用递归枚举时,编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归
 */

//下面例子中，枚举类型存储了简单的算术表达式：

enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression,ArithmeticExpression)
    indirect case Multipplication(ArithmeticExpression, ArithmeticExpression)
}

//可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都可以递归
indirect enum ArithmeticExpression1 {
    case Number(Int)
    case Addition(ArithmeticExpression1, ArithmeticExpression1)
    case Multiplication(ArithmeticExpression1, ArithmeticExpression1)
}
//上面定义的枚举类型可以存储三种算术表达式:纯数字、两个表达式相加、两个表达式相乘。枚举成员 Addition 和 Multiplication 的关联值也是算术表达式——这些关联值使得嵌套表达式成为可能。

//要操作具有递归属性质的数据结构，使用递归函数是一种直截了当的方法，例如下面一个对算数求值的函数：

func evaluate(expression: ArithmeticExpression1) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(expression: left) + evaluate(expression: right)
    case .Multiplication(let left, let right):
        return evaluate(expression: left) * evaluate(expression: right)
    }
}
//计算（5 + 4）* 2、
let five = ArithmeticExpression1.Number(5)
let four = ArithmeticExpression1.Number(4)

let sum = ArithmeticExpression1.Addition(five, four)

let product = ArithmeticExpression1.Multiplication(sum, ArithmeticExpression1.Number(2))

print("\(evaluate(expression: product))")
//该函数如果遇到纯数字,就直接返回该数字的值。如果遇到的是加法或乘法运算,则分别计算左边表达式和右边表达式的值,然后相加或相乘。



