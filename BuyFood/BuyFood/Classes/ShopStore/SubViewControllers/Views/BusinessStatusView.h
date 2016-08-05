//
//  BusinessStatusView.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessStatusView : UIView

/** 营业时间 */
@property (nonatomic, strong) UIButton* businessTime;
/** 商家头像 */
@property (nonatomic, strong) UIImageView* businessHeaderImageView;

+ (instancetype)initBusinessStatusView;

- (void)creatHeaderContentView;

- (void)setBusinessStatus:(NSString* )businessStatus andBusinessTime:(NSString* )businessTime andBusinessStatusLabel:(NSString* )businessStatusLabel;

@end
