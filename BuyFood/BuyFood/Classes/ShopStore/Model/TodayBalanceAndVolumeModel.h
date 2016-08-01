//
//  TodayBalanceAndVolumeModel.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayBalanceAndVolumeModel : NSObject

@property (nonatomic, strong) NSString *CurrentPageIndex;
@property (nonatomic, strong) NSString *ErrorCode;
@property (nonatomic, strong) NSString *ErrorMsg;
@property (nonatomic, strong) NSString *serverTime;
@property (nonatomic, strong) NSString *totalcount;
@property (nonatomic, strong) NSString *totalmoney;
@property (nonatomic, strong) NSString *totalordercount;

@end
