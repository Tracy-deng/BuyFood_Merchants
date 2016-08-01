//
//  ChangeHeaderImageParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/31.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeHeaderImageParams : NSObject

/** 注册时手机号 */
@property (nonatomic, strong) NSString *telephone;
/** 要修改的头像图片 */
@property (nonatomic, strong) NSString *pic;

@end
