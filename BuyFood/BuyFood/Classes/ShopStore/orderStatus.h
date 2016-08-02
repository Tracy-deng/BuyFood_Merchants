//
//  orderStatus.h
//  BuyFood
//
//  Created by dave-n1 on 16/8/2.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderStatus : NSObject
+(instancetype)shareBillStatus;
- (NSString *)getOrderStatus:(NSString *)status;

@end
