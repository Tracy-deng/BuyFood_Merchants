//
//  MyBillHeaderView.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBillHeaderView : UIView
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIButton* allBtn;
@property (nonatomic, strong) UIButton* incomeBtn;
@property (nonatomic, strong) UIButton* spendingBtn;

+ (instancetype)initWithMyBillHeaderView;

- (void)setHeaderContentView;


@end
