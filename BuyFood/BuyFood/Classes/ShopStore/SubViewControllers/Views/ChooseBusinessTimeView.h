//
//  ChooseBusinessTimeView.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseBusinessTimeView : UIView

/** 营业时间 */
@property (nonatomic, strong) UIButton* businessTime;

+ (instancetype)initChooseBusinessTimeView;

- (void)creatChooseBusinessTimeView;

- (void)setTimeLabelText:(NSString* )timeLabelText andBusinessTimeTitle:(NSString* )businessTimeTitle;

@end
