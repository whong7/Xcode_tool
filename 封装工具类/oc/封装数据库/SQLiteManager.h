//
//  SQLiteManager.h
//  oc数据库demo
//
//  Created by whong7 on 16/9/26.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface SQLiteManager : NSObject

// 全局访问点
+ (instancetype)sharedSQLiteManager;
@property (nonatomic, strong) FMDatabase *db;

//创建表
- (void)createTable;
@end
