//
//  ChangePasswordViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "InputTextField.h"
#import "Line.h"
#import "Button.h"
@interface ChangePasswordViewController ()

@property (nonatomic, strong) InputTextField* oldPassword;
@property (nonatomic, strong) InputTextField* passwordNew;
@property (nonatomic, strong) InputTextField* passwordNewAgian;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.title = @"修改密码";
    [self setContentView];
}

/** 设置内容视图 */
- (void)setContentView
{
    // 背景视图
    UIView* backGroundView = [[UIView alloc] initWithFrame:CGRectMake(2, 75, self.view.width - 4, self.view.height * 0.22)];
    backGroundView.backgroundColor = HDCColor(250, 250, 250);
    [self.view addSubview:backGroundView];
    // 原始密码
    self.oldPassword = [InputTextField inputTextField];
    [self.oldPassword createTextFieldPlaceholder:@"请输入注册手机号码" andinputIcon:@"icon_Lock - simple-line-icons"];
    [backGroundView addSubview:self.oldPassword];
    [self.oldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backGroundView.mas_top);
        make.left.mas_equalTo(backGroundView.mas_left).offset(10);
        make.width.mas_equalTo(backGroundView.mas_width).multipliedBy(0.95);
        make.height.mas_equalTo(backGroundView.mas_height).multipliedBy(0.33);
    }];
    // 分割线1
    Line* lineOne = [Line initLine];
    [lineOne createBackgroundColor:HDCColor(230, 230, 230)];
    [backGroundView addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldPassword.mas_bottom);
        make.left.mas_equalTo(backGroundView.mas_left).offset(10);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.94);
        make.height.mas_offset(@1);
    }];
    // 输入验证码
    self.passwordNew = [InputTextField inputTextField];
    [self.passwordNew createTextFieldPlaceholder:@"请输入验证码" andinputIcon:@"icon_Lock - simple-line-icons"];
    [backGroundView addSubview:self.passwordNew];
    [self.passwordNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineOne.mas_bottom);
        make.left.mas_equalTo(self.oldPassword);
        make.width.mas_equalTo(self.oldPassword).multipliedBy(0.75);
        make.height.mas_equalTo(self.oldPassword);
    }];
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self addButtonTouch:button font:14];
//    [button addTarget:self action:@selector(didRecive:) forControlEvents:(UIControlEventTouchUpInside)];
    [backGroundView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(lineOne.mas_bottom).offset(5);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.25);
        make.height.equalTo(@(backGroundView.height * 0.33 - 10));
    }];
    // 分割线2
    Line* lineTwo = [Line initLine];
    [lineTwo createBackgroundColor:HDCColor(230, 230, 230)];
    [backGroundView addSubview:lineTwo];
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordNew.mas_bottom);
        make.left.mas_equalTo(lineOne);
        make.width.mas_equalTo(lineOne);
        make.height.mas_equalTo(lineOne);
    }];
    // 确定新密码
    self.passwordNewAgian = [InputTextField inputTextField];
    [self.passwordNewAgian createTextFieldPlaceholder:@"请输入新密码" andinputIcon:@"icon_Lock - simple-line-icons"];
    [backGroundView addSubview:self.passwordNewAgian];
    [self.passwordNewAgian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineTwo.mas_bottom);
        make.left.mas_equalTo(self.oldPassword);
        make.width.mas_equalTo(self.oldPassword);
        make.height.mas_equalTo(self.oldPassword);
    }];
    // 确定按钮
    Button* surebutton = [Button initButton];
    [surebutton setButtonTitle:@"确定" andButtonX:self.view.width * 0.06 andButtonY:self.view.height * 0.65 andButtonHeight:self.view.height * 0.08 andButtonWidth:self.view.width * 0.89 andButtonNormalImage:nil andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:HDCColor(255, 255, 255)];
    [surebutton setBackgroundColor:HDCColor(35, 192, 58)];
    surebutton.layer.cornerRadius = 5;
    surebutton.layer.masksToBounds = YES;
    [self.view addSubview:surebutton];
}
// 封装button属性
- (void)addButtonTouch:(UIButton *)sender font:(NSInteger)font
{
    sender.titleLabel.font = [UIFont systemFontOfSize:font];
    
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    sender.backgroundColor = greenColor;
    
    sender.layer.masksToBounds = YES;
    
    sender.layer.cornerRadius = 2;
}

@end
