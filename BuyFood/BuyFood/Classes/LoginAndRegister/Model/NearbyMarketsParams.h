//
//  NearbyMarketsParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/10.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyMarketsParams : NSObject

@property (nonatomic, strong) NSString *pageindex;
@property (nonatomic, strong) NSString *pagesize;
@property (nonatomic, strong) NSString *ismarket;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *markettypeid;
@property (nonatomic, assign) CGFloat lon;
@property (nonatomic, assign) CGFloat lat;

@end
