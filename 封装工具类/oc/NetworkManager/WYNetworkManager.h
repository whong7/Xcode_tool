//
//  WYNetworkManager.h
//  网易新闻19
//
//  Created by heima on 16/8/11.
//  Copyright © 2016年 itcast. All rights reserved.
//  数据请求的工具类.

#import <AFNetworking/AFNetworking.h>

@interface WYNetworkManager : AFHTTPSessionManager

/**
 *  全局访问点
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedManager;


/**
 *  发起GET请求
 *
 *  @param urlString  请求地址
 *  @param parameters 请求参数
 *  @param completion 请求完成之后的回调
 */
- (void)getWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void(^)(id response, NSError *error))completion;

/**
 *  获取首页的新闻数据
 *
 *  @param channelId  频道id
 *  @param completion <#completion description#>
 */
- (void)getHomeNewListWithChannelId:(NSString *)channelId completion:(void(^)(id response, NSError *error))completion;

@end
