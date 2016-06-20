//
//  Line.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "Line.h"

@implementation Line

+ (instancetype)initLine
{
    return [[self alloc] init];
}
/** 设置分割线样式 */
- (void)createLineX:(CGFloat)x andLineY:(CGFloat)y andLineHeight:(CGFloat)height andLineWidth:(CGFloat)width andBackgroundColor:(UIColor* )backgroundColor
{
    self.x = x;
    self.y = y;
    self.height = height;
    self.width = width;
    self.backgroundColor = backgroundColor;
}
- (void)createBackgroundColor:(UIColor* )backgroundColor
{
    self.backgroundColor = backgroundColor;
}

@end
