//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let someString = "Some string literal value"
//初始化一个空的字符串
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
  print("Nothing to see here")
}
//字符串的可变性（String Mutability）
var varibleStirng = "Horse"
varibleStirng += " and carriage"

var constantString = "Highlander"
constantString += " and anther Highlander"

//字符串市值类型（String are value Types）
//使用字符（working with Characters）
for character in "Dog!🐶🐶".characters {
  print(character)

}

let exclamationMark:Character = "!"
//字符串可以通过传递一个值类型为Character的数组作为自变量来进行初始化
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]

let catString  = String(catCharacters)
print(catString)

//连接字符串和字符（Concatantating String and Characters）
let string1 = "Hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationMark1:Character = "!"
//append()方法讲一个字符添加到一个字符串的尾部
welcome.append(exclamationMark1)

//字符串插值（String Interpolation）

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"


//计算字符数量（Counting Characters）
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
let unusualString = "Koala 🐨，Snail 🐌， Penguin 🐧， Dromedary 🐫"
print("unusual has \(unusualString.characters.count) characters")

//访问和修改字符串（Accessing and Modifying a String）
//字符串索引（String Indices）

//每一个 String 值都有一个关联的索引(index)类型, String.Index ,它对应着字符串中的每一个 Character 的位 置。
let greeting = "Guten Tag!"
greeting.startIndex
greeting.endIndex

greeting[greeting.startIndex]
//前任
greeting[greeting.endIndex.predecessor()]
//后记
greeting[greeting.startIndex.successor()]
//任何一个String的索引都可以通过锁链作用的这些方法来获取另一个索引，也可以调用advancedBy(_:) 但是不能超出
 let index = greeting.startIndex.advancedBy(7)
greeting[index]

//使用characters属性的 indices 会创建一个包含全部所以的范围（Range），用来在一个字符串中访问单个字符

//Swift 的字符串不能用整数(integer)做索引。
//使用 startIndex 属性可以获取一个 String 的第一个 Character 的索引。使用 endIndex 属性可以获取最后一个 C haracter 的后一个位置的索引。因此, endIndex 属性不能作为一个字符串的有效下标。如果 String 是空串, artIndex 和 endIndex 是相等的。
//通过调用 String.Index 的 predecessor() 方法,可以立即得到前面一个索引,调用 successor() 方法可以立即得 到后面一个索引。任何一个 String 的索引都可以通过锁链作用的这些方法来获取另一个索引,也可以调用 cedBy(_:) 方法来获取。但如果尝试获取出界的字符串索引,就会抛出一个运行时错误。


for index in greeting.characters.indices {
    print("\(greeting[index])")
}

// 插入和删除（Inserting and Removing）
var welcome1 = "hello"
welcome1.insert("!", atIndex: welcome1.endIndex)

welcome1.insertContentsOf(" there".characters, at: welcome1.endIndex.predecessor())
// welcome 现在等于 "hello there!"
var hello = "hello "
hello.insertContentsOf(" there".characters, at: hello.endIndex.predecessor())

welcome1.removeAtIndex(welcome1.endIndex.predecessor())
welcome1

let  range = welcome1.endIndex.advancedBy(-6)..<welcome1.endIndex
welcome1.removeRange(range)
welcome1

//比较字符串（Comparing Strings）
//字符串/字符相等（String and Character equality）

let quotation = "We're a lot alike, you and I."

let someQuotation = "We're a lot alike, you and I."
if quotation == someQuotation{
  print("these two strings are considered equal")
}


let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]


var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// 打印输出 "There are 5 scenes in Act 1"


var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// 打印输出 "6 mansion scenes; 2 cell scenes"





















































        
