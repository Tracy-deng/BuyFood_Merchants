//
//  ShopsUserInfoTool.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/11.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopsUserInfo.h"

@interface ShopsUserInfoTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ShopsUserInfo *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型 
 */
+ (ShopsUserInfo *)account;


@end
