//
//  CountOperation.swift
//  多线程
//
//  Created by EastElsoft on 2017/5/23.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

// 继承自 Operation
class CountOperation: Operation {
    var startingCount: Int = 0
    var endingCount: Int = 0
    
    init(startCount: Int, endCount: Int) {
        startingCount = startCount
        endingCount = endCount
    }
    
    convenience override init() {
        self.init(startCount: 0, endCount: 3)
    }
    
    //重写 main 方法，在其中执行任务
    override func main() {
        var isTaskFinished = false
        while isTaskFinished == false && self.isFinished == false{
            for counter in startingCount..<endingCount {
                print("Count = \(counter)")
                print("Current thread = \(Thread.current)")
                print("Main thread = \(Thread.main)")
                print("--------------------------------")
            }
            isTaskFinished = true
        }
    }
}
