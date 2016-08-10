//
//  InputPostInfoParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/10.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputPostInfoParams : NSObject

/** 订单号 */
@property (nonatomic, strong) NSString *orderno;
/** 快递单号 */
@property (nonatomic, strong) NSString *postnumber;
/** 快递名称 */
@property (nonatomic, strong) NSString *postcompany;

@end
