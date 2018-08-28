


//: Playground - noun: a place where people can play

import UIKit

////***            自动引用计数           ***////
/*
 * 自动引用计数的工作机制
 * 自动引用计数实践
 * 类实例之间的循环强引用
 * 解决实例之间的循环强引用
 * 闭包引起的循环强引用
 * 解决闭包引起的循环强引用
 
 Swift 使用自动引用计数(ARC) 机制来跟踪和管理应用程序的内存. 通常情况下,Swift 内存管理机制一直会起作用,无需自己来考虑的管理. ARC 会在类的实例不再被使用时自动释放其占用的内存.
 
 然而在少数情况下,为了能帮助管理内存,ARC 需要更多的代码之间关系的信息.
 
 注意: ???? 引用计数仅仅应用于类的实例. 结构体和枚举类型是值类型,不是引用类型,也不是通过引用的方式存储和传递
 */


/////***   自动引用计数的工作原理
/*
  当每次创建一个累的新的实例的时候,ARC 会分配一块内存来存储该实例信息. 内存中会包含实例的类型和信息,以及这个实例所有相关联的存储属性的值.
 
 此外,当实例不再被使用时, ARC 释放实例做占用的内存,并让释放的内存能挪作他用. 这确保了不再被使用的实例,不会一直占用内存空间.
 
 然而,当 ARC 收回和释放了正在使用中的实例,该实例的属性和方法将不能再被访问和调用. 实际上,如果试图访问这个实例,应用程序很可能会崩溃.
 
 为了保证使用中的实例不会被销毁, ARC 会跟踪和计算每个实例正在被多少属性,常量被变量所引用.哪怕实例的引用数为 1 , ARC 都不会销毁这个实例.
 
 为了使上述成为可能, 无论将实例赋值给属性,常量或变量,它们都会创建此实例的强引用.之所以称之为 "强"引用, 是因为它会将实例牢牢的保持住,只要强引用还在,实例是不允许被销毁的.
 */


/////***   自动引用计数实践

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is beging initialized")
    }
    
    deinit {
        print("\(name) is beging deinitialized")
        
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil



/////***   类实例之间的循环强引用

class People {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: People?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}


var john: People?
var unit4A: Apartment?

john = People(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john


john = nil
unit4A = nil



/////***   解决实例之间的循环轻循环引用
/*
 Swift 提供了两种办法来解决在使用类的属性时所遇到循环强引用问题: 弱引用(weak reference) 和 无主引用 (unowned reference)
 
 弱引用和无主引用允许循环应用中的一个实例引用而另一个实例不保持强引用. 这样实例能够互相引用而不产生循环强引用.
 
 当其他的实例有更短的生命周期时,使用弱引用, 也就是说,当其他实例析构在先时. 相比较之下,当其他实例有相同的或者更长的生命周期时,请使用无主引用.
 */



/////   弱引用
/*
 弱引用不会对其引用的实例保持强引用,因而不会阻止 ARC 销毁被引用的实例. 这个特性阻止了引用变为循环强引用. 声明属性或变量时, 在前面加上 weak 关键字表明这是一个弱引用.
 
 因为弱引用不会保持所引用的实例,即使引用存在,实例也可能被销毁. 因此, ARC 会在引用的实例被销毁后自动将其赋值为 nil. 并且因为弱引用可以允许它们的值在运行时被赋值为 nil, 所以它们会被定义为可选类型变量,而不是常量.
 
 可以像其他可选值一样,检查弱引用的值是否存在,将永远不会访问已销毁的实例的引用.
 
 注意: ???? 当 ARC 设置弱引用为 nil时, 属性观察不会被触发.
 */

class Apart {
    let unit: String
    weak var tenant: Peo?

    init(unit: String) {
        self.unit = unit
    }
    
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class Peo {
    let name: String
    var apart: Apart?

    init(name: String) {
        self.name = name
    }
    
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var jo: Peo?
var unitB: Apart?

jo = Peo(name: "Jo")
unitB = Apart(unit: "B")

jo?.apart = unitB
unitB?.tenant = jo

jo = nil
unitB = nil
/*
 注意:  ????
    在使用垃圾收集的系统里,若指针有时用来实现简单的缓冲机制,因为没有强引用的对象只会在内存压力触发垃圾收集时才会被销毁. 但是在 ARC 中,一旦值的最后一个强引用被移除,就会被立即销毁,这导致弱引用并不适合上面的用途
 */



/////     无主引用
/*
 和弱引用类似,无主引用不会牢牢保持引用实例. 和弱引用不同的是,无主引用在其他实例有相同或者更长的生命周期时使用. 可以在生命属性或者变量时, 在前面加上关键字 unowned 表示一个无主引用
 
 无主引用通常都被期望拥有值. 不过 ARC 无法在实例被销毁后将无主引用设置为 nil, 因为非可选类型的变量不允许被赋值为 nil
 
 重要 ?????!!!!!!
       使用无主引用,必须保证引用始终指向一个未销毁的实例
       如果试图在实例被销毁后,访问该实例的无主引用,会触发运行时错误
 */

/*
 下面的例子定义了两个类, Customer 和 CreditCard, 模拟了银行客户和客户的信用卡. 这两个类中, 每一个都将另一个类的实例作为自身的属性. 这种关系可能会造成循环引用.
 
 Customer 和 CreditCard 之间的关系与前面例子中的关系略微不同. 在这个数据模型中,一个客户可能有或者没有信用卡,但是一张信用卡总是关联着一个客户. 为了表示这种关系, Customer 类有一个可选型的 card 属性, 但是 CreditCard 类有一个分可选类型的 customer 属性
此外,只能通过一个 number 值和 customer 实例传递给 CreditCard 构造函数的方法来创建 CreditCard 实例. 这样可以确保当创建 CreditCard 实例时总是有一个 cunstomer 实例与之关联
 
 由于信用卡总是关联着一个客户,因此将 customer 属性定义为 无主引用,用以避免循环强引用
 */

class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    // number 属性被定义为 UInt64 类型而不是 Int 类型,以确保 number 属性的存储量在32位和64位系统上都能够容纳16位的卡号
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
    
}

var joh: Customer?
joh = Customer(name: "John Apple")
joh?.card = CreditCard(number: 1234_5678_9012_3456, customer: joh!)

joh = nil
/*
 注意: ????
    上面例子展示了如何使用无主引用. 对于需要禁用运行时的安全检查的情况(例如,出于性能方面的原因), Swift 还提供了不安全的无主引用. 与所有不安全的操作一样,需要负责检查代码以确保安全性. 可以通过 unowned(unsafe) 来声明不安全无主引用. 如果试图在实例被销毁后,访问该实例的不安全无主引用,程序会尝试访问该实例之前所在的内存地址,这是一个不安全的操作.
 */



/////     无主引用以及隐式解析可选属性
/*
 上面弱引用和无主引用的例子涵盖了两种常用的需要打破循环强引用的场景.
 
 Peo 和 Apart 的例子展示了两个属性的值都允许为 nil, 并会潜在的产生循环强引用. 这种场景最适合用 弱引用 来解决.
 
 Customer 和 CreditCard 的例子展示了一个属性允许为 nil, 而另一个属性值不允许为 nil, 这可能会产生循环强引用. 这种场景最适合通过 无主引用 来解决.
 
 然而,存在第三种情况,在这种场景下,两个属性都必须有值,并且初始化完成后永远不会为 nil. 在这种场景中, 需要一个类使用 无主引用, 而另一个类使用隐式解析可选属性.
 这使两个属性在初始化完成后能够直接访问(不需要可选展开), 同时避免了循环引用.
 
 */

/// 下面的例子定义了两个类, Country 和 City, 每个类将另一个类的实例保存为属性. 在这个模型中, 每个国家必须要有首都,每个城市必须属于一个国家. 为了实现这种关系, Country 类拥有一个 capitalCity 属性, City 类有一个 country 属性

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalCity: String) {
        self.name = name;
        self.capitalCity = City(name: capitalCity, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

/*
 为了建立这两个类的依赖关系, City 的构造函数接受一个 Country 实例作为参数, 并且将实例保存到 country 属性
 Country 的构造函数调用了 City 的构造函数. 然而,只有 Country 的实例完全初始化后, Country 的构造函数才能把 self 传给 City 的构造函数. 在两段式构造过程中有具体描述
 为了满足这种需求,需要在类型结尾处加上感叹号(City!)的方式,将 Country 的 capitalCity 属性声明为隐式解析可选类型的属性. 这意味着像其他可选类型一样, capitalCity 属性的默认值为 nil, 但是不需要展开它的值就能访问它. 在隐式解析可选类型中有描述.
 
 由于 capitalCity 默认值为 nil, 一旦 Country 的实例在构造函数中给 name 属性赋值后,整个初始化过程就完成了. 这意味着一旦 name 属性被赋值后, Country 的构造函数就能引用并传递隐式的 self. Country 的构造函数在赋值 capitalCity 时,就能将 self 作为参数传递给 City 的构造函数.
 */

/// 以上的意义在于可以通过一条语句同时创建 Country 和 City 的实例,而不产生循环强引用,并且 capitalCity 的属性能被直接访问,而不需要通过感叹号来展开它的可选值
//  使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求. capitalCity 属性在初始化完成后,能像非可选值一样使用和存取,同时海避免了循环强引用

var country = Country(name: "Canada", capitalCity: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")




/////***   闭包引起的循环强引用
/*
 循环强引用还会发生在将一个闭包赋值给类实例的某个属性,并且这个闭包体中又使用了这个类实例时. 这个闭包体中可能访问了实例的某个属性, 例如 self.someProperty, 或者闭包中调用了实例的某个方法,例如 self.someMethod(). 这两种情况都导致了闭包"捕获" self, 从而产生了循环强引用.
 
 循环强引用的产生,是因为闭包和类相似,都是引用类型. 当把一个闭包赋值给某个属性时,是将这个闭包的引用赋值给了属性.实质上,这跟之前的问题是一样的--两个强引用让彼此一直有效.但是,和两个类实例不同,这次一个是实例,一个是闭包
 
 Swift 提供了一种优雅的方式来解决这个问题,称之为闭包捕获列表(Closure capture list). 同样的,在学习如何用闭包捕获列表打破循环强引用之前,先了解一下这里循环强引用是如何产生的.
 */

/// 下面的例子展示了当一个闭包引用了 self 后是如何产生一个循环强引用的

class HTMLElement {
    let name: String
    let text: String?
    
    // 声明为 lazy 属性,因为只有当元素需要被处理为 HTML 输出的字符串时,才需要使用 asHTML. 也就是说,在默认的闭包中可以使用 self, 因为只有当初始化完成以及 self 确实存在后,才能访问 lazy 属性.
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")

let defaultText = "some default text"

heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML)

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph?.asHTML())
// 上面的 paragraph 变量定义为可选类型的 HTMLElement,因此我们可以赋值 nil 给它来演示循环强引用
/*
 由于 HTMLElement 类产生了类实例和作为 asHTML 默认值的闭包之间的循环强引用.  实例的 asHTML 属性持有闭包的强引用.但是闭包体内使用了 self (引用了 self.name 和 self.text), 因此闭包捕获了 self, 这意味着闭包又反过来持有了 HTMLElement 实例的强引用. 这样两个对象就产生了循环强引用.
 注意:???? 虽然闭包多次使用了 self, 它只捕获了 HTMLElement 实例的一个强引用
          如果设置 paragraph 变量为 nil,打破了它持有的 HTMLElement 实例的强引用, HTMLElement 实例和它的闭包都不会被销毁,也是因为循环强引用. HTMLElement 的析构函数中的消息并没有被打印,证明了 HTMLElement 实例并没有被销毁
 */




/////***   解决闭包引起的循环强引用
/*
 在定义闭包时同时定义捕获列表作为闭包的一部分,通过这种方式可以解决闭包和类实例之间的循环强引用. 捕获列表定义了闭包体内捕获一个或多个引用类型的规则. 跟解决两个类实例间的循环强引用一样,声明每个捕获的引用为弱引用或无主引用,而不是强引用.应当根据代码关系来决定使用弱引用还是无主引用.
 
 注意: ???? Swift有如下要求: 只要在闭包内使用 self的成员,就要用 self.someProperty 或者 self.someMethod() (而不是 someProperty 或 someMethod()).
 */



//////    定义捕获列表
/*
   捕获列表中的每一项都由一对元素组成,一个元素是 weak 或 unowned 关键字, 另一个元素是类实例的引用(例如 self) 或初始化过的实例变量(如 delegate = self.delegate!). 这些项在方括号中用逗号分开.
 如果闭包有参数列表和返回值类型,把捕获列表放在它们前面:
     lazy var someClosure: (Int, String) -> String = {
         [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
          // 这里是闭包的函数体
     }
 
 */



/////   弱引用和无主引用
/*
 在闭包和捕获的实例总是相互引用总是同时销毁是,将闭包内的捕获列表定义为 无主引用
 
 相反的,在被捕获的引用可能会变为 nil时,将闭包内的不会定义为 弱引用.弱引用总是可选类型,并且当引用的实例被销毁后,弱引用的值会自动设置为 nil. 这样使得可以再闭包体内检查它们是否存在.
 注意: ???? 如果被捕获的引用绝对不会为 nil, 应该用无主引用,而不是弱引用.
 
 */

class HTMLE {
    let name: String
    let text: String?
    
    // [unowned self] 表示 self 捕获为无主引用而不是强引用
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}

var parag: HTMLE? = HTMLE(name: "p", text: "hello, world")
print(parag?.asHTML())

parag = nil























