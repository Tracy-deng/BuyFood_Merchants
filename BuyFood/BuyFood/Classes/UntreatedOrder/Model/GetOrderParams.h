//
//  GetOrderParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetOrderParams : NSObject

/** 订单编号 */
@property (nonatomic, strong) NSString *orderno;
/** 商户id */
@property (nonatomic, strong) NSString *marketuserid;
/** 传1自提订单(接单)-后台直接推送给用户
    传2配送订单(接单)-后台直接推送给骑士
    传3快递订单(接单)-后台推送给快递(用户品牌馆接单)*/
@property (nonatomic, assign) NSInteger posttypeid;


/** 商户拒绝接单 传用户id posttypeid这个参数就不需要传了*/
@property (nonatomic, strong) NSString *userid;


@end
