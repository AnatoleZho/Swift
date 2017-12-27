//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

//For 循环
//弃用C语言中的for循环语法
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

print("\(base) to the power of \(power) is \(answer)")

let names = ["Anna", "Alex", "Barian", "Jack"]
for name in names {
    print("Hello, \(name)")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
      print("\(animalName)s have \(legCount)")
}

//While循环

//• while循环,每次在循环开始时计算条件是否符合;
//• repeat-while循环,每次在循环结束时计算条件是否符合。
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue:0)

var square = 0
var diceRoll = 0
while square < finalSquare {
    //掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1}
    //根据点数移动
    square += diceRoll
    if square < board.count {
    //如果玩家还在棋盘上，顺着梯子上去或者是顺着蛇滑下去
        square += board[square]
    }
}
print("Game Over")

//Repeat-While
//while 循环的另外一种形式是 repeat-while ,它和 while 的区别是在判断循环条件之前,先执行一次循环的代码 块,然后重复循环直到条件为 false 。

repeat {
    // 顺着梯子爬上去或者顺着蛇滑下去 square += board[square]
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 } // 根据点数移动
    square += diceRoll
} while square < finalSquare
print("Game over!")


//条件语句
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// 输出 "It's very cold. Consider wearing a scarf."

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// 输出 "It's not that cold. Wear a t-shirt."



temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// 输出 "It's really warm. Don't forget to wear sunscreen."

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}


//switch语句
//switch语句会尝试把某个值与若干个模式(pattern)进行匹配。根据第一个匹配成功的模式,   语句会执 行对应的代码。当有可能的情况较多时,通常用switch语句替换  if 语句

let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
// 输出 "e is a vowel"

//不存在隐式的贯穿(No Implicit Fallthrough)
//在 Swift 中,当匹配的 case 分支中的代码执行完毕后,程序会终止 switch 语句,而不会继续执行下一个 case 分支。这也就是说,不需要在 case 分支中显式地使用 break 语句。这使得 switch 语句更安全、更易用,也避免了因忘记写 break 语句而产生的错误
let anotherCharacter: Character = "a"
switch anotherCharacter {
    //每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的,因为第一个 case 分支是空的:
    //switch语句不会同时匹配"a" 和 "A" 。代码会引 起编译期错误: case "a": does not contain any executable statements ——这就避免了意外地从一个 case 分 支贯穿到另外一个,使得代码更安全、也更直观
    //case "a":
    case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// this will report a compile-time error



//一个 case 也可以包含多个模式,用逗号把它们分开(如果太长了也可以分行写):
//switch some value to consider {
//    case value 1, value 2:
//    statements
//}

//case 分支的模式也可以是一个值的区间。下面的例子展示了如何使用区间匹配来输出任意数字对应的自然语言格式:
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).") // 输出 "There are dozens of moons orbiting Saturn."

//元组(Tuple)
//我们可以使用元组在同一个 switch 语句中测试多个值。元组中的元素可以是值,也可以是区间。另外,使用下划 线( _ )来匹配所有可能的值。
//下面的例子展示了如何使用一个 (Int, Int) 类型的元组来分类下图中的点(x, y):
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
// 输出 "(1, 1) is inside the box"


//值绑定(Value Bindings)
//case 分支的模式允许将匹配的值绑定到一个临时的常量或变量,这些常量或变量在该 case 分支里就可以被引用 了——这种行为被称为值绑定(value binding)。
//下面的例子展示了如何在一个   类型的元组中使用值绑定来分类下图中的点(x, y):
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// 输出 "on the x-axis with an x value of 2"


//Where
//case 分支的模式可以使用 where 语句来判断额外的条件。
//下面的例子把下图中的点(x, y)进行了分类:
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
print("(\(x), \(y)) is just some arbitrary point")
}
// 输出 "(1, -1) is on the line x == -y"
//这三个 case 都声明了常量 x  和 y   的占位符,用于临时获取元组 yetAnotherPoint的两个值，这些常量被用作where语句的一部分,从而创建一个动态的过滤器(filter)。当且仅当  where 语句的条件为  ture 时,匹配到的case 分支才会被执行。

//控制转移语句(Control Transfer Statements)

//控制转移语句改变你代码的执行顺序,通过它你可以实现代码的跳转。Swift 有五种控制转移语句: continue  break  fallthrough  return  throw vt. 投；抛；掷 vi. 抛；投掷 n. 投掷；冒险

//continue
//注意: 在一个带有条件和递增的for循环体中,调用 continue 语句后,迭代增量仍然会被计算求值。循环体继 续像往常一样工作,仅仅只是循环体中的执行代码会被跳过。

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)
// 输出 "grtmndsthnklk"


//Break
//break 语句会立刻结束整个控制流的执行。当你想要更早的结束一个 switch 代码块或者一个循环体时,你都可以 使用 break 语句。
//当在一个循环体中使用 break 时,会立刻中断该循环体的执行,然后跳转到表示循环体结束的大括号( } )后的第 一行代码。不会再有本次循环迭代的代码被执行,也不会再有下次的循环迭代产生。
//Switch 语句中的 break
//当在一个 switch 代码块中使用 break 时,会立即中断该 switch 代码块的执行,并且跳转到表示 switch 代码块 结束的大括号( } )后的第一行代码。
//这种特性可以被用来匹配或者忽略一个或多个分支。因为 Swift 的 switch 需要包含所有的分支而且不允许有为 空的分支,有时为了使你的意图更明显,需要特意匹配或者忽略某个分支。那么当你想忽略某个分支时,可以在 该分支内写上 break 语句。当那个分支被匹配到时,分支内的 break 语句立即结束 switch 代码块。

//注意: 当一个 switch 分支仅仅包含注释时,会被报编译时错误。注释不是代码语句而且也不能让 switch 分支 达到被忽略的效果。你总是可以使用 break 来忽略某个分支。
let numberSymbol: Character = "三" // 简体中文里的数字 3 
var possibleIntegerValue: Int?
switch numberSymbol {
    case "1", "?", "一", "?":
        possibleIntegerValue = 1
    case "2", "?", "二", "?":
        possibleIntegerValue = 2
    case "3", "?", "三", "?":
        possibleIntegerValue = 3
    case "4", "?", "四", "?":
        possibleIntegerValue = 4
    default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// 输出 "The integer value of 三 is 3."

//在上面的例子中,想要把 Character 所有的的可能性都枚举出来是不现实的,所以使用 default 分支来包含所有 上面没有匹配到字符的情况。由于这个 default 分支不需要执行任何动作,所以它只写了一条 break 语句。一旦 落入到 default 分支中后, break 语句就完成了该分支的所有代码操作,代码继续向下,开始执行 if let 语句。

//贯穿(Fallthrough)
//Swift 中的 switch 不会从上一个 case 分支落入到下一个 case 分支中。相反,只要第一个匹配到的 case 分支 完成了它需要执行的语句,整个 switch 代码块完成了它的执行。

//如果你确实需要 C 风格的贯穿的特性,你可以在每个需要该特性的 case 分支中使用 fallthrough 关键字。下面 的例子使用 fallthrough 来创建一个数字的描述语句。

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// 输出 "The number 5 is a prime number, and also an integer."




//带标签的语句

/*
 在 Swift 中,你可以在循环体和 switch 代码块中嵌套循环体和 switch 代码块来创造复杂的控制流结构。然 而,循环体和 switch 代码块两者都可以使用 break 语句来提前结束整个方法体。因此,显式地指明 break 语句 想要终止的是哪个循环体或者 switch 代码块,会很有用。类似地,如果你有许多嵌套的循环体,显式指明 continue 语句想要影响哪一个循环体也会非常有用。
 
为了实现这个目的,你可以使用标签来标记一个循环体或者 switch 代码块,当使用 break 或者 continue 时,带 上这个标签,可以控制该标签代表对象的中断或者执行。
 
 产生一个带标签的语句是通过在该语句的关键词的同一行前面放置一个标签,并且该标签后面还需带着一个冒 号。下面是一个 while 循环体的语法,同样的规则适用于所有的循环体和 switch 代码块。
 */

let finalSquare1 = 25
var board1 = [Int](count: finalSquare1 + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square1 = 0
var diceRoll1 = 0

gameLoop: while square1 != finalSquare1 {
    diceRoll1 += 1
    if diceRoll1 == 7 { diceRoll1 = 1 }
    switch square1 + diceRoll1 {
    case finalSquare1:
        // 到达最后一个方块,游戏结束
        break gameLoop
    case let newSquare1 where newSquare1 > finalSquare1:
        // 超出最后一个方块,再掷一次骰子
        continue gameLoop
    default:
        // 本次移动有效
        square1 += diceRoll1
        square1 += board[square1]
    } }
print("Game over!")


//guard

/*
提前退出
像 if 语句一样, guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真 时,以执行 guard 语句后的代码。不同于 if 语句,一个 guard 语句总是有一个 else 分句,如果条件不为真则执 行 else 分句中的代码。
*/
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return }
    print("Hello \(name)")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(["name": "John"])
// prints "Hello John!"
// prints "I hope the weather is nice near you."
greet(["name": "Jane", "location": "Cupertino"])
// prints "Hello Jane!"
// prints "I hope the weather is nice in Cupertino."

//如果 guard 语句的条件被满足,则在保护语句的封闭大括号结束后继续执行代码。任何使用了可选绑定作为条件 的一部分并被分配了值的变量或常量对于剩下的保护语句出现的代码段是可用的。
/*
 如果条件不被满足,在 else 分支上的代码就会被执行。这个分支必须转移控制以退出 guard 语句出现的代码 段。它可以用控制转移语句如 return , break , continue 或者 throw 做这件事,或者调用一个不返回的方法或函 数,例如 fatalError() 。
 相比于可以实现同样功能的 if 语句,按需使用 guard 语句会提升我们代码的可靠性。 它可以使你的代码连贯的 被执行而不需要将它包在 else 块中,它可以使你处理违反要求的代码使其接近要求。
 */




//API检测
//检测 API 可用性
if #available(iOS 9, OSX 10.10, *) {
    // 在 iOS 使用 iOS 9 的 API, 在 OS X 使用 OS X v10.10 的 API
} else {
    // 使用先前版本的 iOS 和 OS X 的 API
}


//if #available(platform name version, ..., *) {
//    statements to execute if the APIs are available
//} else {
//    fallback statements to execute if the APIs are unavailable
//}
























