//
//  Account.h
//  testGetUserIno
//
//  Created by 黄栋春 on 16/4/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, assign) NSInteger marketuserid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
