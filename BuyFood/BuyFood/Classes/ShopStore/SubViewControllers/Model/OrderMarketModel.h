//
//  OrderMarketModel.h
//  RegisterDemo
//
//  Created by 黄栋春 on 16/7/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMarketModel : NSObject

/** 商家 获取 用户自提 订单(订单状态（0-订单已取消；1-待支付；2-已支付；3-商家接单；4-商家未接单；5-已退还余额；6-用户自提；7-用户自提完成；8-骑士接单；9-骑士已从商家取货 ，10-配送中；11-已送达；12-已评价；13-已投诉;30-用户退整单）) */
/** 商户订单明细 */
@property (nonatomic, strong) NSMutableArray *OrderDetailList;
/** 完成时间 */
@property (nonatomic, strong) NSString *finishedtime;
/** 总金额 */
@property (nonatomic, strong) NSString *markettotalmoney;
/** 商户地址 */
@property (nonatomic, strong) NSString *marketuseraddress;
/** 商户id */
@property (nonatomic, strong) NSString *marketuserid;
/** 订单编号 */
@property (nonatomic, strong) NSString *orderno;
/** 订单状态 */
@property (nonatomic, strong) NSString *orderstatus;
/** 订单时间 */
@property (nonatomic, strong) NSString *ordertime;
/** */
@property (nonatomic, strong) NSString *posttypeid;
/** */
@property (nonatomic, strong) NSString *posttypename;
/** */
@property (nonatomic, strong) NSString *senduserid;
/** 联系电话 */
@property (nonatomic, strong) NSString *telephone;
/** 用户地址 */
@property (nonatomic, strong) NSString *useraddress;


@end