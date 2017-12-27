//
//  AppDelegate.swift
//  后台执行长时间任务
//
//  Created by EastElsoft on 2017/5/25.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 1 的属性
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var myTimer: Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //MARK:1.1 创建也启用定时器
        if isMultitaskingSupported() == false {
            return
        }
        
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerMethod(_:)), userInfo: nil, repeats: true)
        backgroundTaskIdentifier = application.beginBackgroundTask(withName: "task1", expirationHandler: { [weak self] in
            self?.endBackgroundTask()
        })
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //1.5 当任务被切换到前台时，如果我们的后台任务还在执行，则需要保证能够正确的处理它
        if backgroundTaskIdentifier != UIBackgroundTaskInvalid {
            endBackgroundTask()
        }
    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //1.2定时器的方法
    func timerMethod(_ sender: Timer) {
        let backgroundTimeRemaining = UIApplication.shared.backgroundTimeRemaining
        if backgroundTimeRemaining == Double.greatestFiniteMagnitude {
            print("Background Time Remaining  = Undermined")
        } else {
            print("\(backgroundTimeRemaining) Seconds")
        }
    }
    
    //1.3设备是否支持多任务
    func isMultitaskingSupported() -> Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    
    //1.4后台任务完成
    func endBackgroundTask() {
        DispatchQueue.main.async { [weak self] in
            if let timer = self?.myTimer {
                timer.invalidate()
                self?.myTimer = nil
                UIApplication.shared.endBackgroundTask((self?.backgroundTaskIdentifier)!)
                self?.backgroundTaskIdentifier = UIBackgroundTaskInvalid
            }
        }
        /**
         当长任务完成时，需要做：
         1. 结束所有的线程或定时器，不管是基础的定时器还是被GCD创建的任务
         2. 调用 UIApplication 的 endBackgroundTask 方法，结束后台任务
         3. 设置任务的标识符为 UIBackgroundTaskInvalid ，将任务标识符为结束
         */
    }


}

