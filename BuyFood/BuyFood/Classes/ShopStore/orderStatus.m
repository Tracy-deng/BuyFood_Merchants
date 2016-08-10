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

- (NSString *)getOrderStatus:(NSString *)status
{
    NSString *orderS;
    if ([status isEqualToString:@"0"]) {
        orderS = @"订单已取消";
    }else if([status isEqualToString:@"1"]){
          orderS = @"待支付";
    }else if ([status isEqualToString:@"2"]){
        orderS = @"已支付";
    }else if ([status isEqualToString:@"3"]){
        orderS = @"商家接单";
    }else if ([status isEqualToString:@"4"])
    {
        orderS = @"商家未接单";
    }else if ([status isEqualToString:@"5"])
    {
        orderS = @"已退还余额";
    }else if ([status isEqualToString:@"6"])
    {
        orderS = @"用户自提";
    }else if ([status isEqualToString:@"7"])
    {
        orderS = @"用户自提完成";
    }else if ([status isEqualToString:@"8"])
    {
        orderS = @"骑士接单";
    }else if ([status isEqualToString:@"9"])
    {
        orderS = @"骑士已从商家取货";
        
    }else if ([status isEqualToString:@"10"])
    {
        orderS = @"配送中";
    }else if ([status isEqualToString:@"11"])
    {
        orderS = @"已送达";
    }else if ([status isEqualToString:@"12"])
    {
        orderS = @"已评价";
    }else if ([status isEqualToString:@"13"])
    {
        orderS = @"已投诉";
    }else if ([status isEqualToString:@"30"])
    {
        orderS = @"用户退整单";
    }
    return orderS;
}
@end
