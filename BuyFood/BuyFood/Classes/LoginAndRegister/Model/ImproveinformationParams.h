//
//  ImproveinformationParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/11.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImproveinformationParams : NSObject

/** 商家ID */
@property (nonatomic, strong) NSString* marketuserid;
/** 店铺名称 */
@property (nonatomic, strong) NSString* marketname;
/** 固定电话 */
@property (nonatomic, strong) NSString* telephone2;
/** 详细地址 */
@property (nonatomic, strong) NSString* detailaddress;
/** 属于哪个菜场ID */
@property (nonatomic, strong) NSString* marketsubid;
/** 属于哪个菜场（名字）*/
@property (nonatomic, strong) NSString* marketsubname;
/** 商品类别ID,标志该店家卖啥 */
@property (nonatomic, strong) NSString* categoryid;
/** 店铺图片 */
@property (nonatomic, strong) NSString* pic;
/** 省 */
@property (nonatomic, strong) NSString *province;
/** 市 */
@property (nonatomic, strong) NSString *city;
/** 县 / 区  */
@property (nonatomic, strong) NSString *country;
/** 经度 */
@property (nonatomic, assign) CGFloat lon;
/** 纬度 */
@property (nonatomic, assign) CGFloat lat;


@end
