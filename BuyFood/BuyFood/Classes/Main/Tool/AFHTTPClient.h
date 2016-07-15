//
//  AFHTTPClient.h
//  CloudV2
//
//  Created by Xiaomin on 16/4/18.
//  Copyright © 2016年 Xiaomin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#define BASE_URL @"http://appapi.yunduo.com:8030"
@interface AFHTTPClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
+(void)requestWithURL:(NSString *)urlString withparams:(id)params block:(void (^)(id result, NSError *error))block;

@end
