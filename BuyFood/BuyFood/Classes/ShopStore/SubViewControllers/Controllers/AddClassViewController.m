//
//  AddClassViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddClassViewController.h"

@interface AddClassViewController ()

@property (nonatomic, strong) UITextField *inputTextField;


@end

@implementation AddClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"添加分类";
    [self createTextField];
}

- (void)createTextField
{
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.placeholder = @"请输入品类";
    [self.view addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@(45));
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = HDCColor(224, 224, 224);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTextField);
        make.top.equalTo(self.inputTextField.mas_bottom);
        make.width.equalTo(self.inputTextField);
        make.height.equalTo(@(1));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundColor:greenColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(45));
    }];
}



@end
