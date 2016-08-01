//
//  FeedBackParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/31.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackParams : NSObject

/** 商户id */
@property (nonatomic, strong) NSString *userid;
/** 回复用户类别 1,用户 2.商户 3.骑士 */
@property (nonatomic, strong) NSString *usertype;
/** 回复内容 */
@property (nonatomic, strong) NSString *remark;

@end
