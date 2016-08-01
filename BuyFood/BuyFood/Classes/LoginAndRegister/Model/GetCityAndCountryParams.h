//
//  GetCityAndCountryParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/31.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCityAndCountryParams : NSObject

/** 省 */
@property (nonatomic, strong) NSString *province;
/** 区/县 */
@property (nonatomic, strong) NSString *city;

@end
