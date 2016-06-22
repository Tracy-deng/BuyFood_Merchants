//
//  FooterView.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UIView

+ (instancetype)initWithFooterView;

- (void)setUpContentView;

- (void)setUpMoneyLabel:(NSString* )money andOrderNumberLabel:(NSString* )orderNumber;

@end
