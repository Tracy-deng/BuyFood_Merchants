//
//  ChangePwdParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/31.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePwdParams : NSObject

/** 手机号码 */
@property (nonatomic, strong) NSString *telephone;
/** 原密码 */
@property (nonatomic, strong) NSString *pswd;
/** 新密码 */
@property (nonatomic, strong) NSString *newpswd;

@end
