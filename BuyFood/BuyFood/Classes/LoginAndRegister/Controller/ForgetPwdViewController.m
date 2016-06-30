//
//  ForgetPwdViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "CCTextField.h"

@interface ForgetPwdViewController ()
@property (nonatomic, strong) UIView* oneView;

@property (nonatomic, strong) CCTextField *phoneTx;
@property (nonatomic, strong) CCTextField *codeTx;
@property (nonatomic, strong) CCTextField *passWordTx;
@property (nonatomic, strong) CCTextField* againPassWordTx;


@end

@implementation ForgetPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = HDCBackViewColor;
    [self setNavLeftBtn];
    [self setUpOneView];
}
/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"忘记密码";
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"icon_left_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* laftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = laftBarItem;
}
/** 返回按钮 */
- (void)backBtnClick:(UIButton* )sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpOneView
{
    self.oneView = [[UIView alloc]init];
    self.oneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.oneView];
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.28);
    }];
    /**
     *  获取手机号
     */
    self.phoneTx = [CCTextField textFiledWithName:@"请输入手机号码" UIimageView:@"data" ];
    [self.oneView addSubview:self.phoneTx];
    [self.phoneTx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oneView.mas_left).offset(10);
        make.top.equalTo(self.oneView.mas_top);
        make.width.equalTo(self.oneView.mas_width).multipliedBy(0.95);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.07);
    }];
    /**
     *  获取验证码
     */
    self.codeTx = [CCTextField textFiledWithName:@"请输入验证码" UIimageView:@"write"];
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self addButtonTouch:button font:14];
    [button addTarget:self action:@selector(didRecive:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.oneView addSubview:self.codeTx];
    [self.codeTx addSubview:button];
    [self.codeTx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTx);
        make.top.equalTo(self.phoneTx.mas_bottom);
        make.width.equalTo(self.phoneTx);
        make.height.equalTo(self.phoneTx);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.codeTx.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.codeTx.mas_centerY);
        make.width.equalTo(@(80));
        make.height.equalTo(@(30));
    }];
    
    /**
     输入密码
     */
    self.passWordTx = [CCTextField textFiledWithName:@"请输入密码" UIimageView:@"account"];
    [self.oneView addSubview:self.passWordTx];
    [self.passWordTx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneTx);
        make.top.equalTo(_codeTx.mas_bottom);
        make.width.equalTo(_phoneTx);
        make.height.equalTo(_phoneTx);
    }];
    
    /**
     输入密码
     */
    self.againPassWordTx = [CCTextField textFiledWithName:@"请再次输入密码" UIimageView:@"account"];
    [self.oneView addSubview:self.againPassWordTx];
    [self.againPassWordTx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneTx);
        make.top.equalTo(_passWordTx.mas_bottom);
        make.width.equalTo(_phoneTx);
        make.height.equalTo(_phoneTx);
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    sureButton.frame = CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT - 100, 0.66*SCREEN_WIDTH, 50);
    
    [sureButton setTitle:@"确认" forState:UIControlStateNormal ];
    [sureButton addTarget:self action:@selector(didSureBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addButtonTouch:sureButton font:20];
    sureButton.layer.masksToBounds = YES;
    
    sureButton.layer.cornerRadius = 5;
    [self.view addSubview:sureButton];
}

- (void)didRecive:(UIButton *)sender
{
    NSLog(@"点击获取验证码");
}

-(void)didSureBtn:(UIButton *)sender
{
    NSLog(@"确认///");
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
