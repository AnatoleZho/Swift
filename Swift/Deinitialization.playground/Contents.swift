//: Playground - noun: a place where people can play

import UIKit

///**         析构过程        **///
/*
 析构过程只适用于类类型,当一个类的实例被释放之前,析构器会被立即调用. 析构器用关键字 deinit 来标示, 类似于构造器 init 来标示
 */


////**         析构过程原理
/*
 Swift 会自动释放不再需要的实例以释放资源. Swift 通过自动引用计数(ARC)处理实例的内存管理. 通常当实例被释放时不需要手动地去清理.但是,当使用自己的资源时,可能需要进行一些额外的清理. 例如,如果创建了一个自定义的类来打开文件,并写入一下数据,可能需要在类实例释放之前手动去关闭该文件.
 
 在类的定义中,这个类最多只能有一个析构器,而且析构器不带任何参数:
 deinit {
 
 }
 
 析构器是在实例释放发生前被自动调用. 不能主动调用析构器.子类继承了父类的析构器,并且在子类析构器实现的最后,父类的析构器会被自动调用.即使子类没有提供自己自己的析构器,父类的析构器同样会调用.
 
 因为知道实例的析构器被调用后,实例才会被释放, 所以析构器可以访问实例的所有属性,并且可以根据那些属性可以修改它的行为
 
 */



////**         析构实践

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsRequested
        
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")

print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne = nil
print("PlayerOne has left the game")

print("The bank now has \(Bank.coinsInBank) coins")


