//
//  AccountTool.m
//  testGetUserIno
//
//  Created by 黄栋春 on 16/4/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AccountTool.h"
#define HDCAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation AccountTool
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(AccountTool *)account
{
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HDCAccountPath];
}


/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (Account *)account
{
    // 加载模型
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HDCAccountPath];
    return account;
}

@end
