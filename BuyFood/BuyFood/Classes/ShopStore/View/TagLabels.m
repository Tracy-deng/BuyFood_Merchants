//
//  TagLabels.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "TagLabels.h"

@implementation TagLabels


/** 初始化标签Label */
+ (instancetype)initTaglabel
{
    return [[self alloc] init];
}
/** 设置输入框内容 */
- (void)createLabelText:(NSString* )text andLabelX:(CGFloat)x andLabelY:(CGFloat)y andLabelHeight:(CGFloat)height andLabelWidth:(CGFloat)width andLabelTextStytle:(NSString* )textStytle andLabelFontsize:(CGFloat)fontsize andtextColor:(UIColor* )textColor
{
    self.textAlignment = NSTextAlignmentCenter;
    self.x = x;
    self.y = y;
    self.height = height;
    self.width = width;
    self.text = text;
    self.textColor = textColor;
    self.font = [UIFont fontWithName:textStytle size:fontsize];
}

@end
