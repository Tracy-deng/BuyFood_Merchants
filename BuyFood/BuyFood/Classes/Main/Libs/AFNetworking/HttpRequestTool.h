//
//  HttpRequestTool.h
//  测试注册端接口
//
//  Created by 黄栋春 on 16/4/19.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpRequestTool : NSObject
//#define kCompetionHandlerBlock (void(^)(id model, NSError *error))completionHandler;
//定义了一个block类型
typedef void(^CompetionHandlerBlock)(id model, NSError *error);


+ (id)GET:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(CompetionHandlerBlock)completionHandler;

+ (id)POST:(NSString *)path parameters:(id)parameters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(CompetionHandlerBlock)completionHandler;

@end
