//
//  OutDoorModelList.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutDoorModelList : NSObject

/** 活动图片 */
@property (nonatomic, strong) NSString *pic;
/** 活动名称 */
@property (nonatomic, strong) NSString *outname;
/** 活动原价 */
@property (nonatomic, strong) NSString *oldprice;
/** 活动现价 */
@property (nonatomic, strong) NSString *newprice;
/** 活动人数 */
@property (nonatomic, strong) NSString *personcount;
/** 活动开始时间 */
@property (nonatomic, strong) NSString *starttime;
/** 活动时间 */
@property (nonatomic, strong) NSString *outtime;


@end
