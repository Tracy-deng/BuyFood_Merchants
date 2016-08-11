//
//  AddOutDoorParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/9.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddOutDoorParams : NSObject

/** 户外活动名称 */
@property (nonatomic, strong) NSString *outname;
/** 活动原价 */
@property (nonatomic, assign) double oldprice;
/** 活动促销价 */
@property (nonatomic, assign) double newprice;
/** 人数限制。即活动总共参与人数上限 */
@property (nonatomic, assign) NSInteger personcount;
/** 活动时间 */
@property (nonatomic, strong) NSString *outtime;
/** 活动图片（缩略图）*/
@property (nonatomic, strong) NSString *pic;
/** 预期自动退 */
@property (nonatomic, strong) NSString *remark1;
/** 随时退 */
@property (nonatomic, strong) NSString *remark2;
/** 开始时间 */
@property (nonatomic, strong) NSString *starttime;
/** 结束时间 */
@property (nonatomic, strong) NSString *endtime;
/** 试用规则-交通 */
@property (nonatomic, strong) NSString *rule1;
/** 试用规则-住宿 */
@property (nonatomic, strong) NSString *rule2;
/** 试用规则-用餐 */
@property (nonatomic, strong) NSString *rule3;
/** 试用规则-门票 */
@property (nonatomic, strong) NSString *rule4;
/** 试用规则-其他 */
@property (nonatomic, strong) NSString *rule5;
/** 商家ID */
@property (nonatomic, strong) NSString *marketuserid;
/** 活动描述。如风景优美，陶冶情操 */
@property (nonatomic, strong) NSString *remark;
/** 活动地点。如仙鹤门 */
@property (nonatomic, strong) NSString *outaddress;
/** 户外活动图片列表 */
@property (nonatomic, strong) NSMutableArray *ProductPictureList;

@end
