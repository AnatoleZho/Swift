//: Playground - noun: a place where people can play

import UIKit


/////***         可选链调用           ***/////
/*
  * 使用可选链式调用代替强制展开
  * 为可选链式调用定义模型类
  * 通过可选链式调用访问属性
  * 通过可选链式调用调用方法
  * 通过可选链式调用访问下标
  * 连续多层可选链式调用
  * 在方法的可选返回值上进行可选链式调用
 */

/*
 可选链式调用 是一种可以在当前值可能为 nil 的可选值上请求和调用属性,方法及下标的方法. 如果可选值有值,那么调用就会成功; 如果可选值为 nil,那么调用将会返回 nil.多个调用可以连接在一起形成一个调用链,如果其中任何一个环节为 nil,整个调用链就会失败,即返回 nil
 
 注意: ???? Swift 的可选链式调用和 Objective-C 中向 nil 发送消息有些相像,但是 swift 的可选链式调用可以引用于任何类型,并能检验调用是否成功
 */


//////********      使用可选链式调用替代强制展开
/*
 通过在想调用的属性,方法,或下标的可选值后面放一个问号(?), 可以定义一个可选链. 这一点很像在可选值后面放一个感叹号(!)来强制展开它的值. 它们的主要区别在于当可选值为空时可选链式调用只会调用失败,而强制展开将会触发运行时错误.
 
 为了反映可选链式调用可以在空值(nil)上调用的事实,不论这个调用的属性,方法及下标返回的值是不是可选值,它返回的结果都是一个可选值. 可以利用这个返回值来判断可选链式调用是否调用成功, 如果调用有返回值,则说明调用成功, 返回为 nil 则说明调用失败
 特别地, 可选链式调用的返回值结果和原本的返回值结果具有相同的类型,但是被包装成了一个可选值. 例如,使用可选来哦是调用访问属性, 当可选链式调用成功时,如果属性原来的返回结果是 Int 类型,则会变为 Int? 类型
 */

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

// 创建一个 Person 实例
let john = Person()
// 如果使用感叹号(!)强制展开获得这个 john 的 residence 属性中的 numberOfRooms 值,会触发运行时错误,因为这时 residence 没有可以展开的值:

//  此时会出现程序崩溃
//let roomCount = john.residence!.numberOfRooms


// 可选链式调用提供了另一种访问 numberOfRooms 的方法,使用问号(?)代理原来的感叹号(!):
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
/*
 注:
   在 residence 后面添加问号之后,Swift 就会在 residence 不为 nil 的情况下访问 numberOfRooms.
   因为访问 numberOfRooms 有可能失败,可选链式调用会返回 Int? 类型. 如上所示,当 residence 为 nil 时,可选的 Int 将会为 nil, 表明无法访问 numberOfRooms. 访问成功时, 可选的 Int 值会通过可选绑定 展开,并赋值给非可选类型的 roomCount 常量.
 */

// 可以将 Residence 的实例赋值给 john.residence
john.residence = Residence()



//////********      为可选链式调用定义模型类
/*
 通过使用可选链式调用可以调用多层属性,方法和下标. 这样可以在复杂的模型中向下访问各种子属性,并且判断能否访问紫属性的属性,方法或下标.
 */

class People {
    var residence: Resid?
}

class Resid {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("THe number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
    
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
    
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber!) \(street!)"
        } else {
            return nil
        }
    }
}



//////********      通过可选链式调用访问属性
// 可以通过可选链式调用在一个可选值上访问它的属性, 并判断访问是否成功
let jo = People()

if let roomC = jo.residence?.numberOfRooms {
    print("Jo's residence has \(roomC) rooms")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acadia Road"
// 通过 jo.residence 来设置 address 属性也会失败, 因为 jo.residence 当前为 nil

jo.residence?.address = someAddress

/*
 上面的代码中的赋值过程是可选链式调用的一部分,这意味着可选链式调用失败时,等号右侧的代码不会被执行.对于上面的代码来说,很难验证这一点,因为像这样赋值一个常量没有任何不作用. 下面的代码完成同样的事情,但是它使用一个函数来创建 Address 实例,然后将该实例返回用于赋值. 该函数会在返回前输出 "Function was called", 这使得能验证等号右侧的代码是否被执行
 */

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acadia Road"
    
    return someAddress
}

jo.residence?.address = createAddress()




//////********      通过可选链式调用调用方法
/*
 可以通过可选链式调用来调用方法,并判断是否调用成功,即使这个方法没有返回值.
     func printNumberOfRooms() {
         print("The number of rooms is \(numberOfRooms)")
     }

 这个方法没有返回值. 然而,没有返回值的方法具有饮食的返回值类型 Void, 如无返回值函数中所述.这意味着没有返回值的方法也会返回(), 或者说是空的元组
 
 如果在可选值上通过可选链式调用来调用这个方法,该方法的返回类型会是 Void? 而不是 Void, 因为通过可选链式调用得到的返回值都是可选的.这样就可以使用 if 语句来判断能否成功调用  printNumberOfRooms() 方法,即使方法本身没有定义返回值. 通过判断返回值是否为 nil 可以判断调用是否成功:
 */

if jo.residence?.printNumberOfRooms() != nil {
    print("It wes possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

// 同样的,可以据此判断通过可选链式调用为属性赋值是否成功. 通过可选链式调用给属性赋值会返回 Void?, 通过判断返回值是否为 nil 就可以知道赋值是否成功:

if (jo.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}



//////********      通过可选链式调用访问下标
/*
   通过链式调用,可以在一个可选值上访问下标,并判断下表调用是否成功
 
 注意:???? 通过可选链式调用访问可选值的下标时,可以通过问号放在下标方括号前面而不是后面.
          可选链式调用的问号一般直接跟在可选表达式的后面.
 */
// 下面例子用访问 jo.residence 属性存储的 Residence 实例的 rooms 数组中的第一个房间名称,因为 jo.residence 为 nil,所以下表调用失败了

if let firstRoomName = jo.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first name.")
}

// 类似的,可以通过下标,用可选链调用赋值:
jo.residence?[0] =  Room(name: "Bathroom")

// 如果创建一个 Resid 实例,并为其 rooms 数组添加一下 Room 实例, 然后将 Residence 实例赋值给 jo.residence, 那就可以通过可选链和下标来访问数组中的元素

let johnHouse = Resid()
johnHouse.rooms.append(Room(name: "Living Room"))
johnHouse.rooms.append(Room(name: "Kitchen"))
jo.residence = johnHouse

if let firstRoomName = jo.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}




//////********     访问可选类型的下标
// 如果下标返回可选类型值,比如 Swift 中 Dictionary类型的键的下标,可以在下标结尾括号后面放一个问号来在其可选值上进行可选链式调用:
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
print(testScores)




//////********     连接多层可选链式调用
/*
 可以通过连接多个可选链式调用在更深的模型层级中访问属性,方法,下标. 然而多层可选链式调用不会增加返回值的可选层级
 
 也就是说:
       * 如果访问的值是不可选的,可选链式调用将会返回可选值.
       * 如果访问的值是可选的,可选链式调用不会让可选返回值变得"更可选"
 因此:
      * 通过可选链式调用访问一个 Int 值, 将会返回 Int? 无论使用了多少层可选链式调用.
      * 类似的,通过可选链式调用访问 Int? 值, 依旧会返回 Int? 值,并不会返回 Int??
 */

// 下面例子城市访问 jo 中的 residence 属性中的 address 属性中的 street 属性. 这里使用了两层可选链式调用, residence 及 address 都是可选值:

// jo.residence?.address?.street的返回值也依然是String?，即使已经使用了两层可选链式调用。
if let josStreet = jo.residence?.address?.street {
    print("Jo's street name is \(josStreet).")
} else {
    print("Unable to retrieve the address.")
}


// 如果为 jo.residence.address 赋值一个 Address 实例,并且为 address 中的 street 属性设置一个有效的值,就能通过可选链式调用来访问属性 street 属性

let josAddress = Address()
josAddress.buildingName = "The Larches"
josAddress.street = "Laurel Street"
jo.residence?.address = josAddress

if let josStreet = jo.residence?.address?.street {
    print("Jo's street name is \(josStreet).")
} else {
    print("Unable to retrieve the address.")
}




//////********     在方法的可选返回值上进行可选链式调用
/*
 上面的例子展示了如何在一个可选值上通过可选链式调用来获取它的属性值. 还可以在一个可选值上通过可选链式调用来调用方法, 并且可以根据需要继续在方法的可选返回值上进行可选链式调用.
 
 在下面的例子中,通过可选链式调用来调用 Address 的 buildingIdentifier() 方法. 这个方法返回 String? 类型的值. 如上所述, 通过可选链式调用来调用该方法,最终的返回值依旧是 String? 类型
 */

if let buildingIdentifier = jo.residence?.address?.buildingIdentifier() {
    print("Jo's building identifier is \(buildingIdentifier)")
}

// 如果要在该方法的返回值上进行可选链式调用,在方法的圆括号后面加上问号(?)即可:

if let beginsWithThe = jo.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("Jo's building identifier begins with \"The\".")
    } else {
        print("Jo's building identifier does not begin with \"The\".")
    }
}


//  注意: ???? 在上面的例子中,在方法的圆括号后面加上问号是因为要在 buildingIdentifier() 方法的可选返回值上进行可选链式调用,而不是方法本身.





























