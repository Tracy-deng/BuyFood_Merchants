//
//  OrderParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderParams : NSObject
/** 商家ID */
@property (nonatomic, strong) NSString *marketuserid;
/** 当前页 当前显示的第几页*/
@property (nonatomic, strong) NSString *pageindex;
/** 每页显示条数 每次获取多少条数据 */
@property (nonatomic, strong) NSString *pagesize;

@end
