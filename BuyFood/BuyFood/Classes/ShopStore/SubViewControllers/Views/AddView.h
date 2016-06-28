//
//  AddView.h
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddView : UIView

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) UILabel* line;

+ (instancetype)initAddView;

- (void)setUpContentView;

- (void)setTitleLabelText:(NSString* )titleText andTextFieldPlaceholder:(NSString* )placeholder andTextFieldText:(NSString* )textFieldText;


@end
