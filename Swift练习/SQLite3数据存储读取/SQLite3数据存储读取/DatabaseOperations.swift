//
//  DatabaseOperations.swift
//  SQLite3数据存储读取
//
//  Created by EastElsoft on 2017/5/17.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import Foundation

//创建 DatabaseOperations.swift 文件来管理数据库的操作

class DadabaseOperations {
    //不透明指针，对应 C 语言里面的 void *， 这里指 sqlite3 指针
    private var db: OpaquePointer? = nil
//    var vc: UIViewController?
    
    //初始化方法打开数据库
    required init(dbPath: String) {
        print("db path:" + dbPath)
        
        //String 类的路径，转换成 cString
        let cpath = dbPath.cString(using: String.Encoding.utf8)
        
        //打开数据库
        let error = sqlite3_open(cpath!, &db)
        
        //数据库打开失败处理
        if error != SQLITE_OK {
            sqlite3_close(db)
        }
    }
    
    deinit {
        //关闭数据库
        self.closeDb()
    }
    
    //关闭数据库
    func closeDb() {
        sqlite3_close(db)
    }
    
    //MARK: 创建表
    //创建表
    func createTable() -> Bool {
        //创建表的 SQL 语句
//        let sql = "CREATE TABLE AppUser(id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , userEmail VARCHAR NOT NULL , userPawd VARCHAR NOT NULL )"
        let sql = "CREATE TABLE UserTable(id INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, userName TEXT NOT NULL, password TEXT NOT NULL, email TEXT, age INTEGER)"
        
        //执行 SQL 语句
        let execResult = sqlite3_exec(db, sql.cString(using: String.Encoding.utf8)!, nil, nil, nil)
        
        //判断是否执行成功
        if execResult != SQLITE_OK {
            return false
        }
        
        return true
        
    }
    
    //MARK: 增
    //插入一条信息
    func addUser(_ user: Person) -> Bool {
        
        //插入 SQL 语句
        let sql = "INSERT INTO UserTable (userName, password, email, age) VALUES (?, ?, ?, ?);"
        
        // SQL 语句转换成 CString 类型
        let cSql = sql.cString(using: String.Encoding.utf8)
        
        // sqlite3_stmt 指针
        var stmt: OpaquePointer? = nil
        
        //1.编译 SQL
        let prepare_result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        
        //判断如果失败，获取失败信息
        if prepare_result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8: sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to prepare SQL: \(sql), error: \(error)"
                print(msg)
                self.alert(msg)
            }
            return false
        }
        
        //2. bind 绑定参数
        //第 2 个参数：索引从 1 开始，最后一个参数为 函数指针
        sqlite3_bind_text(stmt, 1, user.name!.cString(using: String.Encoding.utf8)!, -1, nil)
        sqlite3_bind_text(stmt, 2, user.password!.cString(using: String.Encoding.utf8), -1, nil)
        sqlite3_bind_text(stmt, 3, user.email!.cString(using: String.Encoding.utf8), -1, nil)
        sqlite3_bind_int(stmt, 4, CInt(user.age!))
        
        //3. step 执行
        let step_result = sqlite3_step(stmt)
        
        //判断执行结果，如果失败，获取失败信息
        if step_result != SQLITE_OK && step_result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8: sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to execute SQL: \(sql), error: \(error)"
                print(msg)
                self.alert(msg)
            }
            return false
        }
        
        //4. finalize
        sqlite3_finalize(stmt)

        return true
    }
    
    
    //MARK: 查
    func readAllUsers() -> [Person] {
        //声明一个 Person 对象数组（查询的信息会添加到该数组）
        var usersArr = [Person]()
        
        //查询 SQL 语句
        let sql = "SELECT * FROM UserTable;"
        let cSql = sql.cString(using: String.Encoding.utf8)
        
        // sqlite3_stmt 指针
        var stmt: OpaquePointer? = nil
        
        //1.编译 SQL
        let prepare_result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        if prepare_result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8: sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to prepare SQL: \(sql), error: \(error)"
                print(msg)
                self.alert(msg)
            }
            return usersArr
        }
        
        //2.step
        while sqlite3_step(stmt) == SQLITE_ROW  {
            let user = Person()
            
            //循环从数据库中获取数据，添加到数组中
            let cName = UnsafePointer(sqlite3_column_text(stmt, 0))
            let cPwd = UnsafePointer(sqlite3_column_text(stmt, 1))
            let cEmail = UnsafePointer(sqlite3_column_text(stmt, 2))
            let cAge = sqlite3_column_int(stmt, 3)
            
            user.name = String(cString: cName!)
            user.password = String(cString: cPwd!)
            user.email = String(cString: cEmail!)
            user.age = Int(cAge)
            
            usersArr += [user]

        }
        //3. finalize
        sqlite3_finalize(stmt)
        
        return usersArr
    }
    
    
    //MARK: 改
    //根据条件更新一条信息
    func updateUser(name: String, toName: String) -> Bool {
        
        //更新 SQL 语句
        let sql = "update UserTable set userName = '\(toName)' where userName = '\(name)'"
        let cSql = sql.cString(using: String.Encoding.utf8)
        
        //sqlite3_stmt 指针
        var stmt: OpaquePointer? = nil
        
        //1.编译
        let prepare_result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        if prepare_result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8: sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to prepare SQL: \(sql), error: \(error) "
                print(msg)
                self.alert(msg)
            }
            return false
        }
        
        //2. step 执行
        let step_result = sqlite3_step(stmt)
        if step_result != SQLITE_OK && step_result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8: sqlite3_errmsg(self.db)) {
                let msg = "SQLiteDB - failed to execute SQL: \(sql), error: \(error) "
                print(msg)
                self.alert(msg)
            }
            return false
        }
        
        //3. finalize
        sqlite3_finalize(stmt)
        return true
    }
    
    //MARK: 删
    //删除数据
    func deleteUser(username:String) -> Bool {
        
        //删除sql语句
        let sql = "delete from UserTable where username = '\(username)'";
        
        //sqlite3_stmt指针
        var stmt:OpaquePointer? = nil
        let cSql = sql.cString(using: .utf8)
        
        //编译sql
        let prepare_result = sqlite3_prepare_v2(self.db, cSql!, -1, &stmt, nil)
        
        //判断如果失败，获取失败信息
        if prepare_result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if (sqlite3_errmsg(self.db)) != nil {
                let msg = "SQLiteDB - failed to prepare SQL:\(sql)"
                print(msg)
            }
            return false
        }
        
        //step执行
        let step_result = sqlite3_step(stmt)
        
        //判断执行结果，如果失败，获取失败信息
        if step_result != SQLITE_OK && step_result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if (sqlite3_errmsg(self.db)) != nil {
                let msg = "SQLiteDB - failed to execute SQL:\(sql)"
                print(msg)
            }
            return false
        }
        
        //finalize
        sqlite3_finalize(stmt)
        
        return true
    }
    
    //MARK: 复制数据库路径
    //将Bundle.main路径下的数据库文件复制到Documents下
    class func loadDBPath() -> String {
        
        //声明一个Documents下的路径
        let dbPath = NSHomeDirectory() + "/Documents/RWDataTest.sqlite"
        
        //判断数据库文件是否存在
        if !FileManager.default.fileExists(atPath: dbPath) {
            
            //获取安装包内是否存在
            let bundleDBPath = Bundle.main.path(forResource: "RWDataTest", ofType:"sqlite")!
            
            //将安装包内的数据库到Documents目录下
            do {
                try FileManager.default.copyItem(atPath: bundleDBPath, toPath: dbPath)
            } catch let error as NSError {
                print(error)
            }
        }
        
        return dbPath
    }
    
    
    
    //定义一个报警器 
    func alert(_ msg: String) {
        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: "SQLiteDB", message: msg, preferredStyle: UIAlertControllerStyle.alert)
//            let alertActoin = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
//            alertController.addAction(alertActoin)
//            alertController.show(self.vc!, sender: nil)
        }
    }
}






















