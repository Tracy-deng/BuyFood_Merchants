//
//  MyBillModel.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBillModel : NSObject

/** 账单id */
@property (nonatomic, strong) NSString *_biilid;
/** 账单类型 */
@property (nonatomic, strong) NSString *_billtype;
/** 支出 -- 取现 */
@property (nonatomic, strong) NSString *_cash;
/** 来源 -- 去处 */
@property (nonatomic, strong) NSString *_comefrom;
/** 时间 */
@property (nonatomic, strong) NSString *_modifytime;
/** 订单编号 */
@property (nonatomic, strong) NSString *_orderno;
/** XXX */
@property (nonatomic, strong) NSString *_remark;
/** 商户id */
@property (nonatomic, strong) NSString *_userid;

@end
