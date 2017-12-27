//
//  ViewController.swift
//  多线程
//
//  Created by EastElsoft on 2017/5/10.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var thread1: Thread?
    var thread2: Thread?
    var condition1: NSCondition?
    var condition2: NSCondition?
    var data: NSData?
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: 320, height: 320))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: Thread
/*
        condition1 = NSCondition()
        condition2 = NSCondition()

        //类方法
        Thread.detachNewThreadSelector(#selector(downloadImage), toTarget: self, with: nil)
        //实例方法，便利构造器
        let myThread: Thread = Thread(target: self, selector: #selector(downloadImage), object: nil)
        myThread.start()
        
        thread1 = Thread(target: self, selector: #selector(mothod1(sender:)), object: nil)
        thread1?.start()
        
        thread2 = Thread(target: self, selector: #selector(mothod2(sender:)), object: nil)
    
*/
        //MARK: NSOperation
         //1.通过子类创建操作
          /**
            继承 NSOperation 类， 重写新类的 main 方法，并将代码发放在其中。这些代码会被放到 NSOperationQueue 类型的队列中，与应用程序的其他代码兵法执行
          */
        //操作的遍历构造函数
        let operation = CountOperation.init(startCount: 0, endCount: 5)
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation)
        
        //2.通过闭包创建操作
          /**
             创建一个闭包，将操作的怠慢写入其中。玩撤了这部分代码，在代码之外创建一个 NSBlockOperation 类型的块操作对象。然后使用操作队列的 addOperation： 方法将块操作添加到操作队列中。这样会将操作分发到队列中，并且最终以异步方式运行快对象或者闭包
          */
        let operation1 = BlockOperation.init(block: operationCode)
        let operation2 = BlockOperation.init(block: operationCode)
    
        let operationQueue2 = OperationQueue()
        //假设操作是用户需要的
        operationQueue2.qualityOfService = .userInitiated
        //避免同时执行操作过多，引起系统过载
        operationQueue2.maxConcurrentOperationCount = 3
        operationQueue2.addOperation(operation1)
        operationQueue2.addOperation(operation2)
        
        //3. 操作间创建依赖关系
        let firstNum = 111
        let secondNum = 222
        let firstOperation = BlockOperation {[weak self] in
            self?.firstOperationEntry(param: firstNum as AnyObject)
        }
        
        let secondOperation = BlockOperation {[weak self] () -> Void in
          self?.secondOprationEntry(param: secondNum as AnyObject)
        }
        
        let dependencyOperationQueue = OperationQueue()
        //第一个操作依赖于第二个操作，所以第二个操作执行完毕后才会执行第一个操作
        firstOperation.addDependency(secondOperation)
        
        dependencyOperationQueue.addOperation(firstOperation)
        dependencyOperationQueue.addOperation(secondOperation)

        
        
    }
    
    func downloadImage() {
        let imageUrl = "https://farm3.staticflickr.com/2891/33833709921_bec1f88a9b_k.jpg"
        data = NSData(contentsOf: URL.init(string: imageUrl)!)
        //回到主线程中刷新UI
        self.performSelector(onMainThread: #selector(hadDown), with: nil, waitUntilDone: true)
        print(data?.length ?? 0)
    }
    
    func mothod1(sender: AnyObject) {
        print(Thread.current)
        for i in 0...9 {
            print("Thraed 1 running \(i)")
            sleep(1)
            
            if i == 2 {
                //启动线程2
                thread2?.start()
                //本线程（thread 1）锁定
                condition1?.lock()
                condition1?.wait()
                condition1?.unlock()
            }
        }
        print("Thread 1 over")
        
        //线程2 激活
        condition2?.signal()
    }
    
    func mothod2(sender: AnyObject) {
        print(Thread.current)
        for i in 0...9 {
            print("Thread 2 running \(i)")
            sleep(1)
            
            if i == 2 {
                //线程1 激活
                condition1?.signal()
                
                //本线程（thread 2）锁定
                condition2?.lock()
                condition2?.wait()//暂停线程，等待
                condition2?.unlock()
            }
        }
        
        print("Thread 2 over")
    }
   
    func hadDown() {
        imageView.image = UIImage.init(data: (data! as NSData) as Data)
        view.addSubview(imageView)
    }

    func operationCode() {
        for _ in 0...10 {
            print("Thread = \(Thread.current)")
        }
    }
    
    func performWorkForParameter(param: AnyObject?, operationName: String) {
        if let theParam = param {
            print("First Operation - Object = \(theParam) /n")
        }
        
        print("\(operationName) Operation -" + "Main Thread = \(Thread.main) /n")
        print("\(operationName) Operation -" + "Current Thread = \(Thread.main) /n")
    }

    func firstOperationEntry(param: AnyObject?) {
        performWorkForParameter(param: param, operationName: "First")
    }
    
    func secondOprationEntry(param: AnyObject?) {
        performWorkForParameter(param: param, operationName: "Second")
    }
}

