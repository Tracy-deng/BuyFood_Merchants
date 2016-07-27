//
//  MarketOrderModelList.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarketOrderModelList : NSObject

@property (nonatomic, strong) NSString *CurrentPageIndex;
@property (nonatomic, strong) NSString *ErrorCode;
@property (nonatomic, strong) NSString *ErrorMsg;
@property (nonatomic, strong) NSString *OrderMarket;

@end
