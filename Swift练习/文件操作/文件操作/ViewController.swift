//
//  ViewController.swift
//  文件操作
//
//  Created by EastElsoft on 2017/5/15.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //获取沙盒中文件路径
        self.getDiffrentPath()
        
        self.useFileOperations()
    }
    
    
    func getDiffrentPath() {
        //应用程序的非代码文件都保存在沙盒中，如：图片、声音、各种文档、文本文件
        
        //获取程序的 Home 目录：
        let homeDirectory = NSHomeDirectory()
        print(homeDirectory)
        
        //建议将程序中浏览到的文件数据保存在 Documents  目录下，ITunes 备份和恢复的时候会包含此目录。获取 Documents 目录代码
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentPath = documentPaths[0]
        print(documentPath)
        
        //或通过 home 目录自己追加文件夹
        let documentPath2 = homeDirectory + "/Documents"
        print(documentPath2)
        
        
        //Library 目录下有两个子目录：Caches 和 Preferences
        /*
         Libary Preferences 目录包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用 NSUserDefaults 类来取得和设置应用程序的偏好
         Library Caches 目录祝好存储缓存文件，ITunes 不会不备份此目录，此目录下的文件不会再应用退出时删除
         */
        
        //获取 Library 目录
        let libraryPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let libraryPath = libraryPaths[0]
        print(libraryPath)
        
        //或通过 home 目录自己追加文件夹
        let libraryPath2 = homeDirectory + "/Library"
        print(libraryPath2)
        
        
        //获取 Cache
        let cachesPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachesPath = cachesPaths[0]
        print(cachesPath)
        
        //或通过 home 目录自己追加文件夹
        let cachesPath2 = homeDirectory + "/Library/Caches"
        print(cachesPath2)
        
        /*
         tmp 目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
         */
        //获取 tmp 目录
        let tmpDir = NSTemporaryDirectory()
        print(tmpDir)
        
        //或通过 home 目录自己追加文件夹
        let tmpDir2 = homeDirectory + "/tmp"
        print(tmpDir2)
    }
    
    //******************** 文件操作
    func useFileOperations() {
        //对文件操作
        //创建文件管理器
        let fileManager: FileManager = FileManager.default
        //定义几个自己的目录
        let myDirectory1: String = NSHomeDirectory() + "/Documents/myFolder/Images"
        let myDirectory2: String = NSHomeDirectory() + "/Documents/myFolder/Films"
        let myDirectory3: String = NSHomeDirectory() + "/Documents/myFolder/Musics"
        let myDirectory4: String = NSHomeDirectory() + "/Documents/myFolder/Files"
        //创建目录
        do {
            //withIntermediateDirectories 设置成true，代表中间所有的路径目录如果不存在，都会创建
            //如果设置成false，因为myFolder目录不存在，所以无法创建1234目录
            try fileManager.createDirectory(atPath: myDirectory1, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {//如果创建失败，error会返回错误信息
            print(error)
        }
        
        do {
            //withIntermediateDirectories 设置成true，代表中间所有的路径目录如果不存在，都会创建
            //如果设置成false，因为myFolder目录不存在，所以无法创建1234目录
            try fileManager.createDirectory(atPath: myDirectory2, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {//如果创建失败，error会返回错误信息
            print(error)
        }
        
        do {
            //withIntermediateDirectories 设置成true，代表中间所有的路径目录如果不存在，都会创建
            //如果设置成false，因为myFolder目录不存在，所以无法创建1234目录
            try fileManager.createDirectory(atPath: myDirectory3, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {//如果创建失败，error会返回错误信息
            print(error)
        }
        
        do {
            //withIntermediateDirectories 设置成true，代表中间所有的路径目录如果不存在，都会创建
            //如果设置成false，因为myFolder目录不存在，所以无法创建1234目录
            try fileManager.createDirectory(atPath: myDirectory4, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {//如果创建失败，error会返回错误信息
            print(error)
        }
        
        //创建文件
        let filePath = myDirectory1 + "/appInfo.txt"
        let info = "经常听到：被中介骗了，押金不退，晚一天交房租，被讹了。租房普遍现象：网上报价不真实？经常被忽悠！（看房时报价都比网上高！）证件不齐全，被骗过!（其实根本不是房东啦!）看房前态度都很热情！ 签约之后态度骤变!入住后家电维修只能靠自己！ 房屋到期，押金各种被勒索！现在开始，你来改变这一切！《租房点评》为你而备，租房无忧！再也不用担心被欺骗，想要知道给你介绍房子的人好不好，《租房点评》告诉你！"
        
        //通过 write to file 方法将一些对象写入到文件中。String、NSString、UIImage、NSArray、NSDictionary等
        do {
            try info.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
        
        //将图片保存到文件路径下
        let image = UIImage.init(named: "SwiftClassWeiXin@3x.png")
        let data: NSData = UIImageJPEGRepresentation(image!, 1.0)! as NSData
        let data1: NSData = UIImagePNGRepresentation(image!)! as NSData
        data.write(toFile: myDirectory1 + "/SwiftClassIcon.jpg", atomically: true)
        data1.write(toFile: myDirectory1 + "/SwiftClassIcon.png", atomically: true)
        
        //NSArray、NSDictionary保存到文件路径下
        let array = NSArray(objects: "111", "333", "222")
        array.write(toFile: myDirectory4 + "/array.plist", atomically: true)
        let dictionary = NSDictionary.init(objects: ["1111", "2222", "3333", "4444"], forKeys: ["1" as NSCopying, "2" as NSCopying, "3" as NSCopying, "4" as NSCopying])
        dictionary.write(toFile: myDirectory4 + "/dictionary.plist", atomically: true)
        
        //MARK: --判断目录或文件是否存在
        let exist = fileManager.fileExists(atPath: filePath)
        print(exist)
        
        //MARK: -- filePath 路径下对应的文件移动到 filePath2 路径下
        let filePath2 = myDirectory4 + "/appInfo.txt"
        do {
            try fileManager.moveItem(atPath: filePath, toPath: filePath2)
        } catch let error as NSError {
            print(error)
        }
        
        //同一个文件夹下移动文件，相当于将文件重命名
        let filePath3 = myDirectory4 + "/appInfo2.txt"
        do {
            try fileManager.moveItem(atPath: filePath2, toPath: filePath3)
        } catch let error as NSError {
            print(error)
        }
        
        //复制
        let filePath4 = myDirectory4 + "/appInfoCopy.txt"
        do {
            try fileManager.copyItem(atPath: filePath3, toPath: filePath4)
        } catch let error as NSError {
            print(error)
        }
        
        //MARK: --获取目录列里所有文件名
        //先拷贝一些文件到myDirectory4目录下
        let filePath00 = myDirectory4 + "/appInfoCopy00.txt"
        let filePath11 = myDirectory4 + "/appInfoCopy11.txt"
        let filePath22 = myDirectory4 + "/appInfoCopy22.txt"
        do
        {
            try fileManager.copyItem(atPath: filePath3, toPath: filePath00)
            try fileManager.copyItem(atPath: filePath3, toPath: filePath11)
            try fileManager.copyItem(atPath: filePath3, toPath: filePath22)
        }
        catch let error as NSError {
            print(error)//如果创建失败，error 会返回错误信息
        }
        
        //获取所有文件
        let fileArray = fileManager.subpaths(atPath: myDirectory4)
        print(fileArray ?? "")
        
        //MARK: --获取文件的各项属性
        do {
            var fileAttributes: [AnyHashable: Any]? = try fileManager.attributesOfItem(atPath: filePath2) as [NSObject : AnyObject]
            //获取文件的创建日期
            let modificationDate: AnyObject? = fileAttributes?[FileAttributeKey.modificationDate] as AnyObject
            print(modificationDate ?? "")
            
            //获取文件大小
            let fileSize: AnyObject? = fileAttributes?[FileAttributeKey.size] as AnyObject
            print(fileSize ?? "")
            
        } catch let error as NSError {
            print(error)
        }
        
        //MARK: --删除文件
        do {
            try fileManager.removeItem(atPath: filePath4)
        } catch let error as NSError {
            print(error)
        }
        
        //删除目录下的所有文件
        //1.获取所有文件，然后遍历删除
        let fileArray2: [AnyObject]? = fileManager.subpaths(atPath: myDirectory4)! as [AnyObject]
        
        for file in fileArray2! {
            do {
                try fileManager.removeItem(atPath: file as! String)
            } catch let error as NSError {
                print(error)
            }
        }
        
        //2.删除目录后重新创建目录
        do {
            try fileManager.removeItem(atPath: myDirectory4)
            try fileManager.createDirectory(atPath: myDirectory4, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

