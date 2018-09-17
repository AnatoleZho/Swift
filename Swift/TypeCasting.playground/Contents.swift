//: Playground - noun: a place where people can play

import UIKit
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\类型转换（Type Casting）
/*
 • 定义一个类层次作为例子
 • 检查类型
 • 向下转型(Downcasting)
 • Any 和 AnyObject 的类型转换
 
 类型转换 可以判断实例的类型,也可以将实例看做是其父类或者子类的实例。
 类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型 或者转换它的类型。
 你也可以用它来检查一个类是否实现了某个协议,就像在 检验协议的一致性 (页 0)部分讲述的一样。
 */


//\\\\\\\\\\\\\\\\\定义一个类层次作为例子
/*
 你可以将类型转换用在类和子类的层次结构上,检查特定类实例的类型并且转换这个类实例的类型成为这个层次
 结构中的其他类型。下面的三个代码段定义了一个类层次和一个包含了几个这些类实例的数组,作为类型转换的例子。
 
 第一个代码片段定义了一个新的基础类 MediaItem 。这个类为任何出现在数字媒体库的媒体项提供基础功能。特 别的,它声明了一个 String 类型的 name 属性,和一个 init name 初始化器。(假定所有的媒体项都有个 名称。)
 */
class MediaItem {
    var name: String
    init(name: String) {
    self.name = name
    }
}

//下一个代码段定义了 MediaItem 的两个子类。第一个子类 Movie 封装了与电影相关的额外信息,在父类(或 者说基类)的基础上增加了一个 director (导演)属性,和相应的初始化器。第二个子类 Song ,在父类的基 础上增加了一个 artist (艺术家)属性,和相应的初始化器:

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

//最后一个代码段创建了一个数组常量 library,包含两个 Movie 实例和三个 Song 实例。library 的类型 是在它被初始化时根据它数组中所包含的内容推断来的。Swift的类型检测器能够推理出 Movie 和 Song 有共 同的父类 MediaItem ,所以它推断出 [MediaItem] 类作为 library 的类型

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是,若你迭代它,依次取出的实例会是 MediaItem 类型的,而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作,你需要检查它们的类型或者向下转换它们到其它类型,就像下面描述的一样。

//检测类型（Checking Type）
/*
 用类型检查操作符( is )来检查一个实例是否属于特定子类型。若实例属于那个子类型,类型检查操作符返回 true ,否则返回 false 。
 */

//下面的例子定义了两个变量,movieCount 和 songCount,用来计算数组 library 中 Movie 和 Song 类型 的实例数量。

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
       movieCount += 1
    } else if item is Song {
       songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//\\\\\\\\\\\\\\向下转型（Downcasting）
/*
 某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时,你可以尝试向下转到它的子类
 型,用类型转换操作符(as? 或 as!)
 因为向下转型可能会失败,类型转型操作符带有两种不同形式。条件形式(conditional form) as? 返回一个 你试图向下转成的类型的可选值(optional value)。强制形式 as! 把试图向下转型和强制解包(force-unwra ps)结果作为一个混合动作。
 当你不确定向下转型可以成功时,用类型转换的条件形式( as? )。条件形式的类型转换总是返回一个可选值(opt ional value),并且若下转是不可能的,可选值将是 nil 。这使你能够检查向下转型是否成功。
 只有你可以确定向下转型一定会成功时,才使用强制形式( as! )。当你试图向下转型为一个不正确的类型时,强 制形式的类型转换会触发一个运行时错误。
 下面的例子,迭代了 library 里的每一个 MediaItem,并打印出适当的描述。要这样做,item 需要真正作为 Movie 或 Song 的类型来使用,不仅仅是作为 MediaItem 。为了能够在描述中使用 Movie 或 Song 的
 rector 或 artist 属性,这是必要的。
 */

//在这个示例中,数组中的每一个 item 可能是 Movie 或 Song 。事前你不知道每个 item 的真实类型,所以 这里使用条件形式的类型转换( as? )去检查循环里的每次下转。

for item in library {
    if let movie = item as? Movie {
       print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
       print("Song: \(song.name), by \(song.artist)")
    }
}

//\\\\\\\\\\\\\\\\\\\\\\\\Any 和 AnyObject 的类型转换
/*
 Swift为不确定类型提供了两种特殊类型别名:
 • 可以代表任何class类型的实例。
 • 可以表示任何类型,包括方法类型(function types)。
 注意:
 只有当你明确的需要它的行为和功能时才使用 和   。在你的代码里使用你期望的明确的类型总是 更好的。
 */

//\\\\\\\\\\\\\AnyObject 类型
/*
 当在工作中使用 Cocoa APIs,我们一般会接收一个   类型的数组,或者说“一个任何对象类型的数 组”。这是因为 Objective-C 没有明确的类型化数组。但是,你常常可以从 API 提供的信息中清晰地确定数组 中对象的类型。
 在这些情况下,你可以使用强制形式的类型转换( )来下转在数组中的每一项到比   更明确的类 型,不需要可选解析(optional unwrapping)。
 */

//下面的示例定义了一个  [AnyObject] 类型的数组并填入三个   类型的实例:

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

//因为知道这个数组只包含 Movie 实例,你可以直接用(as!)下转并解包到不可选的Movie类型:

for object in someObjects {
    let movie = object as! Movie
    print("Movie: \(movie.name), dir. \(movie.director)")
}

//为了变为一个更短的形式,下转 someObjects 数组为 [Movie] 类型来代替下转数组中每一项的方式。

for movie in someObjects as! [Movie] {
  print("Movie: \(movie.name), dir. \(movie.director)")
}

//\\\\\\\\\\\\\\Any 类型

//这里有个示例,使用 Any 类型来和混合的不同类型一起工作,包括方法类型和非 class 类型。它创建了一个 可以存储 Any 类型的数组 things 。

var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

/*
 things 数组包含两个 Int 值,2个 Double 值,1个 String 值,一个元组 (Double, Double) ,电影“Gh ostbusters”,和一个获取 String 值并返回另一个 String 值的闭包表达式。
 
 你可以在 switch 表达式的cases中使用 is 和 as 操作符来发觉只知道是 Any 或 AnyObject 的常量或变 量的类型。下面的示例迭代 things 数组中的每一项的并用switch语句查找每一项的类型。这几种 switch 语 句的情形绑定它们匹配的值到一个规定类型的常量,让它们的值可以被打印:
 */

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as an Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
    
}


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\嵌套类型（Nested Types）
/*
 本页包含内容:
 • 嵌套类型实例
 • 嵌套类型的引用
 枚举类型常被用于实现特定类或结构体的功能。也能够在有多种变量类型的环境中,方便地定义通用类或结构体
 来使用,为了实现这种功能,Swift允许你定义嵌套类型,可以在枚举类型、类和结构体中定义支持嵌套的类型。
 要在一个类型中嵌套另一个类型,将需要嵌套的类型的定义写在被嵌套类型的区域{}内,而且可以根据需要定义 多级嵌套。
 */

//\\\\\\\\\\\\\\\\\\\\\\\嵌套类型实例

//下面这个例子定义了一个结构体 BlackjackCard (二十一点),用来模拟 BlackjackCard 中的扑克牌点数。BlackjackCard 结构体包含2个嵌套定义的枚举类型 Suit 和 Rank 。在 BlackjackCard 规则中, Ace 牌可以表示1或者11, Ace 牌的这一特征用一个嵌套在枚举型 Rank 的结构体 es 来表示。

struct BlackjackCard {
    //嵌套定义枚举类型 Suit
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    //嵌套定义枚举类型（Rank）
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    //BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue)"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }

}
/*
 枚举型的 Suit 用来描述扑克牌的四种花色,并分别用一个 Character 类型的值代表花色符号。
 枚举型的 Rank 用来描述扑克牌从 Ace ~10, J , Q , K ,13张牌,并分别用一个 Int 类型的值表示牌的面值。(这个 Int类型的值不适用于Ace,J,Q,K的牌)。
 如上文所提到的,枚举型 Rank 在自己内部定义了一个嵌套结构体 Values 。在这个结构体中,只有 Ace 有两个数 值,其余牌都只有一个数值。结构体 Values 中定义的两个属性:
 • first为Int
 • second 为 Int? 或 “optional Int ”
 Rank 定义了一个计算属性 values ,它将会返回一个结构体 Values 的实例。这个计算属性会根据牌的面值,用 适当的数值去初始化 Values 实例,并赋值给 values 。对于 J , Q , K , Ace 会使用特殊数值,对于数字面值的牌 使用 Int 类型的值。
 BlackjackCard 结构体自身有两个属性— rank 与 suit ,也同样定义了一个计算属性 description , descriptio n 属性用 rank 和 suit 的中内容来构建对这张扑克牌名字和数值的描述,并用可选类型 second 来检查是否存在第 二个值,若存在,则在原有的描述中增加对第二数值的描述。
 */

//因为 BlackjackCard 是一个没有自定义构造函数的结构体,在结构体的逐一成员构造器 (页 0)中知道结构体有默认的成员构造函数,所以你可以用默认的 initializer 去初始化新的常量 theAceOfSpades :

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

//尽管 Rank 和 Suit 嵌套在 BlackjackCard 中,但仍可被引用,所以在初始化实例时能够通过枚举类型中的成员名 称单独引用。在上面的例子中 description 属性能正确得输出对 Ace 牌有1和11两个值。

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\嵌套类型的引用
//在外部对嵌套类型的引用，已被嵌套的名字为前缀，加上所言引用的属性名

let heartSymbol = BlackjackCard.Suit.Hearts.rawValue
//对于上面这个例子,这样可以使 Suit , Rank , 和 Values 的名字尽可能的短,因为它们的名字会自然的由定义 它们的上下文来限定。






