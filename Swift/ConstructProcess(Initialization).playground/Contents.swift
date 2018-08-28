

//: Playground - noun: a place where people can play

import UIKit

//**   构造过程    **//
/*
 存储属性的初始赋值
 自定义构造过程
 默认构造器
 值类型的构造器代理
 类的继承和构造过程
 可失败构造器
 必要构造器
 通过闭包或函数设置属性的默认值
 */


/*
 构造过程是使用 类, 结构体或枚举类型的实例之前的准备过程. 在新实例可用前必须执行这个过程. 具体操作包括设置实例中每个存储属性的初始值和执行其他必要的设置或初始化工作.
 通过定义构造器来实现构造过程,这些构造器可以看做是用来创建特定类型新实例的特殊方法. 与 Objective-C 中的构造器不同, Swift 的构造器无需返回值,它们的主要任务是保证新实例在第一次使用前完成正确的初始化.
 类实例也可以通过定义析构器在实例释放之前执行特定的清除工作.
 */



///  存储属性的初始赋值
/*
 类和结构体在创建实例时, 必须为所有存储属性设置合适的初始值. 存储属性的值不能处于一个未知的状态
 可以在构造器中为存储型属性赋初值, 也可以再定义属性时为其设置默认值.
 注意: 当为存储型属性设置默认值火灾构造器中为其赋值时, 它们的值是被直接设置的,不会触发任何属性观察者
 */


/// 构造器
/*
 构造器在创建某个特定类型的新实例是被调用.它的最简形式类似于一个不带任何参数的实例方法,以关键字 init 命名:
 init() {
    // 在此执行构造过程
 }
 */

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

let f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


/// 默认属性值
/*
 可以在声明属性时为其设置默认值
 注意:
 如果一个属性总是使用相同的初始值. 那么为其设置一个默认值比每次都在构造器中赋值要好/ 这两种方法的效果是一样的,只不过使用默认值让属性的初始化和声明结合得更紧密. 使用默认值能让构造器更简洁,更清晰, 且能通过默认值自动推导出属性的类型; 同时,可能充分利用默认构造器,构造器继承等特性.
 struct Fahrenheit {
     var temperature = 32.0
 }
 */



/// 自定义构造过程
/*
   可以通过输入参数和可选类型的属性来定义构造过程,也可以在构造过程中修改常量属性
 */

// 构造参数
/*
 自定义构造过程时,可以在定义中提供构造参数,指定所所需值的类型和名字. 构造参数的功能和语法跟函数和方法的参数相同
 */

struct Celsius {
    var temperatureInCelsius: Double
    init(formFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0)  / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(formFahrenheit: 212.0)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)


/// 参数的内部名称和外部名称
/*
 跟函数和方法参数相同,构造参数也拥有一个构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字
 然而,构造器并不像函数和方法那样在括号前有一个可辨别的名字.因此在调用构造器时,主要通过构造器中的参数名和类型来确定应该调用的构造方法. 正因为参数如此重要,如果在定义构造器时没有提供参数的外部名字, Swift 会为构造器的每个参数自动生成一个给内部名字相同的外部名.
 
 注意:
    如果不通过外部参数名字传值,是没法调用这个构造器的. 只要构造器定义了某个外部参数名,就必须使用它
 */

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halgGray = Color(white: 0.5)

/// 不带外部名的构造器参数
/*
  如果不希望为构造器的某个参数提供外部名字,可以使用下划线(_)来显示描述它的外部名,以此重写上面所说的默认行为
 */

extension Celsius {
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius(37.0)


/// 可选属性类型
/*
 如果定制的类型包含一个逻辑上允许取空的存储属性--- 无论是因为他无法在初始化时赋值,还是因为它在之后某个时间点可以赋值为空
 --- 都需要将它定义为可选类型. 可选类型的属性将自动初始化为 nil, 表示这个属性是有意在初始化时设置为空的
 */

class ServeyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = ServeyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
//  调查问题的答案在回答前是无法确定的,因为属性 response 声明为 String? 类型,(或者说是可选字符串类型). 当 SurveyQuestion 实例化时,它将自动赋值为 nil, 表明此字符串暂时会没有值
cheeseQuestion.response = "Yes, I do like cheese"


/// 构造过程中常量属性的修改
/*
 可以在构造过程中的任意时间点给常量属性指定一个值,只要在构造过程结束时是一个确定的值. 一旦常量属性被赋值,他讲永远不可更改
 
 注意: 对于类的实例来说, 它的常量属性只能在定义它的类的构造过程中修改; 不能在子类中修改
 
 class SurveyQuestion {
     let text: String
     var response: String?
     init(text: String) {
         self.text = text
     }
     func ask() {
         print(text)
     }
 }
 
 let beetsQuestion = SurveyQuestion(text: "How about beets?")
 beetsQuestion.ask()
 // 打印 "How about beets?"
 beetsQuestion.response = "I also like beets. (But not with cheese.)"
 */


//*  默认构造器 *//
/*
 如果结构体或类的所有属性都有默认值,同时没有自定义的构造器,那么 Swift 会给这些结构体霍磊提供一个默认构造器(default initializers). 这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例
 */

class ShopingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

let item = ShopingListItem()


////  结构体的逐一成员构造器
/*
 除了上面提到的默认构造器,如果结构体没有提供自定义的构造器,它们将自动获取一个逐一成员构造器,即使结构体的存储型属性没有默认值.
 
 逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法. 在调用逐一成员构造器时,通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值.
 */

struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)


//// 值类型的构造器代理
/*
 构造器可以通过调用其他构造器来完成实例的部分构造过程. 这一过程称为 构造器代理, 它能减少过个构造器间的代码重复

  构造器代理的实现规则和形式在值类型和类类型中有所不同. 值类型(结构体和枚举类型)不支持继承, 所以构造器代理的过程相对简单,因为它们只能代理给自己的其他构造器. 类则不同,它可以继承自其他类,这意味着类有责任保证其所继承的存储属性在构造时也能正确的初始化.
 
 对于值类型, 可以使用 self.init 在自定义的构造器中引用相同类型类型中的其他构造器. 并且只能在构造器内部调用 self.init
 
 ********* 如果为某个值类型定义了一个自定义的构造器,将无法访问到默认构造器(如果是结构体,还将无法访问逐一成员构造器).这种限制可以防止为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用自动生成的构造器
 
 ??? 注意
   假如希望使用默认构造器,逐一成员构造器以及自己的自定义构造器都能用来创建实例,可以将自定义的构造器写到扩展(extension) 中,而不是写在值类型的原始定义中.
 */

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    // 在功能上跟没有自定义构造器时自动获得的默认构造器是一样的.这个构造器是一个空函数,使用一对大括号{} 来表示,它没有执行任何构造过程.
    init() {
    
    }
    // 在功能上跟结构体没有自定义构造器时获取的逐一成员构造器是一样的.
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    // 先通过 center 和 size 的值计算出 origin 的坐标.然后再调用(或者说代理给)init(origin:size:)构造器来将新的 origin 和 size 值赋值到对应的属性中
    // 构造器init(center:size:)可以直接将origin和size的新值赋值到对应的属性中。然而，利用恰好提供了相关功能的现有构造器会更为方便，构造器init(center:size:)的意图也会更加清晰。
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))



//**  类的继承和构造过程  **//
/*
 类里面的所有存储属性---包括所有继承自父类的属性---都必须在构造过程中设置初始值
 
 Swift 为类类型提供了两种构造器来确保实例中所有存储属性都可以获得初始值,它们分别是指定构造器和便利构造器
 */


//  指定构造器和便利构造器
/*
  指定构造器是类中最主要的构造器. 一个指定构造器将初始化类中提供的所有属性,并根据父类链往上调用父类的构造器来实现父类的初始化.
 
 每一个类都必须拥有至少一个指定构造器. 在某些情况下,许多个类通过继承了父类中的指定构造器而满足了这个条件.
 
 便利构造器是类中比较次要的,辅助型的构造器.可以定义便利构造器来调用同一类中的指定构造器,并为其参数提供默认值. 可以定义遍历构造器来创建一个特殊用途或特定输入值的实例.
 应当在必要的时候为类提供遍历构造器,比方说,某种情况下通过使用便利构造器来快捷调用某个指定构造器,能够节省更多开发时间并让类的构造过程呢过更清晰明了
 */


//// 指定构造器和便利构造器语法
/*
 类的指定构造器的写法跟值类型简单构造器一样:
     init(parameters) {
 
     }
 
便利构造器也采用相同样式的写法,但需要在 init 关键字前放置 convenience 关键字, 并使用空格分开
     convenience init(parameters) {
 
     }
 
 */

//// 类的构造器代理规则
/*
 为了简化指定构造器和便利构造器之间的调用关系, Swift 采用以下三条规则来限制构造器之间的代理调用:
  规则 1
     指定构造器必须调用其直接父类的指定构造器
  规则 2
     便利构造器必须调用同类中定义的其他构造器
  规则 3
     便利构造器必须最终导致一个指定构造器被调用
 方便记忆的方法:
    指定构造器必须总是向上代理
    遍历构造器必须总是横向代理
 
 ???? 注意: 这些规则不会影响类的实例如何创建. 任何构造器都可以用来创建完全初始化的实例, 这些规则只会影响类定义如何实现.
 
 */


//// 两段式构造过程
/*
  Swift 中类的构造过程包含两个阶段. 第一个阶段,每个存储属型都被引入它们的类指定一个初始值. 当每个存储存储属性的初始值被确定后, 第二阶段开始,它给每个类一次机会,在新实例准备使用之前进一步定制他们的存储型属性
 
 两段式构造过程的使用让构造过程更安全,同时在整个类层级结构中基于每个类完全的灵活性. 这两段式构造过程可以防止属性值在初始化之前被访问,也可以防止属性被另外一个构造器意外地赋予不同的值.
 
 ???? 注意: Swift 的两段式构造过程跟 Objective-C 中构造过程类似. 最主要的区别在于阶段 1, Objective-C 给给每一个属性赋值为0或为空值(比如0或 nil). Swift 的构造流程则更加灵活,它允许你设置定制的初始值,并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况.
 
 Swift 编译器执行 4 种有效的安全检查,以保证两段构造过程不出错地完成:
    安全检查 1
       指定构造器必须保证它所在类引入的所有属性都必须先初始化完成,之后才能将其他构造任务向上代理给父类中的构造器.
       如上所述. 一个对象只有在其所有存储属性确定之后才能完全初始化. 为了满足这一规则,指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化.
    安全检查 2
       指定构造器必须向上代理调用父类的构造器,然后再为继承的属性设置新值.如果没有这么做,指定构造器赋予的新值将会被父类中的构造器所覆盖.
    安全检查 3
       便利构造器必须先代理调用同一个类中的其他构造器, 然后再为任意属性赋新值. 如果没有这么做,便利构造器赋予的新值将被同一类中其他指定构造器所覆盖.
 
    安全检查 4
       构造器在第一阶段完成之前,不能调用任何实例方法,不能读取任何实例属性的值,不能引用 self 作为一个值
       类实例在第一阶段结束以前并不是完全有效的. 只有第一阶段完成后,该实例成为有效实例,才能访问属性和调用方法
 
 
 以下是两段式构造过程中基于上述安全检查的构造流程展示:
   阶段 1:
      * 某个指定构造器或便利构造器被调用
      * 完成新实例内存的分配,但此时内存还没有被初始化
      * 指定构造器确保其所在类引入的所有存储属性都已赋初值. 存储型属性的内存完成初始化.
      * 指定构造器将调用父类的构造器,完成父类属性的初始化.
      * 这个调用父类构造器的过程沿着构造器链一直往上执行,直到到达构造器链的最顶部.
      * 当到达了构造器链最顶部,且已保证所有实例包含的存储属性都已经赋值,这个实例的内存被认为已经完成初始化.此时阶段 1 完成.
 
   阶段 2:
      * 从顶部构造器链一直往下,每个构造器链中类的指定构造器都有机会进一步定制实例.构造器此时可以访问 self, 修改它的属性并调用实例方法等等.
      * 最终,任意构造器链中的遍历构造器可以有机会定制实例和使用 self
 */


//// 构造器的继承和重写
/*
 跟 Objective-C 中的子类不同, Swift 中的子类默认情况下不会继承父类的构造器. Swift 的这种机制可以防止一个父类的简单构造器被另一个更精细的子类继承,并被错误地用来创建子类的实例.
   ???? 父类的构造器仅会在安全和适当的情况下被继承.详见 构造器的自动继承.
 
 假如希望自定义的子类中能提供一个或多个跟父类相同的构造器,可以在子类中提供这些构造器的自定义实现
 
 当在编写一个和父类中指定构造器相匹配你的子类构造器时,实际上是指爱重写父类的这一指定构造器. 因此必须在定义子类构造器时带上 override 修饰符.即使重写的是系统自带提供的默认构造器,也需要带上 override 修饰符,详见 默认构造器
 
 正如重写属性,方法或者是下标, override 修饰符会被编译器去检查弗雷中是否有相匹配的指定构造器, 并验证构造器参数是否正确.
    ???? 当重写一个父类的指定构造器时,总是需要写 override 修饰符, 即使子类将父类的指定构造器重写为了便利构造器
 
 相反, 如果编写了一个和父类便利构造器相匹配的子类构造器,由于子类不能直接调用父类的便利构造器(每个规则都在上文中类的构造器代理规则有所描述),因此严格意义上讲,子类并未对一个父类构造器提供重写,最后的结果就是: 子类中"重写" 父类遍历构造器时,不需要加 override 前缀.
 
 */

class Vehicle {
    // 存储型属性
    var numberOfWheels = 0
    // 计算型属性
    var description: String  {
        return "\(numberOfWheels) wheel(s)"
    }
}
// Vehicle 类职位存储型属性提供默认值,而不定义构造器.因此,它会得一个默认构造器. 自动获取的默认构造器总会是类中的指定构造器

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
// 子类Bicycle 定义了一个自定义指定构造器 init(). 这个指定构造器和父类的指定构造器相匹配,所以 Bicycle 中的指定构造器需要带上 override 修饰符
// Bicycle的构造器init()以调用super.init()方法开始，这个方法的作用是调用Bicycle的父类Vehicle的默认构造器。这样可以确保Bicycle在修改属性之前，它所继承的属性numberOfWheels能被Vehicle类初始化。在调用super.init()之后，属性numberOfWheels的原值被新值2替换。

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

//  ???? 子类可以在初始化时修改继承来的变量属性,但是不能修改继承来的常量属性



/////   构造器的自动继承
/*
  子类在默认情况下不会继承父类的构造器. 但是如果满足特定条件, 父类构造器是可以被自动继承的.
  在实践中, 这意味着对于许多常见场景不必重写父类的构造器,并且可以在安全的情况下以最小的代价继承父类的构造器
 
 
 假设为子类中引入的所有新属性都提供了默认值, 以下 2 个规则适用:
   规则 1
     如果子类没有定义任何指定构造器(可以有便利构造器), 它将会自动继承所有父类的指定构造器
 
   规则 2
    如果子类中提供了所有父类指定构造器的实现----无论是通过规则 1 继承过来的,还是提供了自定义实现----它将自动继承所有父类的遍历构造器
 
   即使在子类中添加了更多的便利构造器,这两条规则仍然适用.
   注意 ????  对于规则 2, 子类可以将父类的指定构造器实现为便利构造器
 */



/////    指定构造器和遍历构造器实践
/*
   接下来的例子将在实践中展示指定构造器,遍历构造器的自动继承.这个例子定义了包含三个类 Food, RecipeIngredient 以及 ShoppingListItem 的层次结构,并将演示他们的构造器如何相互作用的.
 
   类层次中的基类是 Food, Food 类引入 name 的 String 类型的属性,并提供了两个构造器来创建 Food 实例
 */

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

// 类类型没有默认的逐一成员构造器, 所以 Food 类提供了一个接受单一参数 name 的指定构造器.
let nameMeat = Food(name: "Bacon")
/*
 Food 类中的构造器 init(name: String) 被定义为一个指定构造器,因为它能确保 Food 实例所有存储型属性被初始化. Food 类没有父类,所以 init(name: String) 构造器不需要调用 super.init() 来完成构造过程
 
 Food 类同样提供了一个没有参数的便利构造器 init(). 这个 init() 构造器为新食物提供了一个默认的占位名字,通过横向代理到指定构造器 init(name: String) 并给参数 name 传值 [Unnamed]来实现
 */

let mysteryMeat = Food()

/*
 类层级中的第二个类是 Food 的子类 RecipeIngredient. RecipeIngredient 类中用来表示食谱中的一项原料. 它引入了 Int 类型的属性 quantity (以及从 Food 继承过来的 name 属性), 并且定义了两个构造器来创建 RecipeIngredient 实例:
 
 
 RecipeIngredient 类拥有一个指定构造器 init(name: String, quantity: Int),它可以从来填充 RecipeIngredient 实例的所有属性值. 这个构造器一开始先将传入的 quantity 参数赋值给 quantity 属性,这个属性也是唯一在 RecipeIngredient 类中新引入的属性. 随后,构造器向上代理到父类 Food 的 init(name: String)
 RecipeIngredient 类还定义了一个遍历构造 init(name: String), 它只通过 name 来创建 RecipeIngredient 的实例. 这个遍历构造器假设任意 RecipeIngredient 实例的 quantity 为 1, 所以不需要显示指明数量即可创建出实例. 这个便利构造器的定义可以更加方便和快捷地创建实例,并且避免了创建多个 quantity 为 1 的 RecipeIngredient 实例时的代码重复.这个遍历构造器只是简单地横向代理到类中的指定构造器, 并为 quantity 参数传递 1

 注意:???? RecipeIngredient 的便利构造器 init(name: String) 使用了跟 Food 中指定构造器 init(name: String) 相同的参数. 由于这个便利构造器重写了父类的指定构造器 init(name: String), 因此必须在前面使用 override 修饰符
 
 尽管 RecipeIngredient 将父类的指定构造器重写为便利构造器,它依然提供了父类的所有指定构造器的实现. 因此,RecipeIngredient 会自动继承父类的所有便利构造器
 在这个例子中, RecipeIngredient 的父类 Food, 它有一个便利构造器 init(). 这个便利构造器会被 RecipeIngredient 继承. 这个继承版本的 init() 功能上跟 Food 提供的版本是一样的,它只是会代理代理到 RecipeIngredient 版本的 init(name: String) 而不是 Food 提供的版本.
 */

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMystetyItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


/*
   类层级中第三个也是最后一个类是 RecipeIngredient 的子类,叫做 ShoppingListItem. 这个类构建了购物车中出现的某一种食谱原料
   购物单中的每一项总是从未购买状态开始的. 为了呈现这一事实, ShoppingListItem 引入一个布尔类型的属性 purchased, 它的默认值是 false. ShoppingListItem 还添加了一个计算型属性 description, 它提供了关于 ShoppingListItem 实例的一些文字描述
 */

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

// 注意: ???? ShoppingListItem 没有定义构造器来为 purchased 提供初始值,因为添加到购物单的物品的初始状态总是未购买
// 因为他为自己引入的所有属性都提供了默认值,并且自己没有定义任何构造器, ShoppingListItem 将自动继承所有父类中的指定构造器和便利构造器

var breakfastList = [ShoppingListItem(),
                     ShoppingListItem(name: "Bacon"),
                     ShoppingListItem(name: "Eggs", quantity: 6)]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}



/////    可失败构造器
/*
 如果一个类,结构体或枚举类型的对象,在构造过程中有可能失败,则可为其定义一个可失败构造器. 这里所指的"失败"是指,如给构造器传入无效的参数值,或缺少某种所需要的外部资源,又或是不满足某种必要的条件等.
 
 为了妥善处理这种构造过程中可能会失败的情况,可以在一个类,结构体或是枚举类型的定义中,添加一个或多个可失败构造器. 其语法为 init 关键字后面添加问号(init?)
 
 注意: ???? 可失败构造器的参数名和参数类型,不能与其他非可失败构造器的参数名,及其参数类型相同
 
 可失败构造器会创建一个类型为自身类型的可选型的对象. 通过 return nil 语句来表明可失败构造器在何种情况下应该失败
 注意: ???? 严格来说,构造器都不支持返回值. 因为构造器本身的作用,只是为了保证对象能被正确构造. 因此只是用 return nil 表明可失败构造器构造失败,而不要用关键字 return 来表明构造成功
 
 例如: 实现针对数字类慈宁宫转换的可失败构造器. 确保数字类型之间的转换能保持精确的值,使用这个 init(exactly:)构造器.如果类型转换不能保持值的不变,则这个构造器构造失败
 */

let wholeNumber: Double = 12345.0
let pi = 3.14159
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)
// valueChanged 是 Int? 类型, 不是 Int 类型
if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}


/// 定义一个名为 Animal 的结构体, 其中名为 species 的 String 类型的常量属性. 同时该结构体还定义了一个接受一个名为species 的 String 类型参数的 可失败构造器. 这个可失败构造器检查传入的参数是否为一个空字符串. 如果为空字符串,则构造失败. 否则, species 属性被赋值,构造成功
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// 注意:???? 空字符串人(如"", 而不是 "Giraffe") 和 一个值为 nil 的可选类型的字符串是两个完全不同的概念. 上个例子中的空字符串("")其实是一个有效的,非可选类型的字符串. 这里之所以让 Animal 的可失败构造器构造失败,只是因为对于 Animal 这个类的 species 属性来说,它更适合有一个具体的值,而不是空字符串



//// 枚举类型的可失败构造器
/*
 可以通过一个带有一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员. 如果提供的参数无法匹配任何枚举成员,则构造失败
 */

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahreheitUnit = TemperatureUnit(symbol: "F")

if fahreheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknowUnit = TemperatureUnit(symbol: "X")

if unknowUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}


///// 带原始值的枚举类型的可失败构造器
/*
 带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:), 该可失败构造器有一个名为 rawValue 的参数, 其类型和枚举类型的原始值类型一致, 如果该参数的值能够和某个枚举成员的原始值匹配,则该构造器构造相应的枚举成员,否则构造失败.
 */

enum TemperatureU: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitU = TemperatureU(rawValue: "F")

if fahrenheitU != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknowU = TemperatureU(rawValue: "X")

if unknowU == nil {
    print("This is not a defined temerature unit, so initialization failed.")
}


/////  构造失败的传递
/*
 类,结构体,枚举的可失败构造器可以横向代理到类中的其他可失败构造器. 类似的,子类的可失败构造器也能向上代理到父类的可失败构造器
 
 无论是向上代理还是横向代理,如果代理到的其他可失败构造器触发构造失败,整个过程将立即终止,接下来的任何构造代码都不会被执行
 
 注意: ???? 可失败构造器也可以代理到其他的非可失败构造器. 通过这种方式,可以增加一个可能的失败状态到现有的构造器中
 */


class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zero = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zero.name), quantity: \(zero.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

if let oneUnNamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnNamed.name), quantity: \(oneUnNamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}



/////     重写一个可失败构造器
/*
 如同其他的构造器,可以在子类中重写父类的可失败构造器. 或者可以用子类的非可失败构造器重写父类的可失败构造器. 这使得可以定义一个不会构造失败的子类,即使父类的构造器允许构造失败
 
 注意: ???? 当用子类的非可失败构造器重写父类的可失败构造器时,向上代理到父类的可失败构造器的唯一方式是对弗雷德可失败构造器的返回值进行强制解包
      ???? 可以用非可失败构造器重写可失败构造器,但是反过来却不行.
 */

class Document {
    var name: String?
    // 该构造器创建一个 name 属性的值为 nil 的 Document 的实例
    init() {}
    // 该构造器创建一个 name 属性的值为非空字符串的 Document 的实例
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

// 子类重写父类的所有构造器

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    // 用一个非可失败构造器 init(name:)重写父类的可失败构造器 init?(name:). 因为子类用另一种方式处理了空字符串的情况,所以不再需要一个可失败构造器,因此子类用一个非可失败构造器替代了父类的可失败构造器
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

// 可以在子类的非可失败构造器中使用强制解包来调用父类的可失败构造器

class UntitledDocument: Document {
    // 如果再调用父类的可失败构造器 init?(name:) 时传入的是空字符串,那么强制解包造作会引发运行时错误. 不过,因为这里通过非空的字符串常量来调用它,所以并不会发生运行时错误.
    override init() {
        super.init(name: "[Unititled]")!
    }
}

///// 可失败构造器 init!
/*
 通常来说通过在 init 关键字后添加问号的方式(init?)来定义一个可失败构造器, 但可以通过在 init 后面添加感叹号的方式来定义一个可失败构造器(init!), 该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象
 可以在 init? 中代理到 init!, 反之亦然. 也可以用 init? 重写 init!, 反之亦然. 还可以用 init 代理到 init!, 不过,一旦 init! 构造失败,则会触发一个断言.
 */


////******    必要构造器    ******////
/*
 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器
 */

class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

class SomeSubClass: SomeClass {
    // 在子类重写父类的必要构造器时,必须在子类的构造器前也添加  required 修饰符,表明该构造器要求也应用于继承链后面的子类. 在重写父类中必要的指定构造器时,不需要添加 override 修饰符
    //    required init() {
    //        // 构造器的实现代码
    //    }
    
    // ???? 如果子类继承的构造器能够满足必要构造器的要求, 则无需在子类中显式提供必要构造器的实现

}

let subInstance = SomeSubClass()



////******    通过闭包或函数设置属性的默认值    ******////
/*
 如果某个存储属性的默认值需要一些定制或设置, 可以使用闭包或全局函数为其提供定制的默认值. 每当某个属性所在类型的新实例被创建时,对应的闭包或函数会被调用,而它们的返回值会当做默认值赋值给这个属性.
 
 这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量,然后修改它的值以满足预期的初始化状态,最后返回这个临时变量,作为属性的默认值.
 
 class SomeClass {
     let someProperty: SomeType = {
         // 在这个闭包中给 someProperty 创建一个默认值
         // someValue 必须和 someType 类型相同
         return someValue
     }()
 }
 注意: ???? 如果使用闭包来初始化属性,请记住在闭包执行时,实例的其他部分还没有初始化. 这意味着不能在闭包中访问其他属性,即使这些属性有默认值. 同样也不能使用隐式的 self 属性,或者调用其他任何实例方法.
 */

struct CheckerBoard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
            var isBlack = false
            for i in 1...8 {
                for j in 1...8 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

/*
 没当一个新的 CheckerBoard 实例被创建时,赋值闭包会被执行, boardColors 的默认值会被计算出来并返回.
 */

let board = CheckerBoard()
print(board.squareIsBlackAtRow(row: 0, column: 1))

print(board.squareIsBlackAtRow(row: 7, column: 7))



































