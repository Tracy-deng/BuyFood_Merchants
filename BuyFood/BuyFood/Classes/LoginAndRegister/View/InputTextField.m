//
//  InputTextField.m
//  云洗盟
//
//  Created by 黄栋春 on 16/6/7.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "InputTextField.h"

@implementation InputTextField

+ (instancetype)inputTextField
{
    return [[self alloc] init];
}

- (void)createTextFieldPlaceholder:(NSString *)placeholder andinputIcon:(NSString *)inputIconImageName
{
    self.placeholder = placeholder;
    UIView* leftViews = [[UIView alloc] init];
    leftViews.width = 60;
    leftViews.height = 30;
    UIImageView *inputIcon = [[UIImageView alloc] init];
    inputIcon.image = [UIImage imageNamed:inputIconImageName];
    inputIcon.x = 8;
    inputIcon.y = 5;
    inputIcon.width = 15;
    inputIcon.height = 20;
    [leftViews addSubview:inputIcon];
    leftViews.contentMode = UIViewContentModeCenter;
    self.leftView = leftViews;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
