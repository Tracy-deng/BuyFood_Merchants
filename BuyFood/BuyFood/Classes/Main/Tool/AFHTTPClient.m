//
//  AFHTTPClient.m
//  CloudV2
//
//  Created by Xiaomin on 16/4/18.
//  Copyright © 2016年 Xiaomin. All rights reserved.
//

#import "AFHTTPClient.h"

@implementation AFHTTPClient
+(instancetype)sharedClient{
    static AFHTTPClient *_sharedClient = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _sharedClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    
    return _sharedClient;
}
+ (void)postDataWithPath:(NSString *)path
              parameters:(NSDictionary *)parameters
                   block:(void (^)(id info, NSError *error))block{
    
    [[AFHTTPClient sharedClient]POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"AFHTTP这里%@",responseObject);
        if (block) {
            block(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    }];

}
+(void)requestWithURL:(NSString *)urlString withparams:(id)params block:(void (^)(id result, NSError *error))block{
    if (params) {
        params = [NSMutableDictionary dictionaryWithDictionary:params];
        [params setObject:@"0.3" forKey:@"ver"];   //
    }
    NSString *urlStr = [BASE_URL stringByAppendingString:urlString];
    [AFHTTPClient postDataWithPath:urlStr parameters:params block:^(id info, NSError *error) {
        if (error) {
            if (block) {
                //访问出错,则向上反馈错误信息,不继续处理结束
                block(nil,error);
                return ;
            }
        }
        if (block) {
            block(info,error);
        }
    }];
    
    
}


@end
