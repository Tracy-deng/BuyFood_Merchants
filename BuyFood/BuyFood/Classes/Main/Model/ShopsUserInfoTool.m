//
//  ShopsUserInfoTool.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/11.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopsUserInfoTool.h"

#define HDCAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"shopsInfo.archive"]

@implementation ShopsUserInfoTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ShopsUserInfo *)account
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HDCAccountPath];
}

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ShopsUserInfo *)account
{
    // 加载模型
    ShopsUserInfo *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HDCAccountPath];
    return account;
}

@end
