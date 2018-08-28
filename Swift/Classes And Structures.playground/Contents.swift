//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 • 类和结构体对比
 • 结构体和枚举是值类型
 • 类是引用类型
 • 类和结构体的选择
 • 字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
 */

/*
 类和结构体是人们构建代码所用的一种通用且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体
 定义属性(常量、变量)和添加方法,从而扩展类和结构体的功能。
 与其他编程语言所不同的是,Swift 并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或者结构体,系统将会自动生成面向其它代码的外部接口。
 注意
 通常一个 类 的实例被称为 对象 。然而在 Swift 中,类和结构体的关系要比在其他语言中更加的密切,本章中所讨论的大部分功能都可以用在类和结构体上。因此,我们会主要使用 实例 而不是 对象 。
 */

//类和结构体的对比
/*
 • 定义属性用于存储值
 • 定义方法用于提供功能
 • 定义下标操作使得可以通过下标语法访问实例所包含的值
 • 定义构造器用于生成初始化值
 • 通过扩展以增加默认实现的功能
 • 实现协议已停工某种标准功能
*/

//与结构体相比，类还有如下的附属功能：
/*
 • 继承允许一个类继承另一个类的特征
 • 类型转换允许在运行时检查和解释一个类实例的类型
 • 解构器允许一个类实例释放任何其所被分配的资源
 • 引用计数允许对一个类的多次引用
 
 注: 结构体总是通过被复制的方式在代码中传递,不使用引用计数.
 */

//定义语法
class SomeClass {
//class difinition goes here
}

struct SomeStructure {
    //structure difinition goes here
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
/*
 在上面的示例中我们定义了一个名为 Resolution 的结构体,用来描述一个显示器的像素分辨率。这个结构体包含 了两个名为 width 和 height 的存储属性。存储属性是被捆绑和存储在类或结构体中的常量或变量。当这两个属性 被初始化为整数 0 的时候,它们会被推断为 Int 类型。
 在上面的示例中我们还定义了一个名为 VideoMode 的类,用来描述一个视频显示器的特定模式。这个类包含了四 个变量存储属性。第一个是 分辨率 ,它被初始化为一个新的 Resolution 结构体的实例,属性类型被推断为 Reso lution 。新 VideoMode 实例同时还会初始化其它三个属性,它们分别是,初始值为 false 的 interlaced ,初始 值为 0.0 的 frameRate ,以及值为可选 String 的 name 。 name 属性会被自动赋予一个默认值 nil ,意为“没有 name 值”,因为它是一个可选类型。
 */

//类和结构体实例
let someResolution = Resolution()

let someVideoMode = VideoMode()
//结构体和类都使用构造器语法来生成新的实例。构造器语法的最简单形式是在结构体或者类的类型名称后跟随一 对空括号,如 Resolution() 或 VideoMode() 。通过这种方式所创建的类或者结构体实例,其属性均会被初始化为 默认值。

//属性访问

//通过使用点语法(dot syntax),可以访问实例的属性。其语法规则是,实例名后面紧跟属性名,两者通过点号( . )连接:

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
/*
 注意
 与 Objective-C 语言不同的是,Swift 允许直接设置结构体属性的子属性。上面的最后一个例子,就是直接设 置了 someVideoMode 中 resolution 属性的 width 这个子属性,以上操作并不需要重新为整个 resolution 属性设 置新值。
 */

//\\\\\\\\\\\\\\\\\\\\结构体类型的成员变量逐一构造器（Memberwise Intializers for Structure Types）
//所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例成员变量的属性。新实例中的成员变量初始化可以通过属性的名称传递到成员注意构造之中：
let vga = Resolution(width: 640, height: 480)

//与结构体不同，类实例没有默认的成员逐一构造器。

// 结构体和枚举是值类型
/*
 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝
 
 
 在Swift中所有的基本类型:整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（String）、数组（Array）、字典（Dictionary）都是值类型，并且在底层都是以结构提的形式实现的；
 在Swift中，所有的结构体和枚举都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候会被复制
 */

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
//在以上示例中，声明了一个名为 hd 的常量，其值为一个初始化为高清视频分辨率(1920 像素宽,1080 像 素高)的 Resolution 实例。然后示例中又声明了一个名为 cinema 的变量,并将 hd 赋值给它。因为 Resolution 是一个结构体,所以 的值其实是 hd 的一个拷贝副本,而不是 hd 本身。尽管 hd 和 cinema 有着相同的宽(width)和高(heigh t),但是在幕后它们是两个完全不同的实例。

//为了符合数码影院放映的需求(2048 像素宽,1080 像素高),cinema的width属性需要作如下修改:

cinema.width = 2048
print("ciname is now \(cinema.width) pixels wide")

print("hd is still \(hd.width) pixels wide")
/*
 在将 hd 赋予给 cinema 的时候,实际上是将 hd 中所存储的值进行拷贝,然后将拷贝的数据存储到新的 cinema 实 例中。结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立,因此将 cinema 的 width 修改为
 2048 并不会影响 hd 中的 width 的值
 */

//枚举也遵循相同的行为准则：
enum CompassPoint {
   case North, South, East, West
}

var currentDirection  = CompassPoint.West
let remenberedDirection = currentDirection
currentDirection = .East

if remenberedDirection == .West {
   print("The remembered direction is still .West")
}
//上例中 rememberedDirection 被赋予了 currentDirection 的值,实际上它被赋予的是值的一个拷贝。赋值过程结束后再修改 currentDirection 的值并不影响 rememberedDirection 所储存的原始值的拷贝。

//\\\\\\\类是引用类型
//与值类型不同,引用类型在被赋予到一个变量、常量或者被传递到一个函数时,其值不会被拷贝。因此,引用的是已存在的实例本身而不是其拷贝。

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "10801"
tenEighty.frameRate = 25.0

//将tenEighty赋值给一个新的实例变量
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
//因为类是引用类型,所以 tenEight 和 alsoTenEight 实际上引用的是相同的 VideoMode 实例。换句话说,它们是 同一个实例的两种叫法。


//下面,通过查看 tenEighty 的 frameRate 属性,我们会发现它正确的显示了所引用的 VideoMode 实例的新帧 率,其值为 30.0 :
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// 输出 "The frameRate property of theEighty is now 30.0"
//需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量而不是变量。然而依然可以改变 tenEighty.frameRate 和 alsoTenEighty.frameRate ,因为 tenEighty 和 alsoTenEighty 这两个常量的值并未改变。它们并不“存储”这 个 VideoMode 实例,而仅仅是对 VideoMode 实例的引用。所以,改变的是被引用的 VideoMode 的 frameRate 属 性,而不是引用 VideoMode 的常量的值。

//恒等运算符
/*
 因为类是引用类型，有可能有多个常量或变量在幕后同时引用同一个类实例。（对于结构体和枚举来说这并不成立，因为它们作为值类型，在被赋值到常量、变量或者值传递到函数式，其值总是会被拷贝。）
 如果能够判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒等运算符：
 
 • 等价于(===)
 • 不等价于( !== )
 */
//使用两个运算符检验两个常量或是变量是否引用同一个类实例

if tenEighty === alsoTenEighty {
   print("tenEighty and alsoTenEighty refer to the same resolution instance")
}
/*
 请注意,“等价于”(用三个等号表示, === )与“等于”(用两个等号表示, == )的不同: • “等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例。
 
 第 2 章 Swift 教程 | 157
 • “等于”表示两个实例的值“相等”或“相同”,判定时要遵照设计者定义的评判标准,因此相对于“相 等”来说,这是一种更加合适的叫法。
 当你在定义你的自定义类和结构体的时候,你有义务来决定判定两个实例“相等”的标准。在章节等价操作符 (页 0)中将会详细介绍实现自定义“等于”和“不等于”运算符的流程。
 */

//\\\\\\\\\指针

//如果你有 C,C++ 或者 Objective-C 语言的经验,那么你也许会知道这些语言使用指针来引用内存中的地址。一个引用某个引用类型实例的 Swift 常量或者变量,与 C 语言中的指针类似,但是并不直接指向某个内存地 址,也不要求你使用星号( * )来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同。

//\\\\\\\\\\\\\\\\\\类和结构体的选择
/*
 在你的代码中,你可以使用类和结构体来定义你的自定义数据类型。
 然而,结构体实例总是通过值传递,类实例总是通过引用传递。这意味两者适用不同的任务。当你在考虑一个工
 程项目的数据结构和功能的时候,你需要决定每个数据结构是定义成类还是结构体。
 按照通用的准则,当符合一条或多条以下条件时,请考虑构建结构体:
 • 该数据结构的主要目的是用来封装少量相关简单数据值。
 • 有理由预计该数据结构的实例在被赋值或传递时,封装的数据将会被拷贝而不是被引用。 
 • 该数据结构中储存的值类型属性,也应该被拷贝,而不是被引用。
 • 该数据结构不需要去继承另一个既有类型的属性或者行为。
 举例来说,以下情境中适合使用结构体:
 • 几何形状的大小,封装一个 width 属性和 height 属性,两者均为 Double 类型。 
 • 一定范围内的路径,封装一个 start 属性和 length 属性,两者均为 Int 类型。 
 • 三维坐标系内一点,封装 x , y 和 z 属性,三者均为 Double 类型。
 在所有其它案例中,定义一个类,生成一个它的实例,并通过引用来管理和传递。实际中,这意味着绝大部分的
 自定义数据构造都应该是类,而非结构体。
 */


//\\\\\\\\\\字符串（String）、数组（Array）、字典（Dictionary）类型的赋值与复制行为、
/*
 Swift 中,许多基本类型,诸如 String , Array 和 Dictionary 类型均以结构体的形式实现。这意味着被赋值给 新的常量或变量,或者被传入函数或方法中时,它们的值会被拷贝。
 Objective-C 中 NSString , NSArray 和 NSDictionary 类型均以类的形式实现,而并非结构体。它们在被赋值或 者被传入函数或方法时,不会发生值拷贝,而是传递现有实例的引用。
 注意 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中,拷贝行为看起来似乎总会发生。然而,Sw ift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化,所以你没必要去回 避赋值来保证性能最优化。
 */

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\属性（Properties）
/*
 • 存储属性(Stored Properties)
 • 计算属性(Computed Properties)
 • 属性观察器(Property Observers)
 • 全局变量和局部变量(Global and Local Variables)
 • 类型属性(Type Properties)
 
 
 属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分,而计算属性计算(不是存
 储)一个值。计算属性可以用于类、结构体和枚举,存储属性只能用于类和结构体。
 存储属性和计算属性通常与特定类型的实例关联。但是,属性也可以直接作用于类型本身,这种属性称为类型属
 性。
 另外,还可以定义属性观察器来监控属性值的变化,以此来触发一个自定义的操作。属性观察器可以添加到自己
 定义的存储属性上,也可以添加到从父类继承的属性上。

 */

//\\\\\\\\\\\\\\存储属性
/*
 简单来说,一个存储属性就是存储在特定类或结构体的实例里的一个常量或变量。存储属性可以是变量存储属
 性(用关键字 var 定义),也可以是常量存储属性(用关键字 let 定义)。 可以在定义存储属性的时候指定默认值,请参考默认构造器 (页 0)一节。也可以在构造过程中设置或修改存储属
 性的值,甚至修改常量存储属性的值,请参考构造过程中常量属性的修改 (页 0)一节。
 
 
 下面的例子定义了一个名为 FixedLengthRange 的结构体,它描述了一个在创建后无法修改值域宽度的区间:
 */

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
//该区间表示整数0，1，2

rangeOfThreeItems.firstValue = 6
//该区间现在表示6，7， 8

//FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属性。在上面的例子中, length 在创建实例的时候被初始化,因为它是一个常量存储属性,所以之后无法修改它的值。


//\\\\\\\\\常量结构体的存储属性

//如果创建一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使定义了变量存储属性
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//该区间表示0， 1，2，3

//rangeOfFourItems.firstValue = 6
//尽管firstValue是个变量属性，这里还是会报错

/*
 因为 rangeOfFourItems 被声明成了常量(用 let 关键字),即使 firstValue 是一个变量属性,也无法再修改它 了。
 这种行为是由于结构体(struct)属于值类型。当值类型的实例被声明为常量的时候,它的所有属性也就成了常 量。
 属于引用类型的类(class)则不一样。把一个引用类型的实例赋给一个常量后,仍然可以修改该实例的变量属性。
 */

//\\\\\\\\\\延迟存储属性

//延迟存储属性是指当第一次被调用的时候才会计算器初始值的属性。在属性声明前使用 lazy 来表示一个延迟属性
/*
 注意:
 必须将延迟存储属性声明成变量(使用 var 关键字),因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值,因此无法声明成延迟属性。
 */

//延迟属性很有用，当属性的值依赖于在实例构造过程结束后才会知道具体值的外部因素时，或者当获得属性的初始值需要复杂或大量计算是，可以只在需要的时候计算它。

//下面的例子，使用了延迟存储属性来避免复杂类中不必要的初始化。例子中定义了 DataImporter 和 DataManager 两个类，下面是部分代码：

class DataImporter {
    /*
     DataImporter 是一个将外部文件中的数据导入的类
     这个类的初始化会消耗不少时间
     */
    var fileName = "data.txt"
    //这是提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //这是提供数据管理功能
}

let manager = DataManager()

manager.data.append("Some data")
manager.data.append("Some more data")
//DataImporter 实例的importer 属性还没有被创建

/*
 DataManager 类包含一个名为 data 的存储属性,初始值是一个空的字符串( String )数组。虽然没有写出全部 代码, DataManager 类的目的是管理和提供对这个字符串数组的访问。
 
 DataManager 的一个功能是从文件导入数据。该功能由 DataImporter 类提供, DataImporter 完成初始化需要消耗 不少时间:因为它的实例在初始化时可能要打开文件,还要读取文件内容到内存。
 
 DataManager 也可能不从文件中导入数据就完成了管理数据的功能。所以当 DataManager 的实例被创建时,没必 要创建一个 DataImporter 的实例,更明智的是当第一次用到 DataImporter 的时候才去创建它。

 */

//由于使用 lazy， importer属性只有在第一次被访问的时候才被创建。比如访问它的属性fileName时：
print(manager.importer.fileName)

//注意:
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问,则无法保证该属性只会被初始化一次。


//\\\\\\\\\存储属性和实例变量
/*
 如果您有过 Objective-C 经验,应该知道 Objective-C 为类实例存储值和引用提供两种方法。对于属性来 说,也可以使用实例变量作为属性值的后端存储。
 Swift 编程语言中把这些理论统一用属性来实现。Swift 中的属性没有对应的实例变量,属性的后端存储也无法 直接访问。这就避免了不同场景下访问方式的困扰,同时也将属性的定义简化成一个语句。一个类型中属性的全部信息——包括命名、类型和内存管理特征——都在唯一一个地方(类型定义中)定义。
 */

//\\\\\\\\\\\\\\\\\\\\\计算属性
//除了存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个getter 和一个可选的setter，来间接获取和设置其他属性或变量的值

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
           origin.x = newCenter.x - (size.width / 2)
           origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

/*
 这个例子定义了 3 个结构体来描述几何形状:
 • Point 封装了一个 (x,y)  的坐标
 • Size 封装了一个 width 和一个 height
 • Rect 表示一个有原点和尺寸的矩形
 
 Rect 也提供了一个名为 center 的计算属性。一个矩形的中心点可以从原点(origin)和尺寸( size  )算 出,所以不需要将它以显式声明的  Point 来保存。  Rect 的计算属性  center 提供了自定义的 getter 和 setter 来获取和设置矩形的中心点,就像它有一个存储属性一样。
 
 上述例子中创建了一个名为  aquare 的 Rect  实例,初始值原点是 (0, 0)  ,宽度高度都是 10   。如下图中蓝色正方形所示。
 
 square 的 center 属性可以通过点运算符( square.center )来访问,这会调用该属性的 getter 来获取它的 值。跟直接返回已经存在的值不同,getter 实际上通过计算然后返回一个新的 Point 来表示 square 的中心 点。如代码所示,它正确返回了中心点 (5, 5) 。
 center 属性之后被设置了一个新的值 (15, 15) ,表示向右上方移动正方形到如下图橙色正方形所示的位置。设 置属性 center 的值会调用它的 setter 来修改属性 origin 的 x 和 y 的值,从而实现移动正方形到新的位置。

 */

//\\\\\\便捷 setter 声明

//如果计算属性的setter 没有定义表示新值的参数名，则可以使用默认名称 newValue、下面使用了便捷 setter声明的 Rectangle结构体代码

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
        let centerX = origin.x + size.width / 2
        let centerY = origin.y + size.height / 2
        return Point(x: centerX, y: centerY)
        }
        set {
        origin.x = newValue.x - size.width / 2
        origin.y = newValue.y - size.height / 2
        }
    }
}

//只读计算属性
/*
 只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值,可以通过点运算符访 问,但不能设置新的值。
 注意:
 必须使用 var 关键字定义计算属性,包括只读计算属性,因为它们的值不是固定的。let 关键字只用来声明常量属性,表示初始化后再也无法修改的值。
 */

//只读计算属性的声明可以去掉 get 关键字和花括号

struct Cubold {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
       return width * height * depth
    }
}

let fourByFiveByTwo = Cubold(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo)")

//\\\\\属性观察器
/*
 属性观察器监控和响应属性值的变化,每次属性被设置值的时候都会调用属性观察器,甚至新的值和现在的值相
 同的时候也不例外。
 可以为除了延迟存储属性之外的其他存储属性添加属性观察器,也可以通过重写属性的方式为继承的属性(包括 存储属性和计算属性)添加属性观察器。属性重写请参考重写 (页 0)。
 注意:
 不需要为非重写的计算属性添加属性观察器,因为可以通过它的 setter 直接监控和响应值的变化。
 可以为属性添加如下的一个或全部观察器: 
 • 在新的值被设置之前调用
 • didSet在新的值被设置之后立即调用
 willSet 观察器会将新的属性值作为常量参数传入,在 willSet 的实现代码中可以为这个参数指定一个名称,如 果不指定则参数仍然可用,这时使用默认名称 newValue 表示。
 
 类似地, didSet 观察器会将旧的属性值作为参数传入,可以为该参数命名或者使用默认参数名 oldValue 。
 注意:
 父类的属性在子类的构造器中被赋值时,它在父类中的 willSet 和 didSet 观察器会被调用。 有关构造器代理的更多信息,请参考值类型的构造器代理 (页 0)和类的构造器代理规则 (页 0)。
 */

//这里是一个willSet 和 didSet 的实际例子，其中定义名为 StepCouter 的类，用来统计当人步行时的总步数。这里这个类可以跟计步器或其他日常锻炼统计装置的输入数据配合使用

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
          print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 200

stepCounter.totalSteps = 896

/*
 StepCounter 类定义了一个 Int类型的属性 totalSteps， 是一个存储属性，包含 willSet 和 didSet 观察器
 当 totalSteps 设置新值的时候,它的 willSet 和 didSet 观察器都会被调用，甚至当新的值和现在的值 也会调用。
 
 例子中的 观察器将表示新值的参数自定义为 newTotalSteps 这个观察器只是简单的将新的只输出 
 
 didSet 观察器在 totalSteps 的值改变后被调用,它把新的值和旧的值进行对比,如果总的步数增加了,就输出 一个消息表示增加了多少步。 didSet 没有为旧的值提供自定义名称,所以默认值 表示旧值的参数名。
 
 注意:
 如果在一个属性的 didSet 观察器里为它赋值,这个值会替换该观察器之前设置的值。
 */


//\\\\\\\\\\全局变量和局部变量
/*
 计算属性和属性观察器所描述的模式也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类
 型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
 前面章节提到的全局或局部变量都属于存储型变量,跟存储属性类似,它提供特定类型的存储空间,并允许读取
 和写入。
 另外,在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样,返回
 一个计算的值而不是存储值,声明格式也完全一样。
 注意:
 全局的常量或变量都是延迟计算的,跟延迟存储属性 (页 0)相似,不同的地方在于,全局的常量或变量不需要 标记 lazy 特性。
 局部范围的常量或变量不会延迟计算。
 */

//\\\\\\\\\类型属性
/*
 实例的属性属于一个特定类型实例,每次类型实例化后都拥有自己的一套属性值,实例之间的属性相互独立。
 也可以为类型本身定义属性,不管类型有多少个实例,这些属性都只有唯一一份。这种属性就是类型属性。
 类型属性用于定义特定类型所有实例共享的数据,比如所有实例都能用的一个常量(就像 C 语言中的静态常 量),或者所有实例都能访问的一个变量(就像 C 语言中的静态变量)。
 值类型的存储型类型属性可以是变量或常量,计算型类型属性跟实例的计算属性一样只能定义成变量属性。
 注意: 跟实例的存储属性不同,必须给存储型类型属性指定默认值,因为类型本身无法在初始化过程中使用构造器给类 型属性赋值。
 存储型类型属性是延迟初始化的(lazily initialized),它们只有在第一次被访问的时候才会被初始化。即使它 们被多个线程同时访问,系统也保证只会对其进行初始化一次,并且不需要对其使用 lazy 修饰符。
 */

//类型属性语法
/*
 在 C 或 Objective-C 中,与某个类型关联的静态常量和静态变量,是作为全局(global)静态变量定义的。但 是在 Swift 编程语言中,类型属性是作为类型定义的一部分写在类型最外层的花括号内,因此它的作用范围也就 在类型支持的范围内。
 使用关键字 static 来定义类型属性。在为类(class)定义计算型类型属性时,可以使用关键字 class 来支持子 类对父类的实现进行重写。下面的例子演示了存储型和计算型类型属性的语法:
 */

struct SomeStructure1 {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
      return  1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
      return 6
    }
}

class SomeClass1 {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
      return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//注意:例子中的计算型类型属性是只读的,但也可以定义可读可写的计算型类型属性,跟实例计算属性的语法类似。

//\\\\\\\\\\\获取和设置类型属性的值

//跟实例的属性一样,类型属性的访问也是通过点运算符来进行。但是,类型属性是通过类型本身来获取和设置,而不是通过实例。比如:
print(SomeStructure1.storedTypeProperty)

SomeStructure1.storedTypeProperty = "Another value"
print(SomeStructure1.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)

print(SomeClass1.computedTypeProperty)

print(SomeClass1.overrideableComputedTypeProperty)


/*
 例：
 下面的例子定义了一个结构体,使用两个存储型类型属性来表示多个声道的声音电平值,每个声道有一个 0 到 1 0 之间的整数表示声音电平值。
 后面的图表展示了如何联合使用两个声道来表示一个立体声的声音电平值。当声道的电平值是 0,没有一个灯会 亮;当声道的电平值是 10,所有灯点亮。本图中,左声道的电平是 9,右声道的电平是 7。

 上面所描述的声道模型使用 AudioChannel 结构体的实例来表示:
 */

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                //将新电平值设置为阀值、
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                //存储当前电平值作为新的最大输入电平
                AudioChannel.maxInputLevelForAllChannels = currentLevel;
            }
        }
    }
}

/*
 
 结构 AudioChannel 定义了 2 个存储型类型属性来实现上述功能。第一个是 thresholdLevel ,表示声音电平的最 大上限阈值,它是一个取值为 10 的常量,对所有实例都可见,如果声音电平高于 10,则取最大上限值 10(见 后面描述)。

 第二个类型属性是变量存储型属性 maxInputLevelForAllChannels ,它用来表示所有 AudioChannel 实例的电平值 的最大值,初始值是 0。
 AudioChannel 也定义了一个名为 currentLevel 的实例存储属性,表示当前声道现在的电平值,取值为 0 到 1 0。
 属性 currentLevel 包含 didSet 属性观察器来检查每次新设置后的属性值,它有如下两个检查:
 • 如果 currentLevel 的新值大于允许的阈值 thresholdLevel ,属性观察器将 currentLevel 的值限定为阈值 th resholdLevel 。
 • 如果前一个修正后的 currentLevel 值大于任何之前任意 AudioChannel 实例中的值,属性观察器将新值保存 在静态类型属性 maxInputLevelForAllChannels 中。
 注意:
 在第一个检查过程中, didSet 属性观察器将 currentLevel 设置成了不同的值,但这时不会再次调用属性观察 器。
 
 可以使用结构体 AudioChannel 来创建表示立体声系统的两个声道 leftChannel 和 rightChannel
 */
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

//如果将左声道的电平设置成 7， 类型属性 maxInputLevelForAllChannels 也会更新成 7

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)

print(AudioChannel.maxInputLevelForAllChannels)

//如果试图将右声道的电平设置成 11，则会将右声道的 currentLevel 修正到最大值 10，同事 maxInputLevelForAllChannels 的值也会更新为 10
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\方法（Methods）
/*
 • 实例方法(Instance Methods)
 • 类型方法(Type Methods)
 方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法;实例方法为给定类型的实例封装 了具体的任务与功能。类、结构体、枚举也可以定义类型方法;类型方法与类型本身相关联。类型方法与 Object ive-C 中的类方法(class methods)相似。
 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中,类是唯一能定义 方法的类型。但在 Swift 中,你不仅能选择是否要定义一个类/结构体/枚举,还能灵活的在你创建的类型(类/ 结构体/枚举)上定义方法。
 */

//\\\\\\\\\\\\实例方法（Instance methods）
/*
 实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供
 与实例目的相关的功能,并以此来支撑实例的功能。实例方法的语法与函数完全一致,详情参见函数。
 
 实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属
 性。实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。
 
 */

//下面的例子,定义一个很简单的 Counter 类, Counter 能被用来对一个动作发生的次数进行计数:

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
/*
 Counter 类定义了三个实例方法:
 - increment 让计数器按一递增;
 - incrementBy(amount: Int) 让计数器按 一个指定的整数值递增; 
 - reset 将计数器重置为0。
 Counter 这个类还声明了一个可变属性 count ,用它来保持对当前计数器值的追踪。
 */

//和调用属性一样， 用点语法（dot syntax）调用实例方法
let counter = Counter()
counter.increment()
counter.incrementBy(amount: 5)
counter.reset()

//方法的局部参数名称和外部参数名称（Lacal and Exteranl Parameter Names for Methods）

/*
 函数参数可以同时有一个局部名称(在函数体内部使用)和一个外部名称(在调用函数时使用),详情参见指定 外部参数名 (页 0)。方法参数也一样(因为方法就是函数,只是这个函数与某个类型相关联了)。
 Swift 中的方法和 Objective-C 中的方法极其相似。像在 Objective-C 中一样,Swift 中方法的名称通常用一 个介词指向方法的第一个参数,比如:   ,   ,   等等。前面的   类的例子中   方 法就是这样的。介词的使用让方法在被调用时能像一个句子一样被解读。
 具体来说,Swift 默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称局部 参数名称和外部参数名称。这个约定与典型的命名和调用约定相适应,与你在写 Objective-C 的方法时很相 似。这个约定还让表达式方法在调用时不需要再限定参数名称.
 */

class Counter1 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    func increment() {
        self.count += 1
    }
}

let counter1 = Counter1()
counter1.incrementBy(amount: 5, numberOfTimes: 3)

//修改方法的外部参数名称(Modifying External Parameter Name Behavior for Methods)
/*
 有时为方法的第一个参数提供一个外部参数名称是非常有用的,尽管这不是默认的行为。你可以自己添加一个显
 式的外部名称作为第一个参数的前缀来把这个局部名称当作外部名称使用。
 相反,如果你不想为方法的第二个及后续的参数提供一个外部名称,可以通过使用下划线( _ )作为该参数的显 式外部名称,这样做将覆盖默认行为。
*/


//self 属性(The self Property)
//func increment() {
//    self.count += 1
//}

/*
 使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下,参数名 称享有优先权,并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性名称。
 */

//下面例子中，self消除方法参数 x 和实例属性 x 之间的歧义

struct Point1 {
    var x  = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point1(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
  print("This point is to the right of the line where x == 1.0")
}
//如果不是用 self 前缀， Swift 就认为两次使用的 x 都指的是名称为 x 的函数参数

//\\\\\\在实例方法中修改值类型（Modifying Value Types from Within Instance Methods）
/*
 结构体和枚举是值类型。一般情况下,值类型的属性不能在它的实例方法中被修改。
 
 但是,如果你确实需要在某个具体的方法中修改结构体或者枚举的属性,你可以选择 变异(mutating) 这个方 法,然后方法就可以从方法内部改变它的属性;并且它做的任何改变在方法结束时还会保留在原始结构中。方法 还可以给它隐含的 self 属性赋值一个全新的实例,这个新实例在方法结束后将替换原来的实例。
 */

//要使用 变异 方法， 将关键字 mutating 放到方法的 func 关键字之前就可以了 

struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint1 = Point2(x: 1.0, y: 1.0)
somePoint1.moveByX(deltaX: 2.0, y: 3.0)
print("The point is now at (\(somePoint1.x), \(somePoint1.y))")
/*
 上面的 Point 结构体定义了一个可变方法(mutating method) moveByX(_:y:) 用来移动点。 moveByX 方法在被调 用时修改了这个点,而不是返回一个新的点。方法定义时加上 mutating 关键字,这才让方法可以修改值类型的属 性。
 注意:不能在结构体类型常量上调用可变方法,因为常量的属性不能被改变,即使想改变的是常量的变量属性也 不行,详情参见常量结构体的存储属性
 
let fixedPoint = Point2(x: 3.0, y: 3.0)
fixedPoint.moveByX(2.0, y: 3.0)
// 这里将会抛出一个错误
 */

//\\\\\\\\在可变方法中给 self 赋值（Assigning to self Within a Mutating Method）
//可变方法能够赋值给隐含属性 self 一个全新的实例。 上面的 Point 的例子可以用下面的方法改写：
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX:Double, y deltaY: Double) {
    self = Point3(x: x + deltaX, y: y + deltaY)
    }
}
//新版的可变方法 moveByX(_:y:) 创建了一个新的结构(它的 x 和 y 的值都被设定为目标值)。调用这个版本的 方法和调用上个版本的最终结果是一样的。

//枚举的可变方法可以把 self 设置为相同的枚举类型中不同的成员:

enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var overLight = TriStateSwitch.Low
overLight.next()

overLight.next()
//上面的例子中定义了一个三态开关的枚举。每次调用 next 方法时,开关在不同的电源状态( Off , Low , High )之前循环切换。


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\类方法（Type Methods）
/*
 实例方法是被类型的某个实例调用的方法。你也可以定义类型本身调用的方法,这种方法就叫做类型方法。声明 结构体和枚举的类型方法,在方法的 func 关键字之前加上关键字 static 。类可能会用关键字 class 来允许子类 重写父类的实现方法。
 注意:
 在 Objective-C 里面,你只能为 Objective-C 的类定义类型方法(type-level methods)。在 Swift 中,你 可以为所有的类、结构体和枚举定义类型方法:每一个类型方法都被它所支持的类型显式包含。
 类型方法和实例方法一样用点语法调用。但是,你是在类型层面上调用这个方法,而不是在实例层面上调用。
 */

//例子：

class SomeClass2 {
    static func someTypeMethod() {
    //type method implementation goes here
    }
}
SomeClass2.someTypeMethod()

/*
 在类型方法的方法体(body)中, self 指向这个类型本身,而不是类型的某个实例。对于结构体和枚举来说,这 意味着你可以用 self 来消除静态属性和静态方法参数之间的歧义(类似于我们在前面处理实例属性和实例方法参 数时做的那样)。
 一般来说,任何未限定的方法和属性名称,将会来自于本类中另外的类型级别的方法和属性。一个类型方法可以
 调用本类中另一个类型方法的名称,而无需在方法名称前面加上类型名称的前缀。同样,结构体和枚举的类型方
 法也能够直接通过静态属性的名称访问静态属性,而不需要类型名称前缀。
 下面的例子定义了一个名为 LevelTracker 结构体。它监测玩家的游戏发展情况(游戏的不同层次或阶段)。这是 一个单人游戏,但也可以存储多个玩家在同一设备上的游戏信息。
 游戏初始时,所有的游戏等级(除了等级 1)都被锁定。每次有玩家完成一个等级,这个等级就对这个设备上的 所有玩家解锁。 LevelTracker 结构体用静态属性和方法监测游戏的哪个等级已经被解锁。它还监测每个玩家的当 前等级。
 */

struct LevelTracker {
    static var highestUnlokedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlokedLevel {
            highestUnlokedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlokedLevel
    }
    
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level: level) {
            currentLevel = level
            return true
        } else {
           return false
        }
    }
}

/*
 LevelTracker 监测玩家的已解锁的最高等级。这个值被存储在静态属性 highestUnlockedLevel 中。
 LevelTracker 还定义了两个类型方法与 highestUnlockedLevel 配合工作。第一个类型方法是 unlockLevel :一旦 新等级被解锁,它会更新 highestUnlockedLevel 的值。第二个类型方法是 levelIsUnlocked :如果某个给定的等 级已经被解锁,它将返回 true 。(注意:尽管我们没有使用类似 LevelTracker.highestUnlockedLevel 的写 法,这个类型方法还是能够访问静态属性 highestUnlockedLevel )
 除了静态属性和类型方法, LevelTracker 还监测每个玩家的进度。它用实例属性 currentLevel 来监测玩家当前 的等级。
 为了便于管理 currentLevel 属性, LevelTracker 定义了实例方法 advanceToLevel 。这个方法会在更新 currentLe vel 之前检查所请求的新等级是否已经解锁。 advanceToLevel 方法返回布尔值以指示是否能够设置 currentLeve l。
 */

//下面, Player 类使用 LevelTracker 来监测和更新每个玩家的发展进度:

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLavel(level: Int) {
        LevelTracker.unlockLevel(level: level + 1)
        tracker.advanceToLevel(level: level + 1)
    }
    init(name: String) {
     playerName = name
    }
}

/*
 Player 类创建一个新的 LevelTracker 实例来监测这个用户的进度。它提供了 completedLevel 方法:一旦玩家完 成某个指定等级就调用它。这个方法为所有玩家解锁下一等级,并且将当前玩家的进度更新为下一等级。(我们 忽略了 advanceToLevel 返回的布尔值,因为之前调用 LevelTracker.unlockLevel 时就知道了这个等级已经被解锁 了)。
 */

//可以为一个新的玩家创建一个 Player 的实例,然后看这个玩家完成等级一时发生了什么:
var player = Player(name: "Beto")
player.completedLavel(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlokedLevel)")

//如果创建了第二个玩家，并尝试让他开始一个没有被任何玩家解锁的等级，那么这次设置玩家当前等级的尝试将会失败
player = Player(name: "Argyrios")
if player.tracker.advanceToLevel(level: 6) {
   print("player is mow on level 6")
} else {
    print("level has not yet been unlocked")
}


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\下表脚本（Subscripts）
/*
 • 下标脚本语法
 • 下标脚本用法
 • 下标脚本选项
 下标脚本 可以定义在类(Class)、结构体(structure)和枚举(enumeration)这些目标中,可以认为是访问 集合(collection),列表(list)或序列(sequence的快捷方式,使用下标脚本的索引设置和获取值,不需要 再调用实例的特定的赋值和访问方法。举例来说,用下标脚本访问一个数组(Array)实例中的元素可以这样写 meArray[index] ,访问字典(Dictionary)实例中的元素可以这样写 someDictionary[key] 。
 对于同一个目标可以定义多个下标脚本,通过索引值类型的不同来进行重载,下标脚本不限于单个纬度,你可以
 定义多个入参的下标脚本满足自定义类型的需求。
 译者:这里附属脚本重载在本小节中原文并没有任何演示
 */

//\\\\\\\\\\\\下标脚本语法
/*
 下标脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。语法类似于实 例方法和计算型属性的混合。与定义实例方法类似,定义下标脚本使用 subscript 关键字,显式声明入参(一个或多个)和返回类型。与实例方法不同的是下标脚本可以设定为读写或只读。这种方式又有点像计算型属性的get ter和setter
 */
/*
subscript(index: Int) -> Int {
    get {
    //返回与入参匹配的Int类型的值
    }
    set(newValue){
    //执行赋值操作
    }
}
 newValue 的类型必须和下标脚本定义的返回类型相同。与计算型属性相同的是set的入参声明 newValue 就算不写,在set代码块中依然可以使用默认的 newValue 这个变量来访问新赋的值。
 与只读计算型属性一样,可以直接将原本应该写在 get 代码块中的代码写在 subscript 中:
 subscript(index: Int) -> Int {
 // 返回与入参匹配的Int类型的值
 }
*/


//下面代码演示了一个在 TimesTable 结构体中使用制度下标脚本的用法，该结构体用来展示传入整数的 n 倍
struct TimesTable {
    let multiplier : Int
    subscript(index: Int) -> Int{
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])")

/*
 在上例中,通过 TimesTable 结构体创建了一个用来表示索引值三倍的实例。数值 3 作为结构体 构造函数 入参初 始化实例成员 multiplier 。
 你可以通过下标脚本来得到结果,比如 threeTimesTable[6] 。这条语句访问了 threeTimesTable 的第 个元 素,返回6的3倍即18。
 注意:
 TimesTable 例子是基于一个固定的数学 式。它并不适合对 threeTimesTable[someIndex] 进行赋值操作,这也
 是为什么附属脚本只定义为只读的原因。
 */

//\\\\\\\\\下标脚本用法
/*
 根据使用场景不同下标脚本也具有不同的含义。通常下标脚本是用来访问集合(collection),列表(list)或 序列(sequence)中元素的快捷方式。你可以在你自己特定的类或结构体中自由的实现下标脚本来提供合适的功 能。
 */

// 例如,Swift 的字典(Dictionary)实现了通过下标脚本来对其实例中存放的值进行存取操作。在下标脚本中使 用和字典索引相同类型的值,并且把一个字典值类型的值赋值给这个下标脚本来为字典设值:
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

/*
 上例定义一个名为 numberOfLegs 的变量并用一个字典字面量初始化出了包含三对键值的字典实例。 numberOfLeg s 的字典存放值类型推断为 [String:Int] 。字典实例创建完成之后通过下标脚本的方式将整型值 2 赋值到字典实 例的索引为 bird 的位置中。
 更多关于字典(Dictionary)下标脚本的信息请参考读取和修改字典 (页 0)
 注意:
 Swift 中字典的附属脚本实现中,在 get 部分返回值是 Int? ,上例中的 numberOfLegs 字典通过附属脚本返回 的是一个 Int? 或者说“可选的int”,不是每个字典的索引都能得到一个整型值,对于没有设过值的索引的访 问返回的结果就是 nil ;同样想要从字典实例中删除某个索引下的值也只需要给这个索引赋值为 nil 即可。
 */

//\\\\\\\下标脚本选项
/*
 下标脚本允许任意数量的入参索引,并且每个入参类型也没有限制。下标脚本的返回值也可以是任何类型。下标 脚本可以使用变量参数和可变参数,但使用写入读出(in-out)参数或给参数设置默认值都是不允许的。
 
 一个类或结构体可以根据自身需要提供多个下标脚本实现,在定义下标脚本时通过入参的类型进行区分,使用下
 标脚本时会自动匹配合适的下标脚本实现运行,这就是下标脚本的重载。
 */

//一个下标脚本入参是最常见的情况,但只要有合适的场景也可以定义多个下标脚本入参。如下例定义了一个 x 结构体,将呈现一个 Double 类型的二维矩阵。 Matrix 结构体的下标脚本需要两个整型参数:

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValudForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
           assert(indexIsValudForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
           assert(indexIsValudForRow(row: row, column: column), "index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
/*
 Matrix 提供了一个两个入参的构造方法,入参分别是 rows 和 columns ,创建了一个足够容纳 rows * columns 个数的 Double 类型数组。通过传入数组长度和初始值0.0到数组的一个构造器,将 Matrix 中每个元素初始值 0.0。关于数组的构造方法和析构方法请参考创建一个空数组
 */

//可以通过传入合适的row 和 column 的数量来构造一个新的 Mareix 实例
var matrix = Matrix(rows: 2, columns: 2)

//将值付给带有 row 和 column 下标脚本的 matrix 实例表达式可以完成赋值操作，下标脚本入参使用逗号分隔
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//断言在下标脚本越界时触发:
//let someValue = matrix[2, 2]


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\继承（Inheritance）
/*
 • 定义一个基类(Base class)
 • 子类生成(Subclassing)
 • 重写(Overriding)
 • 防止重写
 一个类可以继承(inherit)另一个类的方法(methods),属性(properties)和其它特性。当一个类继承其它 类时,继承类叫子类(subclass),被继承类叫超类(或父类,superclass)。在 Swift 中,继承是区 分「类」与其它类型的一个基本特征。
 在 Swift 中,类可以调用和访问超类的方法,属性和下标脚本(subscripts),并且可以重写(override)这些 方法,属性和下标脚本来优化或修改它们的行为。Swift 会检查你的重写定义在超类中是否有匹配的定义,以此 确保你的重写行为是正确的。
 可以为类中继承来的属性添加属性观察器(property observers),这样一来,当属性值改变时,类就会被通知 到。可以为任何属性添加属性观察器,无论它原本被定义为存储型属性(stored property)还是计算型属性(co mputed property)。
 */

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\定义一个基类（Base class）
/*
不继承于其它类的类,称之为基类(base calss)。
注意:
Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话,这个类就自动成为基类。
 
下面的例子定义了一个叫 Vehicle 的基类。这个基类声明了一个名为 currentSpeed ,默认值是0.0的存储属性(属 性类型推断为Double)。currentSpeed属性的值被一个String 类型的只读计算型属性description使用,用来 创建车辆的描述。

Vehicle 基类也定义了一个名为 makeNoise 的方法。这个方法实际上不为 Vehicle 实例做任何事,但之后将会被 Vehicle 的子类定制:
*/
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
       return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //什么也不做-因为车辆不一定会有噪音
    }
}

//您可以用初始化语法创建一个 Vehicle 的新实例,即类名后面跟一个空括号:
let someVehicle = Vehicle()

//现在已经创建了一个 Vehicle 的新实例,你可以访问它的 description 属性来打印车辆的当前速度
print("Vehicle: \(someVehicle.description)")

//Vehicle 类定义了一个通用特性的车辆类,实际上没什么用处。为了让它变得更加有用,需要改进它能够描述一 个更加具体的车辆类

//\\\\\\\\\\\\\\\\\子类生成（Subclassing）

//子类生成(Subclassing)指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性,并且可以优化或 改变它。还可以为子类添加新的特性。
//为了指明某个类的超类，将超类的名字写在子类的后面，中间用 ： 分开

class SomeClass4: SomeClass {
    //类的定义
}

//下面一个例子，定义一个叫 Bicycle 的子类， 继承成父类 Vehicle
class Bicycle: Vehicle {
    var hasBasket = false
}
/*
 新的Bicycle类自动获得Vehicle类的所有特性,比如 currentSpeed和description属性,还有它的makeNois e 方法。
 除了它所继承的特性, Bicycle 类还定义了一个默认值为 false 的存储型属性 hasBasket (属性推断为 Bool)。
 */

//默认情况下,你创建任何新的 Bicycle 实例将不会有一个篮子，创建该实例后，可以为特定的 Bicycle 实例设置 hasBasket 属性为 true :
let bicycle = Bicycle()
bicycle.hasBasket = true

//你还可以修改 Bicycle 实例所继承的 currentSpeed 属性，和查询实例所继承的 despription 属性:
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

//子类还可以继续被其他类继承，下面的实例为 Bicycle 创建一个名为 Tandem （双人自行车）的子类
class Tandum: Bicycle {
    var  currentNumberOfPassengers = 0
}

//Tandem 从 Bicycle 继承了所有的属性与方法，这又使它同时继承了 Vehicle 的所有属性和方法、 Tandem 也增加了一个新的叫做 currentNumberOfPassengers 的存储属性，默认值为0

//如果你创建了一个 Tandem 的实例,你可以使用它所有的新属性和继承的属性,还能查询从 Vehicle 继承来的只读属性 description：

let tandem = Tandum()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\重写（Overriding）
/*
 子类可以为继承来的实例方法(instance method),类方法(class method),实例属性(instance propert y),或下标脚本(subscript)提供自己定制的实现(implementation)。我们把这种行为叫重写(overridin g)。
 如果要重写某个特性,你需要在重写定义的前面加上   关键字。这么做,你就表明了你是想提供一个重写 版本,而非错误地提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误,任何缺少   关键 字的重写都会在编译时被诊断为错误。
 关键字会提醒 Swift 编译器去检查该类的超类(或其中一个父类)是否有匹配重写版本的声明。这个 检查可以确保你的重写定义是正确的。

 */

//\\\\\\\\\ 访问超类的方法,属性及下标脚本
/*
当你在子类中重写超类的方法,属性或下标脚本时,有时在你的重写版本中使用已经存在的超类实现会大有裨
益。比如,你可以优化已有实现的行为,或在一个继承来的变量中存储一个修改过的值。
在合适的地方,你可以通过使用 super 前缀来访问超类版本的方法,属性或下标脚本:
• 在方法 someMethod 的重写实现中,可以通过 super.someMethod() 来调用超类版本的 someMethod 方法。
• 在属性 someProperty 的 getter 或 setter 的重写实现中,可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
• 在下标脚本的重写实现中,可以通过 super[someIndex] 来访问超类版本中的相同下标脚本。
*/

//\\\\\\\\\\\\\\\重写方法
//在子类中，可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现。
//下面例子定义了 Vehicle 的一个新的子类，叫 Train ，它重写了从 Vehicle 继承来的 makeNoise 方法

class Train: Vehicle {
    override func makeNoise() {
        print("choo choo")
    }
}

let train = Train()
train.makeNoise()

//\\\\\\\\\\\\\\重写属性
/*
 可以重写继承来的实例属性或类属性,提供自己定制的getter和setter,或添加属性观察器使重写的属性可以观察属性值什么时候发生改变。
 */

//\\\\\重写属性的Getters和Setters
/*
 你可以提供定制的 getter(或 setter)来重写任意继承来的属性,无论继承来的属性是存储型的还是计算型的 属性。子类并不知道继承来的属性是存储型的还是计算型的,它只知道继承来的属性会有一个名字和类型。你在 重写一个属性时,必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类 型的属性相匹配的。
 
 你可以将一个继承来的只读属性重写为一个读写属性,只需要你在重写版本的属性里提供 getter 和 setter 即 可。但是,你不可以将一个继承来的读写属性重写为一个只读属性。
 注意:
 如果你在重写属性中提供了 setter,那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改 继承来的属性值,你可以直接通过 super.someProperty 来返回继承来的值,其中 someProperty 是你要重写的属 性的名字。
 */

//以下的例子定义了一个新类,叫 Car ,它是 Vehicle 的子类。这个类引入了一个新的存储型属性叫做 gear ,默 认为整数1。 Car 类重写了继承自 Vehicle 的description属性,提供自定义的,包含当前档位的描述:
class Car: Vehicle {
    var gear = 1
    override var description: String {
    return super.description + " in gear \(gear)"
    }
}
//重写的 description 属性,首先要调用 super.description 返回 Vehicle 类的 description 属性。之后, Car 类 版本的 description 在末尾增加了一些额外的文本来提供关于当前档位的信息。

//如果你创建了 Car 的实例并且设置了它的 gear 和 currentSpeed 属性,你可以看到它的 description 返回了 Car 中定义的 description :
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

//\\\\\\\重写属性观察器（Property Observer）
/*
 可以在属性重写中为一个继承来的属性添加属性观察器。这样一来,当继承来的属性值发生改变时,你就会被 通知到,无论那个属性原本是如何实现的。关于属性观察器的更多内容,请看属性观察器 (页 0)。
 注意: 你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置 的,所以,为它们提供 willSet 或 didSet 实现是不恰当。此外还要注意,你不可以同时提供重写的 setter 和 重写的属性观察器。如果你想观察属性值的变化,并且你已经为那个属性提供了定制的 setter,那么你在 sett er 中就可以观察到任何值变化了。
 */

//下面的例子定义了一个新类叫 AutomaticCar ,它是 Car 的子类。 AutomaticCar 表示自动挡汽车,它可以根据当前的速度自动选择合适的挡位:

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
         gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

//当你设置 AutomaticCar 的 currentSpeed 属性,属性的 didSet 观察器就会自动地设置 gear 属性,为新的速度选 择一个合适的挡位。具体来说就是,属性观察器将新的速度值除以10,然后向下取得最接近的整数值,最后加1来 得到档位 gear 的值。例如,速度为10.0时,挡位为1;速度为35.0时,挡位为4:

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\防止重写
/*
 你可以通过把方法,属性或下标脚本标记为 final 来防止它们被重写,只需要在声明关键字前加上 final 特性即
 可。(例如: final var , final func , final class func , 以及 final subscript )
 如果你重写了 final 方法,属性或下标脚本,在编译时会报错。在类扩展中的方法,属性或下标脚本也可以在扩
 展的定义里标记为 final。
 你可以通过在关键字 class 前添加 final 特性( final class )来将整个类标记为 final 的,这样的类是不可被 继承的,任何子类试图继承此类时,在编译时会报错。
 */



//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\析构过程（Deinitialization）
/*
 • 析构过程原理
 • 析构器操作
 析构器只适用于类类型,当一个类的实例被释放之前,析构器会被立即调用。析构器用关键字 deinit 来标示,类
 似于构造器要用 init 来标示。

 */

//\\\\\\\\\\\\\\\\\\\\\\析构过程原理
/*
 Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述,Swift 通过 自动引用计数(AR C) 处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是,当使用自己的资源时,你可能 需要进行一些额外的清理。例如,如果创建了一个自定义的类来打开一个文件,并写入一些数据,你可能需要在 类实例被释放之前手动去关闭该文件。
 在类的定义中,每个类最多只能有一个析构器,而且析构器不带任何参数,如下所示:
 
 
 deinit {
 // 执行析构过程
 }
 析构器是在实例释放发生前被自动调用。析构器是不允许被主动调用的。子类继承了父类的析构器,并且在子类
 析构器实现的最后,父类的析构器会被自动调用。即使子类没有提供自己的析构器,父类的析构器也同样会被调
 用。
 因为直到实例的析构器被调用时,实例才会被释放,所以析构器可以访问所有请求实例的属性,并且根据那些属
 性可以修改它的行为(比如查找一个需要被关闭的文件)。
 */

//\\\\\\\\\\\\\\\\\\\\\\\\析构器操作

//这是一个析构器操作的例子。这个例子描述了一个简单的游戏,这里定义了两种新类型,分别是 Bank 和 Playe r 。 Bank 结构体管理一个虚拟货币的流通,在这个流通中我们设定 Bank 永远不可能拥有超过 10,000 的硬 币,而且在游戏中有且只能有一个 Bank 存在,因此 Bank 结构体在实现时会带有静态属性和静态方法来存储和管 理其当前的状态。


class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}
/*
 Bank 根据它的 coinsInBank 属性来跟踪当前它拥有的硬币数量。 Bank 还提供两个方法—— vendCoins(_:) 和 ceiveCoins(_:) ,分别用来处理硬币的分发和收集。
 vendCoins(_:) 方法在bank对象分发硬币之前检查是否有足够的硬币。如果没有足够多的硬币, Bank 会返回一个 比请求时要小的数字(如果没有硬币留在bank对象中就返回 0)。 vendCoins 方法声明 numberOfCoinsToVend 为一个 变量参数,这样就可以在方法体的内部修改数字,而不需要定义一个新的变量。 vendCoins 方法返回一个整型 值,表明了提供的硬币的实际数目。
 receiveCoins 方法只是将bank对象的硬币存储和接收到的硬币数目相加,再保存回bank对象。
 */

//Player 类描述了游戏中的一个玩家。每一个 player 在任何时刻都有一定数量的硬币存储在他们的钱包中。这通 过 player 的 coinsInPurse 属性来体现:
class Player1 {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(numberOfCoinsRequested: coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(numberOfCoinsRequested: coins)
    }
    deinit {
        Bank.receiveCoins(coins: coinsInPurse)
    }
}
//每个 Player 实例构造时都会设定由硬币组成的启动额度值,这些硬币在bank对象初始化的过程中得到。如果在bank对象中没有足够的硬币可用, Player 实例可能收到比指定数目少的硬币。

//Player 类定义了一个 winCoins(_:) 方法,该方法从bank对象获取一定数量的硬币,并把它们添加到玩家的钱 包。 Player 类还实现了一个析构器,这个析构器在 Player 实例释放前被调用。在这里,析构器的作用只是将玩 家的所有硬币都返回给bank对象:

var playerOne: Player1? = Player1(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins") // 输出 "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// 输出 "There are now 9900 coins left in the bank"


































































