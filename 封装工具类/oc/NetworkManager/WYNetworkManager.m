//
//  WYNetworkManager.m
//  网易新闻19
//
//  Created by heima on 16/8/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WYNetworkManager.h"

@implementation WYNetworkManager

+ (instancetype)sharedManager {
    static WYNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion {
    
    // 在这个方法内部去调用第三框架.
    // 调用父类的get方法去请求网络数据
    [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调请求回来的数据
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

#pragma mark - 获取新闻首页数据

- (void)getHomeNewListWithChannelId:(NSString *)channelId completion:(void(^)(id response, NSError *error))completion{
    
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/0-20.html", channelId];
    
    [self getWithUrlString:urlString parameters:nil completion:^(id response, NSError *error) {
        // 调用block 将数据回调出去
        completion(response, error);
    }];
}

@end
