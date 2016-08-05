//
//  PricingGuidanceModel.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PricingGuidanceModel : NSObject
/** 均价 */
@property (nonatomic, strong) NSString *avgprice;
/** 采购价 */
@property (nonatomic, strong) NSString *inprice;
/** 名称 */
@property (nonatomic, strong) NSString *productname;

@end
