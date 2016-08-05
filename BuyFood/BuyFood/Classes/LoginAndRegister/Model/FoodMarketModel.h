//
//  FoodMarketModel.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/10.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodMarketModel : NSObject

/** 菜场详细地址 */
@property (nonatomic, strong) NSString* detailaddress;
/** 菜场名称 */
@property (nonatomic, strong) NSString* marketname;
///** */
//@property (nonatomic, strong) NSString* markettypename;
/** 菜场经度 */
@property (nonatomic, strong) NSString *lon;
/** 菜场纬度 */
@property (nonatomic, strong) NSString *lat;


@end
