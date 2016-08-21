//
//  BusinessStatusParams.h
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/5.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessStatusParams : NSObject

/** 营业状态。1-正常营业；2-暂停营业；3-停业整改; 4-自动接单 */
@property (nonatomic, strong) NSString *status;
/** 商家id */
@property (nonatomic, strong) NSString *marketuserid;


@end
