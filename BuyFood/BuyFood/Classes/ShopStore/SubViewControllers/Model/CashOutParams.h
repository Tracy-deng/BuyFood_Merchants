//
//  CashOutParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/5.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashOutParams : NSObject

/** 注册时手机号码 */
@property (nonatomic, strong) NSString *telephone;
/** 验证码 */
@property (nonatomic, strong) NSString *verifycode;
/** 支付宝号 */
@property (nonatomic, strong) NSString *allipay;
/** 银行卡号 */
@property (nonatomic, strong) NSString *bankname;
/** 用户id */
@property (nonatomic, strong) NSString *userid;
/** 提现金额 */
@property (nonatomic, strong) NSString *outmoney;



@end
