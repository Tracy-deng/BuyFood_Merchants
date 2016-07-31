//
//  JADEMethods.m
//  JadeMicro_chat
//
//  Created by bwfstu on 16/5/20.
//  Copyright © 2016年 bwfstu. All rights reserved.
//

#import "JADEMethods.h"

@implementation JADEMethods

#pragma mark --自动获取label 的高度
+(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
@end
