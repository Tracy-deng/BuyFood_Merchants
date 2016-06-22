//
//  HeaderViews.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViews : UIView

@property (nonatomic, strong) UILabel* withdrawMoney;
@property (nonatomic, strong) UIButton* withdrawMoneyBtn;


+ (instancetype)initWithHeaderViews;

- (void)setUpContentView;
@end
