//
//  TagLabels.h
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagLabels : UILabel

/** 初始化标签Label */
+ (instancetype)initTaglabel;
/** 设置输入框内容 */
- (void)createLabelText:(NSString* )text andLabelX:(CGFloat)x andLabelY:(CGFloat)y andLabelHeight:(CGFloat)height andLabelWidth:(CGFloat)width andLabelTextStytle:(NSString* )textStytle andLabelFontsize:(CGFloat)fontsize andtextColor:(UIColor* )textColor;

@end
