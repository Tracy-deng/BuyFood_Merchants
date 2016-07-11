//
//  GoodsViewController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UpLoadImageUtil : NSObject

/*
 **方法.参数parms 可是单个图片也可以是图片数组
*/

+ (void )upLoadImage:(id )parms
             success:(void (^)(id response))success
             failure:(void (^)())failure;

@end
