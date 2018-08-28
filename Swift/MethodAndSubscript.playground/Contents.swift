//: Playground - noun: a place where people can play

import UIKit

//**    方法 Methods   **//

/*
 方法是与某些特定类型相关联的函数. 类,结构体,枚举都可以定义实例方法; 实例方法为给定类型的实例封装了具体的任务和功能. 类,结构体,枚举也可以定义类型方法; 类型方法与类型本身相关联. 类型方法与 Objective-C 中的类方法 (class Methods)相似.
 
 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的只要区别之一. 在 Objective-C 中, 类是唯一能定义方法的类型. 但在 Swift 中, 不仅能选择是否要定义一个类/结构体/枚举, 还能灵活地在创建的类型(类/结构体/枚举)上定义方法.
 
 */


/// 实例方法 (Instance Methods)

/*
  实例方法是属于摸个特定类,结构体或枚举类型实例的方法. 实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能, 并以此来支撑实例的功能. 实例方法的语法与函数完全一致.
 
   实例方法要写在他所属的类型的前后大括号之间. 实例方法能够隐式访问它所属类型的说有的其他实例方法和属性. 实例方法只能被所属的类的某个特定实例调用. 实例方法不能脱离于现存的实例而被调用.
 */

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
    
 
}

let counter = Counter()

counter.increment()
counter.increment(by: 5)

print(counter.count)

counter.reset()

print(counter.count)


///  self 属性

/*
 类型的每个实例都有一个 隐含属性 self. self 完全等同于该实例本身. 可以在实例的实例方法中使用这个隐含的 self 属性来引用当前实例
 
 func increment() {
 self.count += 1
 }
 
 实际上，你不必在你的代码里面经常写self。不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写self，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的Counter中已经示范了：Counter中的三个实例方法中都使用的是count（而不是self.count）。
 
 使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候
    在这种情况下, 参数名称享有优先权, 并且在引用属性时必须使用一种更严格的方式. 这时可以使用 self 属性来区分参数名称 和 属性名称.
 
 */

struct Point {
    var x = 0.0, y = 0.0
    // self 消除方法参数 x 和 属性之间的歧义
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
    
    
}

let somePoint = Point.init(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to the rinht of the line where x == 1.0")
}

/// 在实例方法中修改值类型

/*
  结构体和枚举是值类型. 默认情况下,值类型的属性不能在它的实例方法中被修改
 但是,如果确实需要在某个特定的方法中修改结构体或者枚举的属性,可以为这个方法选择可变 (mutating) 行为, 然后就可以从其他方法内部改变它的属性;并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中. 方法可以被它隐含的 self 属性赋予一个全新的实例, 这个新实例在方法结束时会替换现存实例.
 */

extension Point {
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var anotherPoint = Point.init(x: 1.0, y: 1.0)
anotherPoint.moveByX(deltaX: 2.0, y: 3)

print("The point is now at (\(anotherPoint.x), \(anotherPoint.y)")

/// 在可变方法中给 self 赋值

extension Point {
    // 可变方法能够赋给隐含属性 self 一个全新的实例
    // 新版的可变方法moveBy(x:y:)创建了一个新的结构体实例，它的 x 和 y 的值都被设定为目标值。调用这个版本的方法和调用上个版本的最终结果是一样的。
    

    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point.init(x: x + deltaX, y: y + deltaY)
    }
}

// 枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case.high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()



/// 类方法 (Class Method)

/*
 实例方法是被某个类型的实例调用的方法. 也可以定义在类型上调用的方法, 这种方法叫做 类型方法
 在方法的 func 关键字之前加上关键字 static, 来指定类型方法. 类还可以用关键字 class 来允许子类重写父类的方法实现
 
 注意: 在 Objective-C 中,只能为 Objective-C 的类类型(classes) 定义类型方法(type-level methods).
      在 Swift 中,可以为所有的类,结构体,枚举定义类型方法. 每一个类型方法都被他所支持的类型显示包含
 
 类型方法和实例方法一样用点语法调用. 但是, 在类型上调用这个方法,而不是在实例上调用
 */

class SomeClass {
    class func someTypeMethod() {
        // 这里实现类型方法
    }
    // 在类型方法的方法体重, self 指向这个类型本身, 而不是类型的某个实例. 这意味着 可以用 self 来消除 类型属性和类型方法参数之间的歧义
    
    // 一般来说, 在类型方法的方法体中,任何未限定的方法和属性名称,可以被本类中其他的类型方法和类型属性引用. 一个类型方法可以直接通过类型方法的名称调用本类中的其他类型方法,而无需在方法名称前面加上类型名称.
}

SomeClass.someTypeMethod()


struct LevelTacker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unLock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTacker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTacker()
    let playerName: String
    
    init(name: String) {
        playerName = name
    }
    
    func complete(level: Int) {
        LevelTacker.unLock(level + 1)
        tracker.advance(to: level + 1)
    }
}

var player = Player(name: "Beto")
player.complete(level: 1)

print("highest unlocked level is now \(LevelTacker.highestUnlockedLevel)")

if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}







//******      下标(Subscript)     *******//

/*
  下标可以定义在类,结构体,枚举中,是访问集合,列表或序列中元素的快捷方式. 可以使用下标的索引, 设置和获取值,而不需要调用对应的存取方法. 举例来说,用下标访问一个 Array 实例中的元素可以写作 someArray[index], 访问 Dictionary 实例中的元素可以写作 someDictionary[key]
 
  一个类型可以定义多个下标,通过不同索引类型进行重载. 下标不限于一维,可以定义具有多个入参的下标满足自定义类型的需求.
 */

// 下标语法

/*
 下标允许通过实例名称后面的方括号中传入一个或多个索引值来对实例进行存取. 语法类似于实例方法语法和计算型属性的混合. 于定义实例方法类似, 定义下标使用  subscript 关键字, 指定一个或多个输入参数和返回类型; 与实例方法不同的是,下标可以设定为读写和只读. 这种行为有 getter 和 setter 实现,有点儿类似计算属性:
 
 subscript(index: Int) -> Int {
   get {
     // 返回适当的 Int 类型的值
   }
 
   set(newValue) {
     // 执行适当的赋值操作
   }
 }
 
 newValue 的类型和下标返回类型相同. 如同计算属性,可以不指定 setter 的参数 (newValue). 如果不指定参数, setter 会提供一个名为 newValue 的默认参数
 
 如同只读计算属性, 可以省略只读下标的 get 关键字:
 
 subscript(index: Int) -> Int {
    // 返回一个适当的 Int 类型的值
 }
 
 */

struct TimesTable {
    let mutiplier: Int
    subscript(index: Int) -> Int {
        return mutiplier * index
    }
}

let threeTimesTable = TimesTable.init(mutiplier: 3)
print("six times three is \(threeTimesTable[6])")


///  下表用法
/*
 下标的确切含义取决于具体使用场景. 下标通常作为访问集合, 列表或序列中元素的快捷方式. 可以针对特定的类或结构体的功能来自由的以最恰当的方式实现下标
 */


// 例如, Swift 的 Dictionary 类型实现下标用于对其 实例中存储的值进行操作. 为字典设值时,在下标中使用和字典的键类型相同的减,并把一个和字典的值类型相同的值赋给这个下标
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

/*
 注意: Swift 的 Dictionary 类型的下标接收并返回可选类型的值. 上面例子中 numberOfLegs 字典通过下标返回的是一个 Int? . Dictionary 类型之所以如此实现下标,是因为不是每个减都有一个对应的值,同时这也提供了一种通过键删除对应值的方式,只需将键对应的值 赋值为 nil 即可.
 */



/// 下标选项

/*
 下标可以接受任意数量的入参,并且这些入参可以是任意类型. 下标的返回值也可以是任意类型. 下标可以使用变量参数和可变参数,但是不能使用 输入输出参数, 也不能给参数设置默认值
 
 一个类或结构体可以根据自身需要提供多个下标实现, 使用下标时将通过入参的数量和类型进行区分, 自动匹配合适的下标,这就是 下标的重载
 */

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array.init(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix.init(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

let someValue = matrix[2, 2]









































