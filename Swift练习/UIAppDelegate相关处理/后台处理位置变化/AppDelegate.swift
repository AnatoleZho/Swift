//
//  AppDelegate.swift
//  后台处理位置变化
//
//  Created by EastElsoft on 2017/5/25.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    //1.1
    var locationManager: CLLocationManager! = nil
    var isExecutingBackground = false
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //1.2
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        //1.3
        /* 当应用进入后台时，降低精度以减少 iOS 的压力 */
        isExecutingBackground = true
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //1.4
        /* 当应用再次处于前台状态是，增加定位检测精度 */
        isExecutingBackground = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isExecutingBackground {
            print("处于后台时，不做繁重的处理")
        } else {
            print("处于前台，做出相应的 UI 更新等出来")
        }
    }

}

