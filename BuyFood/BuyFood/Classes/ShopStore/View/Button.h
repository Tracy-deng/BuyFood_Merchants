//
//  Button.h
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button : UIButton

/** 初始button */
+ (instancetype)initButton;
/** 设置button*/
- (void)setButtonTitle:(NSString* )title andButtonX:(CGFloat)x andButtonY:(CGFloat)y andButtonHeight:(CGFloat)height andButtonWidth:(CGFloat)width andButtonNormalImage:(UIImage* )normalImage andSelectedImage:(UIImage* )selectedImage andButtonbackGroundImage:(UIImage* )backGroundImage andButtonTitleTextColor:(UIColor* )color;

@end
