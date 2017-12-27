//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//创建一个空数组
var someInts = [Int]()

someInts.append(3)

someInts = []

var threeDubles = [Double](count: 3, repeatedValue:0.0)

var anotherThreeDoubles = Array(count:3,repeatedValue:2.5)
var sixDoubles = threeDubles + anotherThreeDoubles

//用字面量构建数组
var shoppingList:[String] = ["Eggs", "Milk"]
//在这个例子中，字面量仅仅包含两个String值。匹配了该数组的变量声明（只能包含String的数组），所以这个字面量的分配过程可以作为用两个初始项来构造shoppinglist的一种方式。

//访问和修改数组
print("The shopping list contants \(shoppingList.count) itens")

if shoppingList.isEmpty {
    print("The shopping list is empty")
} else {
  print("The shopping is not empty")
}

shoppingList.append("Flour")

shoppingList += ["Baking Power"]

shoppingList += ["Chocolate Spread", "Chesse", "Butter"]

var  fistItem = shoppingList[0]

shoppingList[0] = "Six Eggs"
shoppingList[4...6] = ["Bananas", "Apples"]
shoppingList

//不可以用下标访问的形式去在数组尾部添加新项

shoppingList.insert("Maple Syrup", atIndex: 0)
let mapleSyrup = shoppingList.removeAtIndex(0)

var firstItem = shoppingList[0]

let apples = shoppingList.removeLast()

for item in shoppingList {
  print(item)
}

for (index,value) in shoppingList.enumerate() {
    print("item \(String(index + 1)):\(value)")
}




//集合（Set）

//创建一个空集合
var letters = Set<Character>()

print("letters is of type Set<Chatacter> with \(letters.count) items.")

letters.insert("a")
letters = []
 //用数组字面量创建集合
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//这个favoriteGenres变量被声明为“一个String值的集合”，写为Set<String>。由于这个特定的集合含有指定String类型的值，所以它只允许存储String类型值。这里的favoriteGenres变量有三个String类型的初始值("Rock"，"Classical"和"Hip hop")，并以数组字面量的方式出现。

//访问和修改集合
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.isEmpty {
 print("As far as music goes, I'm not picky.")
} else {
  print("I have Particular music preferrences.")
}

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
  print("\(removedGenre) ? I'm over it")
} else {
    print("I never much cared for that")
}

if favoriteGenres.contains("Funk") {
  print("I get up on the good foot.")
} else {
  print("It's too funky in here.")
}

for genre in favoriteGenres.sort() {
  print("\(genre)")
}

//集合基本操作
var oddDigits:Set = [1, 3, 5, 7, 9]
let evenDigits:Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers:Set = [2, 3, 5, 7]
//并
oddDigits.union(evenDigits).sort()
//交
oddDigits.intersect(evenDigits).sort()
//差
oddDigits.subtract(singleDigitPrimeNumbers).sort()
//异或
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

//集合成员关系和相等
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
//子集
houseAnimals.isSubsetOf(farmAnimals)
//父集
farmAnimals.isSupersetOf(houseAnimals)
//无关
farmAnimals.isDisjointWith(cityAnimals)



//字典

//创建一个空字典
var namesIntegers = [Int: String]()

namesIntegers[16] = "sixteen"

namesIntegers = [:]

//用字典字面量创建字典
var airPorts:[String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//访问和修改字典
print("The dictionary of airports contains \(airPorts.count) items")

if airPorts.isEmpty {
 print("The airports dictionary is empty")
    
} else {
    print("The airports dictionary is no enpty")
    
}

airPorts["LHR"] = "London"

airPorts["LHR"] = "London HeathRow"

if let oldValue = airPorts.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

if let airportName = airPorts["DUB"] {
     print("The name of the airport is \(airportName)")
} else {
      print("That airport is not in the airports dictionary")
}

//我们还可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里移除一个键值对：
airPorts["APL"] = "Apple Internation"
airPorts["APL"] = nil

if let removedValue = airPorts.removeValueForKey("DUB") {
      print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary dees not contain a value for DUB")
}

//字典遍历
for (airportCode, airportName) in airPorts {
   print("\(airportCode): \(airportName)")
}

for airportCode in airPorts.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airPorts.values {
  print("Airport Name: \(airportName)")
}

let airportCodes = [String](airPorts.keys)
let airportName = [String](airPorts.values)
//Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的keys或values属性使用sort()方法。












































        