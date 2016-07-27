//
//  SecKillStartTimeAndEndTime.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecKillStartTimeAndEndTime : NSObject
/** 秒杀开始时间 */
@property (nonatomic, strong) NSString *starttime;
/** 秒杀结束时间 */
@property (nonatomic, strong) NSString *endtime;
/** 秒杀不同时间段的id */
@property (nonatomic, strong) NSString *secid;
/** 开始结束时间 */
@property (nonatomic, strong) NSString *start_end;

@end
