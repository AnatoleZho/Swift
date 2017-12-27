//
//  AppDelegate.swift
//  后台播放音频
//
//  Created by EastElsoft on 2017/5/25.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AVAudioPlayerDelegate {

    var window: UIWindow?

    var audioPlayer: AVAudioPlayer?
    
    var fileData: NSData?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        //1.1 /** 当应用开启，我们分配 being 初始化音频播放器，将 等风的日子.mp3 的文件读取到 Data 类型的实例中，音频播放器初始化过程中需要它*/
        let dispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        dispatchQueue.async { [weak self] in
            let audioSession = AVAudioSession.sharedInstance()
            NotificationCenter.default.addObserver(self!, selector: #selector(self?.handleInterruption(_:)), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
            
            do {
                try  audioSession.setActive(true)
            } catch let error as NSError {
                print(error)
            }
        
            do {
                try  audioSession.setCategory(AVAudioSessionCategoryPlayback)
                print("Successfully set the audio session")
            } catch let error as NSError {
                print(error)
            }
         
            let filePath = Bundle.main.path(forResource: "等风的日子", ofType: "mp3")
            do {
                try self?.fileData = NSData.init(contentsOfFile: filePath!, options: NSData.ReadingOptions.mappedIfSafe)
            } catch let error as NSError {
                print(error)
            }
            
            //开始音频播放器
            do {
                try self?.audioPlayer = AVAudioPlayer.init(data: (self?.fileData)! as Data)
            } catch let error as NSError {
               print(error)
            }
            
            if let theAudioPlayer = self?.audioPlayer {
                theAudioPlayer.delegate = self
                if theAudioPlayer.prepareToPlay() && theAudioPlayer.play() {
                   print("Successfully started playing")
                } else {
                  print("初始化音频播放器失败")
                }
            }
        }
        
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
    
    //1.2 /** 音频回话被中断，播放器被暂停 */
    func handleInterruption(_ notification: Notification) {
        let interruptionTypeAsObject = notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber
        print(notification)
//        if interruptionTypeAsObject == kAudioSessionEndInterruption {
//            print("如果需要，挂起音频")
//        }
        
    }


}

