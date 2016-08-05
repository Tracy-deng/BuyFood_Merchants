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
#import "ChangePwdParams.h"
#import "RequestTool.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"
#import "MBProgressHUD.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

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
    self.oldPassword.secureTextEntry = YES;
    self.oldPassword.delegate = self;
    [self.oldPassword createTextFieldPlaceholder:@"请输入旧密码" andinputIcon:@"icon_Lock - simple-line-icons"];
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
    // 输入新密码
    self.passwordNew = [InputTextField inputTextField];
    self.passwordNew.secureTextEntry = YES;
    self.passwordNew.delegate = self;
    [self.passwordNew createTextFieldPlaceholder:@"请输入新密码" andinputIcon:@"icon_Lock - simple-line-icons"];
    [backGroundView addSubview:self.passwordNew];
    [self.passwordNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineOne.mas_bottom);
        make.left.mas_equalTo(self.oldPassword);
        make.width.mas_equalTo(self.oldPassword).multipliedBy(0.75);
        make.height.mas_equalTo(self.oldPassword);
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
    self.passwordNewAgian.secureTextEntry = YES;
    self.passwordNewAgian.delegate = self;
    [self.passwordNewAgian createTextFieldPlaceholder:@"请再次输入新密码" andinputIcon:@"icon_Lock - simple-line-icons"];
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
    [surebutton addTarget:self action:@selector(surebuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:surebutton];
}

- (void)surebuttonClick:(UIButton *)sender
{
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    ChangePwdParams *params = [[ChangePwdParams alloc] init];
    params.telephone = userInfo.telephone;
    params.pswd = self.oldPassword.text;
    params.newpswd = self.passwordNew.text;
    
    
    if (self.passwordNew.text.length == 0 || self.oldPassword.text.length == 0 || self.passwordNewAgian.text.length == 0)
    {
        UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"请注意 !!!" message:@"请完整输入需要修改信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [selct addAction:action];
        [self presentViewController:selct animated:YES completion:nil];
        return;
    }
    if (![self.passwordNew.text isEqualToString:self.passwordNewAgian.text])
    {
        UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"请注意 !!!" message:@"两次新密码先写不一致" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [selct addAction:action];
        [self presentViewController:selct animated:YES completion:nil];
        return;
    }
    else
    {
        [RequestTool changePwd:params success:^(ResultsModel *result)
        {
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                [MBProgressHUD showSuccess:@"修改密码成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            ;
        }];
     }
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

// 点击屏幕空白  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
