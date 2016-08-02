//
//  orderStatus.m
//  BuyFood
//
//  Created by dave-n1 on 16/8/2.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "orderStatus.h"

@implementation orderStatus


+(instancetype)shareBillStatus
{
    static orderStatus *status = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        status = [[orderStatus alloc]init];
    });
    
    return status;
}

//- (NSString *)getOrderStatus:(NSString *)status
//{
//    NSString *orderS;
//    if ([status isEqualToString:@"0"]) {
//        orderS = @"订单已取消";
//    }else if([status isEqualToString:@"1"]){
//          orderS = @"待支付";
//    }else if ([status isEqualToString:@"2"]){
//        orderS = @"已支付";
//    }else if ([status isEqualToString:@"3"]){
//        orderS = @"商家接单";
//    }
//}
@end
