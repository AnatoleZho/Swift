//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
• 函数定义与调用(Defining and Calling Functions)
• 函数参数与返回值(Function Parameters and Return Values) 
• 函数参数名称(Function Parameter Names)
• 函数类型(Function Types)
• 嵌套函数(Nested Functions)
 */

//函数是用来完成特定任务的独立的代码块
/*
 在 Swift 中,每个函数都有一种类型,包括函数的参数值类型和返回值类型。你可以把函数类型当做任何其他普通变量类型一样处理,这样就可以更简单地把函数当做别的函数的参数,也可以从其他函数中返回函数。函数的定义可以写在在其他函数定义中,这样可以在嵌套函数范围内实现功能封装。
 */

//||||||||||||||||||||函数的定义与调用(Defining and Calling Functions)

//作为函数的输入(称为参数,parameter s),也可以定义某种类型的值作为函数执行结束的输出(称为返回类型,return type)。
//每个函数有个函数名,用来描述函数执行的任务


func sayHello(_ personName: String) -> String {
    let greeting = "Hello, " + personName + "!"
    return greeting
}

sayHello("西瓜")
sayHello("冬瓜")
print(sayHello("南瓜"))

func sayHelloAgain(_ personName: String) -> String {
    return "Hello again, " + personName + "!"
}

print(sayHelloAgain("World"))

//\\\\\\\\\\\\\\\\\\函数参数与返回值（Function parameters and Return Values）

//1.无参函数(Functions Without Parameters)
func sayHelloWorld() -> String {
    return "hello, world"
}

print(sayHelloWorld())
//尽管这个函数没有参数,但是定义中在函数名后还是需要一对圆括号。当被调用时,也需要在函数名后写一对圆括号

//2.多参数函数 （Functions With Multiple Parameters）
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    } else {
        return sayHello(personName)
    }
}

print(sayHello(personName: "Tim", alreadyGreeted: true))
//当调用超过一个参数的函数时,第一个参数后的参数根据其对应的参数名称标记,函数参数命名在函数参数名 称(Function Parameter Names)

//3.无返回值函数（Functions Without Return Values） 
func sayGoodbye(personName: String) {
   print("Goodbye, \(personName) !")
}
sayGoodbye(personName: "Dave")
//严格上来说,虽然没有返回值被定义,sayGoodbye(_:) 函数依然返回了值。没有定义返回类型的函数会返回特殊的值,叫 Void 。它其实是一个空的元组(tuple),没有任何元素,可以写成 () 。


//\\\\被调用时,一个函数的返回值可以被忽略:
func printAndCount(stringToPrint: String) -> Int {
    print(stringToPrint)
    return stringToPrint.characters.count
}

func printWithoutCounting(stringToPrint: String)  {
    printAndCount(stringToPrint)
}

printAndCount("Hello, world")
printWithoutCounting("Hello, world")

//返回值可以被忽略,但定义了有返回值的函数必须返回一个值,如果在函数定义底部没有返回任何值,将导致编 译错误(compile-time error)


//4.多重返回值函数 （Functions with Multiple Return Values）
//可以用元组(tuple)类型让多个值作为一个复合值从函数中返回
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
           currentMax = value
        }
    }
    return(currentMin, currentMax)
}

let bounds = minMax([8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
//需要注意的是,元组的成员不需要在元组从函数中返回时命名,因为它们的名字已经在函数返回类型中指定了

//5.可选元组返回类型（Optional Tuple Return Types）
//如果函数返回的元组类型有可能整个元组都“没有值”,你可以使用可选的(Optional) 元组返回类型反映整个 元组可以是 nil 的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组,例如 (Int, In t)? 或 (String, Int, Bool)?

//可选元组类型如 (Int, Int)? 与元组包含可选类型如 (Int?, Int?) 是不同的.可选的元组类型,整个元组是可选 的,而不只是元组中的每个元素值。

func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
           currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax2([8, -6, 2, 109, 3, 71]) {
   print("min is \(bounds.min) and max is \(bounds.max)")
}

//\\\\\\\\\\\\\\函数参数名称（Function Parameter Names）
//函数参数都有一个外部参数名(external parameter name)和一个局部参数名(local parameter name)。外部参数名用于在函数调用时标注传递给函数的参数,局部参数名在函数的实现内部使用

func someFunction(firstParameterName:Int, secondParameterName:Int) {
    //function body goes here
    //firstParameterName and secondParameterName refer to
    //the argument values for the first and second parameters
}
someFunction(1, secondParameterName: 2)
//第一个参数省略其外部参数名,第二个以及随后的参数使用其局部参数名作为外部参数名。所有参数必须有独一无二的局部参数名。尽管多个参数可以有相同的外部参数名,但不同的外部参数名能让你的代码更有可读性。
//1.指定外部参数名(Specifying External Parameter Names)
func someFunction(externalParamelName localParameterName:Int) {
    //function body goes here, and can use localParameterName
    //to refer to the argument value for that parameter
}
//如果提供了外部参数名,那么函数在被调用时,必须使用外部参数名。
print(someFunction(externalParamelName: 3))

func sayHello(to person: String, and anotherPerson:String) -> String {
    return "Hello \(person) and \(anotherPerson) !"
}
print(sayHello(to: "Bill", and: "Ted"))
//为每个参数指定外部参数名后,在你调用 sayHello(to:and:) 函数时两个外部参数名都必须写出来。 
//使用外部函数名可以使函数以一种更富有表达性的类似句子的方式调用,并使函数体意图清晰,更具可读性。

//忽略外部参数名 （Omitting External Parameter Names）

func someFunction(firstParameterName: Int, _ secondParameterName:Int) {
    //function body goes here
}
someFunction(11, 2)
//因为第一个参数默认忽略其外部参数名称,显式地写下划线是多余的。

//、、默认参数值（Default Parameters Values）
//可以在函数体中为每个参数定义 默认值(Deafult Values) 。当默认值被定义后,调用这个函数时可以忽略这 个参数。

func someFunction(parameterWithDefault: Int = 12) -> () {
    //function body goes here
    print(parameterWithDefault)
}
//将带有默认值的参数放在函数参数列表的最后。这样可以保证在函数调用时,非默认参数的顺序是一致的,同时使得相同的函数在不同情况下调用时显得更为清晰。
someFunction(6)
someFunction()


//\\\\\可变参数（Variadic Parameters）
//一个可变参数(variadic parameter) 可以接受零个或多个值。函数调用时,你可以用可变参数来指定函数参数 可以被传入不确定数量的输入值。通过在变量类型名后面加入 (...) 的方式来定义可变参数。
//可变参数的传入值在函数体中变为此类型的一个数组。例如,一个叫做 numbers 的 Double... 型可变参 数,在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。

func arithmelticMean(numbers:Double...) -> Double {
    var tatol: Double = 0
    for number in numbers {
        tatol += number
    }
    return tatol / Double(numbers.count)
}

arithmelticMean(1, 2, 3, 4, 5)

arithmelticMean(3, 8.25, 18.75)
//一个函数最多只能有一个可变参数。


//\\\\\常量参数和变量参数（Contant and Varible Parameters）<2.2弃用>
/*
 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。
 但是,有时候,如果函数中有传入参数的变量值副本将是很有用的。你可以通过指定一个或多个参数为变量参
 数,从而避免自己在函数中定义新的变量。变量参数不是常量,你可以在函数中把它当做新的可修改副本来使
 用。
 */

func alignRight(string: String, totalLength: Int, pad: Character) -> String {
    var string = string
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}

let originalString = "hello"

let paddedString = alignRight(string: originalString, totalLength: 10, pad: "-")
print(paddedString)

//对变量参数所进行的修改在函数调用结束后便消失了,并且对于函数体外是不可见的。变量参数仅仅存在于函调用的生命周期中。
// 对变量参数所进行的修改在函数调用结束后便消失了,并且对于函数体外是不可见的。变量参数仅仅存在于函数调用的生命周期中。

//\\\\\\\\输入输出参数（In-Out Parameters）



/*
 变量参数,正如上面所述,仅仅能在函数体内被更改。如果你想要一个函数可以修改参数的值,并且想要在这些 修改在函数调用结束后仍然存在,那么就应该把这个参数定义为输入输出参数(In-Out Parameters)。
 定义一个输入输出参数时,在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值,这个值被函数 修改,然后被传出函数,替换原来的值
 只能传递变量给输入输出参数。不能传入常量或者字面量(literal value),因为这些量是不能被修改的。当传入的参数作为输入输出参数时,需要在参数名前加 & 符,表示这个值可以被函数修改。
 
 注意
 输入输出参数不能有默认值,而且可变参数不能用  inout 标记。如果用 inout 标记一个参数,这个参数 不能被 var 或者 let 标记。
 */


func swapTwoInts( a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//可以用两个  Int 型的变量来调用 swapTwoInts(inout a: Int, inout _ b: Int)  需要注意的是,   someInt 和  anotherInt 在传入swapTwoInts(inout a: Int, inout _ b: Int)函数前,都加了   & 的前缀:
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// prints "someInt is now 107, and anotherInt is now 3"
//我们可以看到  someInt 和 anotherInt 的原始值在 swapTwoInts(inout a: Int, inout _ b: Int)函数中修改,尽管它们的定义在函数体外。
/*
 注意
 输入输出参数和返回值是不一样的。上面的 swapTwoInts 函数并没有定义任何返回值,但仍然修改了 someIn t 和 anotherInt 的值。输入输出参数是函数对函数体外产生影响的另一种方式。
 */

//函数类型 （Functions Types）

//每一个函数都有一种特定的函数类型，由函数的参数类型和返回值类型组成

func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}

/*
 这个例子中定义了两个简单的数学函数:addTwoInts 和 multiplyTwoInts。这两个函数都接受两个 Int 值, 返回一个 Int 值。
 这两个函数的类型是 (Int, Int) -> Int ,可以解读为“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值。
 */


func printHelloWorld() {
    print("Hello, world!")
}
//这个函数的类型是: () -> void ,或者叫“没有参数,并返回 Void 类型的函数”。

//使用函数类型（Using Function Types）
/*
 在 Swift 中,使用函数类型就像使用其他类型一样。例如,你可以定义一个类型为函数的常量或变量,并将适当 的函数赋值给它:
 var mathFunction: (Int, Int) -> Int = addTwoInts
 
 这个可以解读为:
 “定义一个叫做 mathFunction 的变量,类型是‘一个有两个 Int 型的参数并返回一个Int 型的值的 “函数”。并让这个新变量指向  addTwoInts 函数”。
 addTwoInts 和 mathFunction 有同样的类型,所以这个赋值过程在 Swift 类型检查中是允许的。
*/

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")

mathFunction = multiplyTwoInts

print("Result: \(mathFunction(2,3))")

//当赋值一个函数给常量或变量时,你可以让 Swift 来推断其函数类型
let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int



//\\\\\\\\\\\\函数类型作为参数类型(Function Types as Parameter Types)

//可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函 数的调用者来提供

func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)

/*
 这个例子定义了 printMathResult(_:_:_:) 函数,它有三个参数:第一个参数叫 mathFunction,类型是(Int, Int) -> Int ,你可以传入任何这种类型的函数;第二个和第三个参数叫 a 和 b ,它们的类型都是 Int ,这两个值作为已给出的函数的输入值。
 当 printMathResult(_:_:_:) 被调用时,它被传入 addTwoInts 函数和整数3和5。它用传入3和5调用 a ddTwoInts ,并输出结果: 8 。
 printMathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。它不关心传入函数是如 何实现的,它只关心这个传入的函数类型是正确的。这使得 printMathResult(_:_:_:) 能以一种类型安全(type-safe)的方式将一部分功能转给调用者实现.
 */


//\\\\\\\\\\\函数类型作为返回类型(Function Types as Return Types)
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3

let moveNearerToZero = chooseStepFunction(currentValue > 0)

//一个指向返回的函数的引用保存在了 moveNearerToZero
//现在,moveNearerToZero 指向了正确的函数,它可以被用来数到0 :

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!

//\\\\\\\\\\\\\\\\\\\\\\嵌套函数（Nested Fuctions）
//这章中你所见到的所有函数都叫全局函数(global functions),它们定义在全局域中。你也可以把函数定义在别的函数体中,称作嵌套函数(nested functions)

//注意  
/*
 这章中你所见到的所有函数都叫全局函数(global functions),它们定义在全局域中。你也可以把函数定义在别的函数体中,称作嵌套函数(nested functions)
 */

func chooseStepFunction1(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backwards ? stepBackward : stepForward
}

var currentValue1 = -4
let moveNearToZero = chooseStepFunction1(currentValue > 0)

while currentValue != 0 {
    print("\(currentValue).....")
    currentValue = moveNearToZero(currentValue)
}
print("zero!")





































