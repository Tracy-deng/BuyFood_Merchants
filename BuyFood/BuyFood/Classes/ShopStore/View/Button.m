//
//  Button.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "Button.h"

@implementation Button

/** 初始button */
+ (instancetype)initButton
{
    return [[self alloc] init];
}
/** 设置button*/
- (void)setButtonTitle:(NSString* )title andButtonX:(CGFloat)x andButtonY:(CGFloat)y andButtonHeight:(CGFloat)height andButtonWidth:(CGFloat)width andButtonNormalImage:(UIImage* )normalImage andSelectedImage:(UIImage* )selectedImage andButtonbackGroundImage:(UIImage* )backGroundImage andButtonTitleTextColor:(UIColor* )color;
{
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:backGroundImage forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
}



@end
