//
//  ViewController.swift
//  并发和多任务
//
//  Created by EastElsoft on 2017/5/21.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inactiveQueue:DispatchQueue?
    
    //懒加载
    //
    /**
     1.{} 包装代码
     2.() 执行代码
     
     日常开发
     1.闭包中智能提示不灵敏
     2.出现 self. 还需注意循环引用
     
     3.和 OC 懒加载的区别
     swift 懒加载的代码只会在第一次调用的时候执行闭包，将闭包的结果保存在属性 photo 中
     lazy 属性的代码块只会调用一次，lazy修饰的是一个存储属性，耳存放的是闭包
     */
    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.frame = CGRect.init(x: 0, y: 64, width: 320, height: 320)
        return photo
    }()
    
    
    
    //单例
    private let _onceToken = NSUUID().uuidString
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
         1. `dispatch queue`:一堆在主线程（或后台线程）上同步（或异步）来执行的代码，一旦被创建出来，操作系统就开始接手管理，在CPU上分配时间片来执行队列内的代码。开发者没法参与`queue`的管理。队列采用`FIFO模式`（先进先出），意味着先加入的也会被先完成，这和超市排队买单，队伍前的总是最先买单出去，的道理是一样一样的。
         
         2. `work item`：一段代码块，可以在queue创建的时候添加，也可以单独创建方便之后复用，你可以把它当成将要在`queue`上运行的一个代码块。`work items`也遵循着`FIFO模式`，也可以同步（或异步）执行，如果选择同步的方式，运行中的程序直到代码块完成才会继续之后的工作，相对的，如果选择异步，运行中的程序在触发了代码块就立刻返回了。
         
         3. `serial`(串行)vs`concurrent`（并行）：`serial`将会执行完一个任务才会开始下一个，`concurrent`触发完一个就立即进入下一个，而不管它是否已完成。
         */
        
        //将任务分发到主队列中的正确方式是调用 dispatch_async 函数，这个函数在分发队列中执行块对象，使用 dispatch_get_main_queue 函数获取主分发队列
        /* 不能在主队列中调用 dispatch_sync方法，这是因为它会导致线程无线阻塞，从而导致应用程序死锁， 所以通过 GCD 提交到主队列的任务，都应该以异步的方式提交 */
        /**
           dispatch_async函数，接受两个参数：
            分发队列的句柄：可以执行任务的分发队列，
            块对象：提交到分发队列，用于异步执行的块对象。
         */
        
       //MARK: 1.'serial'(串行) vs 'concurrent'（并行）
        //1.1创建一个 DispatchQueue 的方法  
        //串行队列和主线程一样都是串行输出的。换句话说也就是：主线程也是一个串行队列。
//        self.simpleSyncQueues()
       
        //主线程的函数和异步队列的函数是交替执行 也就是说二者同步的输出，这是因为：异步队列不会阻塞当前线程 而是会另开一个线程来执行当前的任务，而主线程上的任务也就不会被阻塞，所以二者是同步输出的
//       self.simpleAsyncQueues()
        
        /**
         通过上面的对比我们至少可以明白两个件事：
         
         1. 使用async主线程和后台线程可以并行执行任务
         
         2. 使用sync则只能串行执行任务, 当前线程被卡住直到串行任务完成才继续
         */
    
        
        
     //MARK: 2.GCD服务等级－－Qos队列
        /**
         GCD服务等级(GCD QoS):确定任务重要和优先级的属性
         
         QoS是个基于具体场景的枚举类型，在初始队列时，可以提供合适的QoS参数来得到相应的权限，如果没有指定QoS，那么初始方法会使用队列提供的默认的QoS值
         
         QoS等级(QoS classes)，从前到后，优先级从高到低: userInteractive  userInitiated  default  utility  background unspecified
         */
//        self.qosConcurrentQueues()
        /** 结果并没有像我们猜想的那样 同等级下的异步队列 并行输出，这是怎么回事呢？因为Qos队列默认是串行执行的，所以即使qos队列中的方法是异步的 也会被顺序串行执行。那么怎样才可以并行执行呢？这就要用到Qos队列的另外一个属*/
//        self.qosConcurrentQueues1()
        
        /**系统会使优先级更高的`queue1`比`queue2`更快被执行，虽然在`queue1`运行的时候`queue2`得到一个运行的机会，系统还是将资源倾斜给了被标记为更重要的`queue1`，等`queue1`内的任务全部被执行完成，系统才开始全心全意服务于`queue2` */
        //`main queue`默认就有一个很高的权限。
        self.qosQueues1()

        
       // Qos队列attributes的另外一个属性，initiallyInactive （不活跃的），我们可以创建一个qos的不活跃队列，这个队列的特点是 需要调用DispatchQueue类的`activate()`让任务执行
        
        qosConcurrentQueues2()
        if let queue = inactiveQueue {
            queue.activate()
        }
        
        //MARK: 3.延迟执行
        
        delayAction()
        
        //MARK: 4.DispatchWorkItem
        //DispatchWorkItem是一个代码块，它可以被分到任何的队列，包含的代码可以在后台或主线程中被执行，简单来说:它被用于替换我们前面写的代码block来调用
        
        workItemTest()
        
        //MARK: 5.主线程更新UI
        settingImage()

        
        //MARK: 6.单例
        DispatchQueue.once(token: _onceToken) {
            print("DO this once")
        }
        DispatchQueue.once(token: _onceToken) { 
            print("DO this once")
        }
        
        //MARK: 7.DispatchGroup 任务进行分组
        groupTask()
        
        
        //MARK: 8.barrier
            /**
              假设我们有一个并发的队列用来读写一个数据对象。如果这个队列里的操作是读的，那么可以多个同时进行。如果有写的操作，则必须保证在执行写入操作时，不会有读取操作在执行，必须等待写入完成后才能读取，否则就可能会出现读到的数据不对。在之前我们用dipatch_barrier实现。
             */
        let wirte = DispatchWorkItem(flags: .barrier) {
            // write data
            print("正在写入")
        }
        let dataQueue = DispatchQueue(label: "data", attributes: .concurrent)
        dataQueue.async(execute: wirte)
        

        //MARK: 9. signal 信号量
            /**
             为了线程安全的统计数量，我们会使用信号量作计数。原来的dispatch_semaphore_t现在用DispatchSemaphore对象表示。
             初始化方法只有一个，传入一个Int类型的数。
            */
  
        let semaphore = DispatchSemaphore(value: 5)
        
        // 信号量减一
        semaphore.wait()
        
        //信号量加一
        semaphore.signal()
    }

    //1.2 接下来我们创建一个串行的queue 和 在主线程中执行的代码对比下看看串行队列和主线程的区别？
    func simpleSyncQueues() {
         //label：后面是一个标识，可以随便写，一般建议写成你的工程的dns的反序比较好
        let queue = DispatchQueue.init(label: "com.syc.nd")
        //同步执行
        queue.sync {
            for i in 0..<10 {
               print("同步队列中执行--\(i)😊")
            }
        }
        //同步主队列执行
        for j in 0..<10 {
            print("同步主队列执行--\(j)🐔")
        }
    }

    func simpleAsyncQueues() {
        let queue = DispatchQueue.init(label: "com.syc.nd")
        //异步步执行
        queue.async {
            for i in 0..<10 {
                print("异步队列中执行--\(i)😀")
            }
        }
        //同步主队列执行
        for j in 0..<10 {
            print("同步主队列执行--\(j)🐥")
        }
    }

    //2.2 同个队列同等级 串行输出 对比
    func qosConcurrentQueues() {
        let queue = DispatchQueue.init(label: "com.syc.nd", qos: DispatchQoS.unspecified)
        queue.async {
            for i in 0..<10 {
                print("🙂\(i)")
            }
        }
        
        queue.async {
            for k in 100..<110 {
                print("😓\(k)")
            }
        }
    }
    //2.3 同个队列同等级 串行输出 对比
    //那么怎样才可以并行执行呢？这就要用到Qos队列的另外一个属性：attributes:.concurrent
    func qosConcurrentQueues1() {
        let queue = DispatchQueue.init(label: "com.syc.nd", qos: DispatchQoS.unspecified, attributes: .concurrent)
        queue.async {
            for i in 0..<10 {
                print("🙂\(i)")
            }
        }
        
        queue.async {
            for k in 100..<110 {
                print("😓\(k)")
            }
        }
    }

    //2.4 qos不同等级异步队列 对比
    func qosQueues1() {
        let queues1 = DispatchQueue.init(label: "com.syc.nd", qos: DispatchQoS.userInteractive)
        let queues2 = DispatchQueue.init(label: "com.syc.nd", qos: DispatchQoS.utility)
        queues1.async {
            for i in 0..<10 {
             print("queue1异步队列执行--\(i)🐻")
            }
        }
        queues2.async {
            for k in 0..<10 {
               print("queue异步队列执行--\(k)🐂")
            }
        }
        
        //同步主队列执行 ----实践证明：main queue 默认就有一个很高的权限
        for j in 0..<10 {
            print("同步主队列执行--\(j)🐑")
        }
    }
    //  Qos队列attributes的另外一个属性，initiallyInactive （不活跃的），我们可以创建一个qos的不活跃队列，这个队列的特点是 需要调用DispatchQueue类的`activate()`让任务执行。看下具体代码
    func qosConcurrentQueues2() {
        let queue = DispatchQueue.init(label: "com.nd.syc", qos: DispatchQoS.utility, attributes: [.initiallyInactive, .concurrent])
        inactiveQueue = queue
        queue.async {
            for i in 0..<10 {
              print("\(i)👌")
            }
        }
        queue.async {
            for k in 100..<110 {
              print("\(k)🐴")
            }
        }
        
    }
    
    //延迟执行
    func delayAction() {
        let delayQueue = DispatchQueue.init(label: "com.syc.nd", qos: DispatchQoS.userInteractive)
        /**
           seconds(Int)//秒
           milliseconds(Int）//毫秒
           microseconds(Int）//微秒
           nanoseconds(Int） //纳秒
         */
        
        let delayTime: DispatchTimeInterval = .seconds(5)
        print("🙂",Date())
        delayQueue.asyncAfter(deadline: (.now() + delayTime)) {
            print("😓",Date())
        }
    }
    
    //DispatchWorkItem是一个代码块，它可以被分到任何的队列，包含的代码可以在后台或主线程中被执行，简单来说:它被用于替换我们前面写的代码block来调用
    func workItemTest() -> Void {
        var num = 9
        let workItem: DispatchWorkItem = DispatchWorkItem {
           num = num + 5
        }
        
//        workItem.perform()//激活workitem代码块
        let queue = DispatchQueue.global(qos: .utility)
        //异步队列执行
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) { 
            print("workItem完成后的通知：",num)
        }
    }
    
    //获取图片
    func fatchImage() {
        let imageURL: URL = URL(string: "https://farm3.staticflickr.com/2891/33833709921_bec1f88a9b_k.jpg")!
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: imageURL) { (imageData, response, error) in
            if let data = imageData {
                print("Did download image data")
                DispatchQueue.main.async {[weak self] in
                    self?.photo.image = UIImage.init(data: data)
                }
            }
        }.resume()
    }
    //调用方法
    func settingImage() {
        view.addSubview(self.photo)
        fatchImage()
    }
    
    func groupTask() {
        //7.1 创建group
        let group = DispatchGroup();
        //7.2 创建队列
        let queueBook = DispatchQueue(label: "book")
        queueBook.async(group: group) {
            // 下载图书
            print("下载图书")
        }
        
        let queueVideo = DispatchQueue(label: "video")
        queueVideo.async(group: group) {
            // 下载视频
            print("下载视频")
        }
       
        //7.3 DispatchGroup会在组里的操作都完成后执行notify
        group.notify(queue: DispatchQueue.main) {
            //完成
            print("完成")
        }
       
        //如果有多个并发队列在一个组里，我们想在这些操作执行完了再继续，调用wait
        group.wait()
    }
}

//MARK:通过给DispatchQueue添加扩展实现
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }  
}
