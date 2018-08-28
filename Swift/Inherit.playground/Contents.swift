//: Playground - noun: a place where people can play

import UIKit

///***        继承        ***///
/*
 一个类可以继承另一个类的方法,属性和其他的特性. 当一个类继承其他类时, 继承类叫 子类, 被继承类叫 超类(或父类). 在 Swift 继承是区分  [类] 与其他类型的一个基本特征
 
 在 Swift 中, 类可以调用和访问超类的方法,属性和下标,并且可以重写这些方法,属性和下标来优化或修改它们的行为. Swift 会检查重写定义在超类中是否有匹配的定义,以此来保证重写行为是正确的.
 
 可以为类中继承的属性添加属性观察器, 这样一来当属性改变时,类就会被通知到.可以为任何属性添加属性观察器,无论他原来被定义为存储属性还是计算属性.
 */



// 定义一个基类

/*
 不继承与其他类的类称之为基类
 
 注意: Swift 中的类并不是从一个通用的基类继承而来.如果不为定义的类指定超类的话,这个类就自动的成为基类
 */

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // 什么也不做- 因为车辆不一定会有噪音
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")


/// 子类生成
/*
 子类生成指的是在一个已有类的基础上创建一个新的类. 子类继承超类的特性, 并且可以进一步完善.还可以为子类添加新的特性
 */
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

//* 子类还可以被其他的类继承 *//
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0

print("Tandem: \(tandem.description)")



/// 重写
/*
 子类可以围城来的实例方法,类方法,实例属性.或下标提供自己定制的实现. 把这种行为叫重写
 
 如果重写某个特性,需要在重写定义的前面加上 override 关键字. 这么做表明了想提供一个重写的版本,而非错误的提供了一个相同的定义. 意外的重写行为可能会导致不可预知的错误,任何缺少 override 关键字重写都会在编译时被判断为错误
 
 override 关键字会提醒 Swift 编译器去检验该类的超类(或其中一个父类)是否匹配重写版本的说明, 这个检验可以确保重写定义是正确的
 */


/// 访问超类的方法,属性及下标
/*
 在子类中重写超类的方法,属性或下标时,有时在重写版本中使用已经存在的超类实现会大有裨益. 比如,可以完成已有实现的行为,或是在一个继承来的变量中存出一个修改过的值.
 
 在合适的地方,可以通过使用 supper 前缀来访问超类版本的方法,属性或下标:
    1.在方法 someMethod() 的重写实现中,可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法
    2.在属性 someProperty 的 getter 或 setter 的重写实现中, 可以通过 super.someProperty 来访问超类版本的 someProperty 属性
    3.在下标的重写实现中,可以通过 super[someIndex] 来访问超类版本中的相同下标
 */


/// 重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()


/// 重写属性
/*
 可以重写继承来的实例属性或类型属性,提供定制的 setter 和 getter , 或添加属性观察器使重写的属性可以观察属性值什么时候发生变化
 */

//. 重写属性 Getter 和 Setter
/*
 可以提供定制的 getter (或 setter) 来重写任意继承来的属性, 无论继承来的属性是存储属性还是计算属性. 子类并不知道继承来的属性是存储型的还是计算型的, 它只知道继承来的属性会有一个名字和类型. 在重写一个属性时, 必需将名字和类型都写出来, 这样才能使编译器去检查重写的属性是与超类中同名同类型的属性相匹配的.
 
 可以将一个继承来的只读属性重写为一个读写属性, 只需要在重写版本的属性里提供 getter 和 setter 即可, 但是,不可以将继承来的读写属性重写为一个只读属性
 
 注意: 如果再重写属性中提供了 setter, 那么也一定要提供 getter. 如果不想在重写版本中的 getter 里修改继承来的属性值, 可以直接通过 super.someProperty 来返回继承来的值, 其中 someProperty 是你要重写的属性的名字.
 */

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
    
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")


//. 重写属性观察器
/*
  可以通过重写属性为一个继承来的属性添加属性观察器, 这样一来, 当继承来的属性发成变化是, 就会被通知到, 无论这个属性原来是如何实现的.
 
 注意: 不可以为继承的 常量存储型属性 或 继承来的 只读计算型属性添加属性观察器. 这些属性的值是不可以被设置的. 所以, 为它们提供 willSet 或 disSet 实现是不恰当的
      不可以同时提供重写的 setter 或 重写的属性观察器. 如果想要观察属性值的变化,并且已经为属性提供了定制的 setter, 那么在 setter 中就可以观察到任何值变化了
 */

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automaticCar = AutomaticCar()
automaticCar.currentSpeed = 35.0
print("AutoMaticCar: \(automaticCar.description)")



/// 防止重写
/*
  可以通过把方法,属性或下标标记为 final 来防止它们被重写. 只需要在生命关键字前 加上 final 修饰符即可
 (例如: final var, final func final class func, final subscript)
 
 如果重写了带有 final 标记的方法, 属性或下标, 在编译时会报错. 在类扩展中的方法,属性或下标可以在扩展的定义里标记为 final
 
 可以同时在关键字 class 前添加 final 修饰符 (final class) 来将整个类标记为 final, 这样的类是不可被继承的, 试图继承这样的类会导致编译报错
 */













































