//
//  SQLiteManager.m
//  oc数据库demo
//
//  Created by whong7 on 16/9/26.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "SQLiteManager.h"
#import "CNGoodsModel.h"


static SQLiteManager *manager = nil;

@implementation SQLiteManager

+ (SQLiteManager *)sharedSQLiteManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQLiteManager alloc] init];
        [manager createDataBase];
        [manager createTable];
    });
    return manager;
}
- (instancetype)init {
    if (self = [super init]) {
        
//        // 1. 创建数据库
//        [self createDataBase];
//        
//        // 2. 创建表格
//        [self createTable];
        
    }
    return self;
}


//创建数据库
- (void)createDataBase{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)firstObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"contacts.sqlite"];
    NSLog(@"路径：%@",filePath);
    //创建数据库
    self.db = [FMDatabase databaseWithPath:filePath];
}
//创建表
- (void)createTable{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_contact (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, phoneNum text NOT NULL);"];
        if (result) {
            NSLog(@"创建成功");
        }else{
            NSLog(@"创建失败");
        }[self.db close];
    }else{
        NSLog(@"数据库打开失败");
    }

}
//插入操作
- (void)insertContact:(CNSearchModel *)contact{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"INSERT INTO t_contact (name, phoneNum) VALUES (?,?);", contact.name, contact.phoneNum];
        if (result) {
            NSLog(@"创建成功");
        }else{
            NSLog(@"创建失败");
        }
        [self.db close];
    }else{
        NSLog(@"数据库打开失败");
    }
}
////删除
//- (void)deleteContact:(Contact *)contact{
//    if ([self.db open]) {
//        BOOL result = [self.db executeUpdate:@"delete from t_contact where phoneNum = ?",contact.phoneNum];
//        if (result) {
//            NSLog(@"创建成功");
//        }else{
//            NSLog(@"创建失败");
//        }
//        [self.db close];
//    }else{
//        NSLog(@"数据库打开失败");
//    }
//}
////修改数据
//- (void)updateContact:(Contact *)contact
//{
//    if ([self.db open]) {
//        BOOL result = [self.db executeUpdate:@"UPDATE t_contact SET name = ?,phoneNum = ? WHERE phoneNum = ?",
//                       contact.name,contact.phoneNum,contact.phoneNum];
//        if (result) {
//            NSLog(@"修改成功");
//        }
//        else
//        {
//            NSLog(@"修改失败");
//        } [self.db close];
//    }else{
//        NSLog(@"数据库打开失败");
//    }
//}
////查询
//- (NSArray *)queryContact{
//    NSMutableArray *arr = [NSMutableArray array];
//    if ([self.db open]) {
//        FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_contact"];
//        while ([set next]) {
//            NSInteger ID = [set intForColumn:@"id"];
//            NSString *name = [set stringForColumn:@"name"];
//            NSString *phoneNum = [set stringForColumn:@"phoneNum"];
//            Contact *contact = [[Contact alloc]initWithName:name phoneNum:phoneNum ID:ID];
//            [arr addObject:contact];
//        }
//    }
//    return arr;
//}



@end


