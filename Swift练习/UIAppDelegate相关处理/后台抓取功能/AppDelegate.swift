//
//  AppDelegate.swift
//  后台抓取功能
//
//  Created by EastElsoft on 2017/5/25.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 2 的属性
    var newsItems = [NewsItem]()
    
    //2.2  /** 当数组发生变化后，通知的名称将会被发送出去 */
    class func newsItemsChangedNotification() -> String {
        return "\(#function)"
    }
    //2.3 /** 模拟服务器访问，如果从服务器上获取了一些数据，返回为真 */
    func fetchNewsItems() -> Bool {
        //像抛硬币，使用随机数 0 或 1 ，如果是 0 代表没有新的数据从服务器下载下来 如果是 1 将新的项加入到列表中。
        if arc4random_uniform(2) != 1 {
            return false
        }
        
        /* 生成一个新的数据 */
        let item = NewsItem(data: Data(), text: "News Item \(newsItems.count + 1)")
        newsItems.append(item)
        print("have news")
        /* 向观察者发送一个通知，告诉他们有一个可用的数据 */
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppDelegate.newsItemsChangedNotification()), object: nil)
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 2.1 设置 application 的 setMinimumBackgroundFetchInterval
        newsItems.append(NewsItem(data: Data(), text: "News Item 1"))
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //2.4 如果2.3返回的是 true， 现在需要实现应用委托的后台抓取机制
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if self.fetchNewsItems() {
            completionHandler(.newData)
        } else {
            completionHandler(.noData)
        }
    }

}

