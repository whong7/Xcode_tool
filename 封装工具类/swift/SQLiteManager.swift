//
//  SQLiteManager.swift
//  数据库演练
//
//  Created by heima on 16/9/11.
//  Copyright © 2016年 heima. All rights reserved.
//

import UIKit
import FMDB

private let dbName = "status.db"

class SQLiteManager: NSObject {
    
    static let shared = SQLiteManager()
    
    // 全局数据库操作队列
    var queue: FMDatabaseQueue?
    
    override init() {
        super.init()
        
        // 1. 打开数据库
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
        print("数据库的路径：\(path)")
        // 1. 判断是否数据库文件，如果没有就创建
        // 2. 打开该数据库文件
        queue = FMDatabaseQueue(path: path)
        
        // 2. 创建表
        createTable()
    }
    
    
    /// 创建表
    private func createTable() {
        let pathURL = Bundle.main.url(forResource: "db.sql", withExtension: nil)!
        // 取到内容
        let sql = try! String(contentsOf: pathURL)
        print(sql)
        
        queue?.inDatabase({ (db) in
            let result = db!.executeStatements(sql)
            if result {
                print("创表成功")
            }else{
                print("创表失败")
            }
        })
    }
    
    
    /// 通过一条sql查询数据库里面的内容，并且将每一条数据当作一个字典返回
    ///
    /// - returns: <#return value description#>
    func execRecordSet(sql: String) -> [[String: Any]] {
        
        var result = [[String: Any]]()
        
        queue?.inDatabase({ (db) in
            // 获取结果集
            let resultSet = db!.executeQuery(sql, withArgumentsIn: nil)!
            // 遍历结果集取到每一条数据
            while resultSet.next() {
                // 初始一个字典用于保存当前这一条数据
                var dict = [String: Any]()
                
                let colCount = resultSet.columnCount()
                for i in 0..<colCount {
                    // 能够取到每一个列的内容
                    // 列名
                    let colName = resultSet.columnName(for: i)!
                    // 值
                    let colValue = resultSet.object(forColumnIndex: i)
                    // 将这一列的值保存到字典里面
                    dict[colName] = colValue
                }
                // 将这一条数据对应的字典添加到数组里面
                result.append(dict)
            }
        })
        
        return result
    }
}
