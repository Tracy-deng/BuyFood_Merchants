//
//  AddBankCardViewController.m
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "AddView.h"
#import "WB_Stopwatch.h"

@interface AddBankCardViewController ()<WB_StopWatchDelegate>
{
    WB_Stopwatch * stopWatchLabel;
}

@property (nonatomic, strong) AddView* nameView;
@property (nonatomic, strong) AddView* cardNumber;
@property (nonatomic, strong) AddView* phoneNumber;
/** 显示时间Label */
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UIButton* sendCodeBtn;


@end

@implementation AddBankCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1]];
    self.title = @"添加银行卡";
    [self createAddView];
    [self setAddBtn];
}

- (void)createAddView
{
    self.nameView = [AddView initAddView];
    [self.nameView setUpContentView];
    [self.nameView setTitleLabelText:@"姓名" andTextFieldPlaceholder:@"请输入姓名" andTextFieldText:@"王尼玛"];
    [self.nameView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(75);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.09);
    }];
    
    self.cardNumber = [AddView initAddView];
    [self.cardNumber setUpContentView];
    [self.cardNumber setTitleLabelText:@"卡号" andTextFieldPlaceholder:@"请输入银行卡卡号" andTextFieldText:@"12242435346436457"];
    [self.cardNumber setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.cardNumber];
    [self.cardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.nameView.mas_bottom);
        make.width.equalTo(self.nameView);
        make.height.mas_equalTo(self.nameView);
    }];
    
    self.phoneNumber = [AddView initAddView];
    [self.phoneNumber setUpContentView];
    self.phoneNumber.line.hidden = YES;
    [self.phoneNumber setTitleLabelText:@"手机号" andTextFieldPlaceholder:@"请输入银行预留手机号码" andTextFieldText:@"刘小波手机号码"];
    [self.phoneNumber setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.phoneNumber];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.cardNumber.mas_bottom);
        make.width.equalTo(self.nameView);
        make.height.mas_equalTo(self.nameView);
    }];
    
    UIView* codeView = [[UIView alloc] init];
    codeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.phoneNumber.mas_bottom).offset(40);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.09);
    }];
    
    UITextField* textField = [[UITextField alloc] init];
    textField.placeholder = @"请输入验证码";
    textField.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    textField.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [codeView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeView.mas_left).offset(30);
        make.centerY.mas_equalTo(codeView.mas_centerY);
        make.width.equalTo(@(150));
        make.height.equalTo(@(30));
    }];
    self.sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:[UIColor colorWithRed:11 / 255.0  green:180 / 255.0  blue:235 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.sendCodeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.sendCodeBtn addTarget:self action:@selector(sendCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendCodeBtn setBackgroundColor:[UIColor clearColor]];
    [codeView addSubview:self.sendCodeBtn];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(codeView.mas_right).offset(-20);
        make.centerY.mas_equalTo(codeView.mas_centerY);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    
    self.timeLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(SCREEN_WIDTH - 20 - 100, 10, 100, 30)
    self.timeLabel.hidden = YES;
    [codeView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(codeView.mas_right).offset(-20);
        make.centerY.mas_equalTo(codeView.mas_centerY);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    stopWatchLabel = [[WB_Stopwatch alloc]initWithLabel:self.timeLabel andTimerType:WBTypeTimer];
    stopWatchLabel.delegate = self;
    [stopWatchLabel setTimeFormat:@"ss"];
    [stopWatchLabel setCountDownTime:60];//多少秒 （1分钟 == 60秒）
    stopWatchLabel.hidden = YES;
}

- (void)sendCodeBtnClick:(UIButton* )sender
{
    sender.hidden = YES;
    self.timeLabel.hidden = NO;
    [stopWatchLabel start];
}
/** 时间走完了 */
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    self.sendCodeBtn.hidden = NO;
    self.timeLabel.hidden = YES;
}

- (void)setAddBtn
{
    UIButton* addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"立即添加" forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 3.0;
    [addBtn setBackgroundColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1]];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(21);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
        make.width.equalTo(@(SCREEN_WIDTH - 2 * 21));
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
}


@end
