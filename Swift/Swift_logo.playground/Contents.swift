//: Playground - noun: a place where people can play

import UIKit

//////******       访问控制(Access Control)        *******//////
/*
 * 模块和源文件
 * 访问级别
 * 访问控制语法
 * 自定义类型
 * 子类
 * 常量, 变量, 属性, 下标
 * 构造器
 * 协议
 * Extension
 * 泛型
 * 类型别名
 
 访问控制可以限定其它源文件或模块中的代码对自己代码的访问级别. 这个特性可以隐藏代码的一些实现细节,并且可以为其他人可以访问和使用的代码提供接口.
 
 可以明确地给单个类型(类, 结构体,枚举)设置访问级别,也可以给这些类型的属性,方法,构造器,下标等设置访问级别. 协议也可以被限定在一定的范围内使用, 包括协议里的全局常量,变量和函数.
 
 Swift 不仅提供了多种不同的访问级别,还为某些典型场景提供了默认的访问级别,这样就不需要在每段代码中都申明显式访问级别. 其实,如果只是他开一个单一 target 的引用程序,完全可以不用显式声明代码的访问级别.
 
 注意: ???? 为了简单起见, 对于代码中可以设置访问级别的特性(属性,基本类型,函数等),在下面的章节中会称为"实体".
 */


/////////*********      模块和源文件
/*
 Swift 中的访问控制模型基于模块和源文件这两个概念.
 
 模块指的是独立的代码单元,框架或应用程序会作为一个独立的模块来构建和发布. 在 Swift 中,一个模块可以使用 inport 关键字导入另外一个模块.
 
 在 Swift 中, Xcode 的每个 target (例如框架或应用程序)都被当做独立的模块处理. 如果是为了实现某个通用的功能, 或者为了封装一写常用方法而将代码打包成独立的框架, 这个框架就是 Swift 中的一个模块. 当它被导入某个应用程序或者其他框架时,框架内容都将属于这个独立的模块.
 
 源文件就是 Swift 中的源代码文件, 它通用于一个模块,即一个应用程序或框架.尽管一般会将不同的类型分别定义在不同的源文件中,但是同一个源文件也可以包含多个类型,函数之类的定义.
 
 */




////////********        访问级别
/*
 Swift 为代码中的实体提供了五种不同的访问级别. 这些访问级别不仅与源文件中定义的实体相关,同时也与源文件所属的模块相关.
  * Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问,在模块外也可以通过导入该模块来访问源文件里的实体. 通常情况下,会使用 Open 和 Public 级别来指定框架的外部接口. Open 和 Public 的区别在后面会提到.
 
  * Internal 级别让实体被同一模块源文件中的任何实体访问,但是不能被模块外的实体访问. 通常情况下,如果某个接口只在应用程序或框架内部使用,就可以将其设置为 Internal 级别.
 
  * File-private 限制实体只能在其定义的文件内部访问. 如果功能的部分细节只需要在文件内部使用时,可以使用 File-private 来将其隐藏.
 
  * Private 限制实体只能在其定义的作用域,以及同一文件内的 extension 访问. 如果功能的部分细节只需要在当前作用域使用时,可以使用 Private 来将其隐藏.
 
 Open 为最高访问级别(限制最少), Private 为最低访问级别(限制最多).
 
 Open 只能作用于类和类的成员, 和 Public 的区别如下:
    *  Public 或者其他更严访问级别的类, 只能在其定义的模块内部被继承.
    *  Public 或者其他更严访问级别的类成员, 只能再起定义的模块内部的子类中重写.
    *  Open 的类, 可以在其定义的模块中被继承, 也可以再引用它模块中被继承.
    *  Open 的类成员, 可以在其定义的模块中子类中重写, 也可以再引用它的模块中的子类重写.
 
 把一个类标记为 open, 明确的表示已经充分考虑过外部模块使用此类为父类的影响, 并且设计好了类的代码了.
 */



////////**********            访问级别基本原则
/*
 Swift 中的访问级别遵循一个基本原则: 不可以在某个实体中定义访问级别更低(更严格)的实体.

 例如:
   * 一个 Public 的变量,其类型的访问级别不能是 Internal, File-private 或者 Private. 因为无法保证变量的类型在使用变量的地方也具有访问权限.
   * 函数的访问级别不能高于它的参数类型和返回类型的访问级别. 因为这样就会出现函数可以在任何地方被访问, 但是它的参数类型和返回值类型却不可以情况.
关于此原则在各种情况下的具体表现,将在下文有所体现.
 */


////////*********       默认访问级别
/*
 如果没有为代码中的实体显示之定义访问级别, 那么它们默认为 internal 级别 (有一些例外情况,稍后会进行说明). 因此, 在大多数情况下, 不需要显示指定实体的访问级别.
 */


////////*********       单个 target 应用程序的访问级别
/*
 当编写一个单目标引用程序时, 应用的所有功能都是为该应用服务, 而不需要提供给其他应用或者模块使用, 所以不要明确设置访问级别, 使用默认的访问级别 Internal 即可. 但是,也可以使用 fileprivate 访问或 private 访问级别, 用于隐藏一些功能的实现细节.
 */



////////********        框架的访问级别
/*
 当开发框架时, 就需要把一些对外的接口定义为 Open 或 Public, 以便使用者导入该框架后可以正常使用其功能. 这些被定义为对外的接口, 就是这个框架的 API.
 
 注意: ???? 框架依然会使用默认的 internal, 也可以指定 fileprivate 访问或者 private 访问级别. 当想把某个实例作为框架的 API 的时候, 需显式为其指定开放访问或公开访问级别.
 */



///////*******           单元测试 target 的访问级别
/*
 当应用程序包含单元测试 target 时,为了测试, 测试模块需要访问应用程序模块中的代码. 默认情况下只有 open 或 public 级别的实体才可以被其他模块访问. 然而, 如果在导入应用程序模块的语法前使用 @testable 特性, 然后允许测试的编译设置 (Build -> Enable Testability) 下编译这个应用程序模块, 单元测试目标就可以访问应用程序模块中所有内部级别的实体.
 */




///////*******           访问控制语法
// 通过修饰符 open, public, internal, fileprivate, private 来表明实体的访问级别:


fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

// 除非专门指定, 否则实体默认的访问级别为 internal. 这意味着在不使用修饰符显式声明访问级别的情况下, SomeInternalClass 和 someInternalConstant 仍然拥有隐式的 internal:

var someInternalConstant = 0 // 隐式 internal



////////********        自定义类型
/*
 如果想为一个自定义类型指定访问级别, 在定义类型时进行指定即可. 新类型只能在它的访问级别限定范围内使用. 例如,定义了一个 fileprivate 级别的类, 那这个类就只能在定义它的源文件中使用, 可以作为属性类型, 函数参数类型或者返回类型, 等等.
 
 一个类型的访问级别也会影响到类型成员(属性, 方法, 构造器, 下标) 的默认访问级别. 如果极爱你该类型指定为 private 或者 fileprivate 级别, 那么该类型的所有成员的默认访问级别也会成为 private 或者 fileprivate 级别. 如果将类型指定为 公开或者 internal (或者不明确指定访问级别, 而使用默认的 internal), 那么该类型的所有成员的默认访问级别将是内部访问.
 
 重要:  !!!!!  上面提到, 一个 public 类型的所有成员的访问级别默认为 internal 级别, 而不是 public 级别. 如果想将某个成员指定为 public 级别, 那么必须显式指定. 这样做的好处是, 在定义公共接口的时候,可以明确地选择哪些接口是需要公开的, 哪些是内部使用的, 避免不小心将内部使用的接口公开.
 */

public class SomePublicClass {          // 显式 public 类
    public var somePublicProperty = 0   // 显式 public 类成员
    var someInternalProperty = 0        // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {} // 显式 fileprivate 类成员
    private func somePrivateMethod() {}  // 显式 private 类成员
}

class SomeInternalClass {                // 隐式 internal 类
    var someInternalProperty = 0         // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivatedMethod() {}  // 显式 private 类成员
}

fileprivate class SomeFilePrivateClass {  // 显式 fileprivate 类
    func someFilePrivateMethod() { }      // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}   // 显式 private 类成员
}

private class SomePrivateClass {          // 显式 private 类
    
}



/////////**********            元组类型
/*
 元组的访问级别将由元组中访问级别更严格的类型来决定. 例如, 如果构建了一个包含两种不同类型的元组, 其中一个类型为 internal, 另一个类型为 private, 那么这个元组的访问级别为 private.
 
 注意: ???? 元组不同于类,结构体,枚举,函数那样有单独的定义. 元组的访问级别是在它被使用时自动推断出的,而无法明确指定.
 */



////////**********            函数类型
/*
 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定. 但是,如果这种访问级别不符合函数定义所在环境的默认访问级别, 那么就需要明确地指定该函数的访问级别.
 
 // 下面的例子定义了一个名为 someFunction() 的全局函数, 并且没有明确地知道你个其访问级别. 也许会认为该函数应该拥有默认的访问级别 internal, 但事实并非如此. 事实上,如果按下面这种写法,代码将无法通过编译:
 
 func someFunction() -> (SomeInternalClass, SomePrivateClass) {
     // 此处是函数实现部分.
 }
 
 可以看到,这个函数的返回类型是一个元组, 该元组包含两个自定义的类. 其中一个类的访问级别是 internal, 另外一个的访问级别是 private, 所以根据元组访问级别的原则, 该元组的访问级别是 private (元组的访问级别与元组中访问级别最低的类型一致).
 
 因为该函数返回类型的访问级别是 private, 所以必须使用 private 修饰符, 明确指明该函数的访问级别:
 
 private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
     // 此处为函数实现部分
 }
 
 将该函数指定为 public 或 internal, 或者使用默认的访问级别 internal 都是错误的, 因为如果把该函数当做 public 或 internal 级别来使用的话, 可能会不发访问 private 级别的返回值.
 */



////////*********            枚举类型
/*
 枚举成员的访问级别和该枚举类型相同, 不能为枚举成员单独制定不同的访问级别.
 
 下面的例子, 枚举 ConpassPoint 被明确指定为 public, 那么它的成员 north, south, east, west 的访问级别同样也是 public:
*/

public enum CompassPoint {
    case north, south, east, west
}

/////*****    原始值和关联值
/*
 枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别. 例如不能在一个 internal 枚举中定义 private 的原始值类型.
 */




/////////*********              嵌套类型
/*
 如果再 private 的类型中定义嵌套类型, 那么该嵌套了新鲜感就自动拥有 private 访问级别. 如果再 public 或者 internal 级别的类型重定义嵌套类型, 那么该嵌套类型自动拥有 internal 访问级别. 如果想让嵌套类型拥有 public 访问级别, 那么需要明确指明该嵌套类型的访问级别.
 */



////////*********                  子类
/*
 子类的访问级别不能高于父类的访问级别. 例如, 父类的访问级别是 internal, 子类的访问级别就不能是 public.
 
 此外,可以在符合当前访问级别的条件下重写任意类成员(方法, 属性, 构造器, 下标).
 
 可以通过重写为继承来的类成员提供更高的访问级别. 下面的例子中, 类 A 的访问级别是 public, 它包含一个方法 someMethod(), 访问级别为 fileprivate. 类 B 继承自类 A, 访问级别是 internal, 但是在类 B 中重写类 A 中访问级别为 fileprivate 的方法 someMethod(), 并重新指定为 internal 级别. 通过这种方式, 可以将某类中 fileprivate 级别的类成员重新指定为更高的刚问级别, 以便其他人使用:
 */

public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        
    }
}

// 甚至可以在子类中, 用子类成员去访问访问级别更低的父类成员, 只要这一操作在相应访问的限制范围内(也就是说, 在 同一源文件中访问父类 private 级别的成员, 在同一模块内访问父类 internal 级别的成员):
internal class C: A {
    override internal func someMethod() {
        super.someMethod()
    }
}
// 因为父类 A 和 子类 C 定义在同一个源文件中, 所以子类 B 可以在重写 someMethod() 方法中调用 super.someMethod().



/////////*********         常量, 变量, 属性, 下标
/*
 常量,变量,属性不能拥有比它们更高的访问级别. 例如, 不能定义一个 public 级别的属性, 但是它的类型确实 private 级别的. 同样, 下标也不能拥有比索引类型或返回类型更高的访问级别.
 
 如果常量, 变量,属性,下标的类型是 private 级别的,那么它们必须明确制定访问级别为 private:
 
 private var privateInstance = SomePrivateClass()
 */



////////**********          Getter 和 Setter
/*
 常量,变量,属性,下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同.
 
 Setter 的访问级别可以低于对应的 Getter 的访问级别, 这样既可以控制变量, 属性, 或下标的读写权限. 在 var 或 subscript 关键字之前, 可以通过 fileprivate(set), private(set) 或 internal(set) 为它们的写入权限指定更低的访问级别.
 
 注意: ???? 这个规则同时适用于存储型属性和计算型属性. 即使不明确指定存储属性 Getter 和 Setter, Swift 也会隐式地为其创建 Getter 和 Setter, 用于访问该属性的后备存储. 使用 fileprivate(set), private(set) 和 internal(set) 可以改变 Setter 的访问级别, 这对计算型属性也同样适用.
 */

// 下面的例子中定义了一个名为 TrackedString 的结构体, 它记录了 value 属性被修改的次数:

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
/*
 TrackedString 结构体定义了一个用于存储 String 值的属性 value, 并将初始值设置为 ""(一个空字符串). 该结构体定义了另一个用于存储 Int 值的属性 numberOfEdits, 它用于记录属性 value 被修改的次数. 这个功能通过属性 value 的 didSet 观察器实现,每当给 value 赋新值时就会调用 didSet 方法, 然后将 numberOfEdits 的值加一.
 
 结构体 TrackedString 和它的属性 value 都没有显式地指定访问级别, 所以它们都是用默认的访问级别 internal. 但是该结构体的 numberOfEdits 属性使用了 private(set) 修饰符, 这意味着 numberOfEdits 属性只能在结构体的定义中进行赋值. numberOfEdits 属性的 Getter 依然是默认的访问级别 internal, 但是 Setter 的访问级别是 private, 这表示该属性只能在内部修饰, 而在结构体外部则表现为只读属性.
 */

// 如果实例化 TrackedString 结构体, 并多次对 value 属性的值进行修改, 就会看到 numberOfEdits 的值会随着修改次数而变化:

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

//虽然可以在其他的源文件中实例化该结构体并且取到 numberOfEdits 属性的值, 但是不能对其进行赋值. 这一限制保护了该记录功能的实现细节,同事提供了方便的访问方法.

/*
 可以在必要时为 Getter 和 Setter 显式指定访问级别. 下面的例子中将 TrackStrings 结构体明确指定为了 public 访问级别. 结构体的成员(包括 numberOfEdits 属性)拥有默认的访问级别 internal. 可以结合 public 和 private(set) 修饰符把结构体中的 numberOfEdits 属性的 Getter 的访问级别设置为 public, 而 Setter 的访问级别设置为 private:
 */

public struct TrackedStrings {
    public private(set) var numberOfEdiits = 0
    public var value: String = "" {
        didSet {
            numberOfEdiits += 1
        }
    }
    
    public init() {}
}




//////////**********              构造器
/*
 自定义构造器的访问级别可以低于或等于其所属类型的访问级别. 唯一的例外是必要构造器, 它的访问级别必须和所属类型的访问级别相同.
 
 如同函数或方法的参数, 构造器参数的访问级别也不能低于构造器本身的访问级别.
 */



/////*****            默认构造器
/*
 如默认构造器所述, Swift 会为结构体和类提供一个默认的无参数的构造器, 只要它们为所有的存储属性设置了默认初始值, 并且未提供自定义的构造器.
 
 默认构造器的访问级别与所属类型的访问级别相同, 除非类型的访问级别是 public. 如果一个类型被指定为 public 级别, 那么默认构造器的刚问级将为 internal. 如果希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器, 只能自己提供一个 public 访问级别的无参数构造器.
 */


/////*****        构造器模拟的成员逐一构造器
/*
 如果结构体中任意存储属性的访问级别为 private, 那么该结构体的成员逐一构造器的访问级别就是 private. 否则,这种构造器的访问级别依然是 internal.
 
 如同前面提到的默认构造器, 如果希望一个 public 级别的结构体也能在其他模块中使用默认的成员逐一构造器, 依然只能自己提供一个 public 访问级别的成员逐一构造器.
 */


//////////**********            协议
/*
 如果想为一个协议类型明确地指定访问级别, 在定义协议时指定即可. 这将限制该协议只能在适当的访问级别范围内被采纳.
 
 协议中的每一个要求都具有和该协议相同的访问级别. 不能将协议的要求设置为其他访问级别. 这样才能保证该协议的所有要求对于任何采纳者都将可用.
 
 注意: ???? 如果定义了一个 public 访问级别的协议, 那么该协议的所有实现也会是 public 访问级别. 这一点不同于其他类型, 例如, 当类型是 public 访问级别时, 其成员的访问却只是 internal.
 */


/////*****        协议继承
/*
 如果定义了一个继承自其他协议的新协议, 那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同. 例如, 不能将继承自 internal 协议的协议定义为 public 协议.
 */


/////*****        协议一致性
/*
 一个类型可以采纳比自身访问级别低的协议. 例如, 可以定义一个 public 级别的类型, 它可以在其他模块中使用, 同时它也可以采纳一个 internal 级别的协议, 但是只能在该协议所在的模块中作为符合该协议的类型使用.
 
 采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别. 也就是说, 如果一个类型是 public 级别, 采纳的协议是 internal 级别, 那么采纳了这个协议后, 该类型作为符合协议的类型时, 其访问级别也是 internal.
 
 如果采纳了协议, 那么实现了协议的所有要求后, 必须保证这些实现的访问级别不能低于协议的访问级别. 例如, 一个 public 级别的类型, 采纳了 internal 级别的协议, 那么协议的实现至少也得是 internal 级别.
 
 注意: ???? Swift 和 Objective-C 一样, 协议的一致性是全局的, 也就是说, 在同一程序中, 一个类型不可能用两种不同的方式实现同一个协议.
 */





//////////**********              Extension
/*
 Extension 可以在访问级别允许的情况下对类, 结构体, 枚举进行扩展. Extension 的成员具有和原始类型成员一致的访问级别. 例如, 使用 Extension 扩展了一个 public 或者 internal 类型, Extension 中的成员就默认使用 internal 访问级别, 和原始类型中的成员一致. 如果使用 Extension 扩展了一个 private 类型, 则 Extension 的成员默认使用 private 访问级别.
 
 或者, 可以明确制定 Extension 的访问级别 (例如, private extension), 从而给该 extension 中的所有成员指定一个新的默认访问级别. 这个新的默认访问级别仍然可以被单独指定的访问级别覆盖.
 
 如果使用 extension 来遵循协议的话, 就不能显示的声明 extension 的访问级别. extension 每个 protocol 要求的实现都默认使用 protocol 的访问级别.
 */


/////*****        Extension 的私有成员
/*
 扩展同一个文件内的类, 结构体或者枚举, extension 里面的代码会表现得跟声明在原类型里的一模一样. 也就是说:
   * 在类型的声明里面声明的私有成员, 在同一文件的 extension 里访问.
   * 在 extension 里面声明一个私用成员, 在同一个文件的另一个 extension 里访问.
   * 在 extension 里面声明一个私有成员, 在同一文件的类型声明里访问.
 
 这意味着可以像组织的代码去使用 extension, 而且不受私有成员的影响. 例如, 给定下面这样一个简单的协议:
 */

protocol SomeProtocol {
    func doSomething()
}

// 可以使用 extension 来遵循协议:

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}




//////////**********              泛型
/*
 泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别, 还需结合类型参数的类型约束的访问级别, 根据这些访问级别中的最低当问级别来确定.
 */




//////////**********              类型别名
/*
 定义的任何类型别名都会被当做不同的类型, 以便于进行访问控制. 类型别名的访问级别不可高于其表示的类型的访问级别. 例如, private 级别的类型别名可以作为 private, file-private, internal, public 或 open 类型的别名, 但是 public 级别的类型别名只能作为 public 类型的别名, 不能作为 internal, file-private, 或 private 类型的别名
 
 注意: ????  这条规则也适用于为满足协议一致性而将类型别名用于关联类型的情况.
 */





















