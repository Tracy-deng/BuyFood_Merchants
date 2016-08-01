//
//  ProvinceAndCityAndCountryModelList.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceAndCityAndCountryModelList : NSObject

/** 省 */
@property (nonatomic, strong) NSString *province;
/** 市 */
@property (nonatomic, strong) NSString *city;
/** 区/县 */
@property (nonatomic, strong) NSString *country;

@end
