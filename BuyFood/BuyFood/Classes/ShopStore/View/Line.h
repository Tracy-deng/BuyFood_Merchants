//
//  Line.h
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line : UILabel

/** 初始分割线 */
+ (instancetype)initLine;
/** 设置分割线样式 */
- (void)createLineX:(CGFloat)x andLineY:(CGFloat)y andLineHeight:(CGFloat)height andLineWidth:(CGFloat)width andBackgroundColor:(UIColor* )backgroundColor;
- (void)createBackgroundColor:(UIColor* )backgroundColor;

@end
