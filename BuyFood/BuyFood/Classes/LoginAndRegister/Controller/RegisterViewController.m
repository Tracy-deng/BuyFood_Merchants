//
//  RegisterViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "RegisterViewController.h"
#import "CCTextField.h"
#import "CCLickButton.h"
#import "RealnameViewController.h"

static NSInteger selectNum;

@interface RegisterViewController ()
@property (nonatomic, strong) CCTextField *textfield;
@property (nonatomic, strong) CCTextField *recive;
@property (nonatomic, strong) CCTextField *passWordTF;
@property (nonatomic, strong) CCLickButton *shopBtn;
@property (nonatomic, strong) CCLickButton * hotBtn;
@property (nonatomic, strong) CCLickButton * comBtn;
@property (nonatomic, strong) UIView *backGround;
@property (nonatomic, strong) UIView *secondView;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    [self setNavLeftBtn];
    [self setUpOneView];
    [self setUpSecondView];

}

/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"注册";
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
    self.backGround = [[UIView alloc]init];
    self.backGround.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backGround];
    [self.backGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.21);
    }];
    /**
     *  获取手机号
     */
    _textfield= [CCTextField textFiledWithName:@"请输入手机号码" UIimageView:@"data" ];
    [self.backGround addSubview:_textfield];
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGround.mas_left).offset(10);
        make.top.equalTo(self.backGround.mas_top);
        make.width.equalTo(self.backGround.mas_width).multipliedBy(0.95);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.07);
    }];
    /**
     *  获取验证码
     */
    _recive = [CCTextField textFiledWithName:@"请输入验证码" UIimageView:@"write"];
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self addButtonTouch:button font:14];
    [button addTarget:self action:@selector(didRecive:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backGround addSubview:_recive];
    [_recive addSubview:button];
    [_recive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textfield);
        make.top.equalTo(_textfield.mas_bottom);
        make.width.equalTo(_textfield);
        make.height.equalTo(_textfield);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_recive.mas_right).offset(-10);
        make.centerY.mas_equalTo(_recive.mas_centerY);
        make.width.equalTo(@(80));
        make.height.equalTo(@(30));
    }];
    
    /**
     输入密码
     */
    _passWordTF = [CCTextField textFiledWithName:@"请输入密码" UIimageView:@"account"];
    [self.backGround addSubview:_passWordTF];
    UIButton * passBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [passBtn setTitle:@"显示密码" forState:UIControlStateNormal ];
    [self addButtonTouch:passBtn font:14];
    [passBtn addTarget:self action:@selector(didPassWord:) forControlEvents:(UIControlEventTouchUpInside)];
    [_passWordTF addSubview:passBtn];
    [_passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textfield);
        make.top.equalTo(_recive.mas_bottom);
        make.width.equalTo(_textfield);
        make.height.equalTo(_textfield);
    }];
    [passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_passWordTF.mas_right).offset(-10);
        make.centerY.mas_equalTo(_passWordTF.mas_centerY);
        make.width.equalTo(@(80));
        make.height.equalTo(@(30));
    }];
}

- (void)setUpSecondView
{
    self.secondView = [UIView new];
    self.secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.secondView];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.backGround.mas_bottom).offset(20);
        make.width.equalTo(self.view);
        make.height.equalTo(self.backGround);
    }];
    __weak typeof (self)weakSelf = self;
#pragma mark -- 设置选择
    _shopBtn = [CCLickButton ButtonWithName:@"普通商家" imageView:@"select"];
    [_shopBtn addTouchBlock:^(CCLickButton *sender) {
        
        [sender setSelected:YES imageView:@"choose"];
        [weakSelf.hotBtn setSelected:NO imageView:@"select"];
        [weakSelf.comBtn setSelected:NO imageView:@"select"];
        
        selectNum = 1;
    }];
    [self.secondView addSubview:_shopBtn];
    [_shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         self.frame = CGRectMake(10, y, 20, 20);
         */
        make.left.mas_equalTo(self.secondView.mas_left).offset(10);
        make.top.equalTo(self.secondView.mas_top);
        make.width.equalTo(self.secondView.mas_width).multipliedBy(0.95);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.07);
        //        make.width.equalTo(@(20));
        //        make.height.equalTo(@(20));
    }];
    
    
    _hotBtn = [CCLickButton ButtonWithName:@"品牌馆" imageView:@"select"];
    [_hotBtn addTouchBlock:^(CCLickButton *sender) {
        
        
        [sender setSelected:YES imageView:@"choose"];
        [weakSelf.shopBtn setSelected:NO imageView:@"select"];
        [weakSelf.comBtn setSelected:NO imageView:@"select"];
        selectNum = 2;
        
    }];
    [self.secondView addSubview:_hotBtn];
    [_hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         self.frame = CGRectMake(10, y, 20, 20);
         */
        make.left.equalTo(_shopBtn);
        make.top.mas_equalTo(_shopBtn.mas_bottom);
        make.width.equalTo(_shopBtn);
        make.height.equalTo(_shopBtn);
    }];
    
    
    
    _comBtn = [CCLickButton ButtonWithName:@"社区店" imageView:@"select"];
    [_comBtn addTouchBlock:^(CCLickButton *sender) {
        
        
        [sender setSelected:YES imageView:@"choose"];
        [weakSelf.hotBtn setSelected:NO imageView:@"select"];
        [weakSelf.shopBtn setSelected:NO imageView:@"select"];
        selectNum = 3;
        
    }];
    [self.secondView addSubview:_comBtn];
    
    [_comBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         self.frame = CGRectMake(10, y, 20, 20);
         */
        make.left.equalTo(_shopBtn);
        make.top.mas_equalTo(_hotBtn.mas_bottom);
        make.width.equalTo(_shopBtn);
        make.height.equalTo(_shopBtn);
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    sureButton.frame = CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT - 100, 0.66*SCREEN_WIDTH, 50);
    
    [sureButton setTitle:@"确认注册" forState:UIControlStateNormal ];
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

- (void)didPassWord:(UIButton *)sender
{
    NSLog(@"点击显示密码");
    
}

-(void)didSureBtn:(UIButton *)sender
{
    // 通过点击的 selectNum 的数字来判断 提交哪个
    [self.navigationController pushViewController:[[RealnameViewController alloc] init] animated:YES];
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
