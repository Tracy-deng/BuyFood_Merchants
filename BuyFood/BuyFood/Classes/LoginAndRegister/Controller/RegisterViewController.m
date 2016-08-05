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
#import "RequestTool.h"
#import "RegisterParams.h"
#import "ResultsModel.h"
#import "CommonShopsRegisterViewController.h"
#import "BrandShopRegisterViewController.h"
#import "CommunityShopRegisterViewController.h"
#import "LoginParams.h"
#import "GetMsgCodeParams.h"

static NSInteger selectNum;

@interface RegisterViewController ()<UITextFieldDelegate>
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
{
    UIButton * button;
}
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
    _recive.clearButtonMode = UITextFieldViewModeNever;
    button = [[UIButton alloc] init];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self addButtonTouch:button font:14];
    [button addTarget:self action:@selector(didRecive:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backGround addSubview:_recive];
    [self.view addSubview:button];
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
    _passWordTF.delegate = self;
    _passWordTF.secureTextEntry = YES;
    [self.backGround addSubview:_passWordTF];
    UIButton * passBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [passBtn setTitle:@"显示密码" forState:UIControlStateNormal ];
    [self addButtonTouch:passBtn font:14];
    [passBtn addTarget:self action:@selector(didPassWord:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:passBtn];
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
    
    [self popNumberKeyBoard];
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
    
    
    _hotBtn = [CCLickButton ButtonWithName:@"社区店" imageView:@"select"];
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
    
    
    
    _comBtn = [CCLickButton ButtonWithName:@"品牌馆" imageView:@"select"];
    [_comBtn addTouchBlock:^(CCLickButton *sender) {
        
        
        [sender setSelected:YES imageView:@"choose"];
        [weakSelf.hotBtn setSelected:NO imageView:@"select"];
        [weakSelf.shopBtn setSelected:NO imageView:@"select"];
        selectNum = 3;
        
    }];
    [self.secondView addSubview:_comBtn];
    
    [_comBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopBtn);
        make.top.mas_equalTo(_hotBtn.mas_bottom);
        make.width.equalTo(_shopBtn);
        make.height.equalTo(_shopBtn);
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    sureButton.frame = CGRectMake(0.17*SCREEN_WIDTH,SCREEN_HEIGHT - 100, 0.66*SCREEN_WIDTH, 50);
    
    [sureButton setTitle:@"下一步" forState:UIControlStateNormal ];
    [sureButton addTarget:self action:@selector(didSureBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self addButtonTouch:sureButton font:20];
    sureButton.layer.masksToBounds = YES;
    
    sureButton.layer.cornerRadius = 5;
    [self.view addSubview:sureButton];
}
- (void)didRecive:(UIButton *)sender
{
    NSLog(@"点击获取验证码");
    button.userInteractionEnabled = NO;
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1+[3578]+\\d{9}"] evaluateWithObject:self.textfield.text])
    {
        [MBProgressHUD showSuccess:@"请输入正确的的手机号码"];
    }
    else
    {
        GetMsgCodeParams* params = [[GetMsgCodeParams alloc]init];
        params.telphone = _textfield.text;
        [RequestTool getSMSCode:params success:^(ResultsModel *result) {
            
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                [MBProgressHUD showSuccess:@"验证码已发送"];
                [self startTime];
            }
            else
            {
                [MBProgressHUD showError:result.ErrorMsg];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
}


-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [ button setTitle:@"发送验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [button setTitle:[NSString stringWithFormat:@"%@秒后重试",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}


- (void)didPassWord:(UIButton *)sender
{
    NSLog(@"点击显示密码");
    _passWordTF.secureTextEntry = !_passWordTF.secureTextEntry;
}

-(void)didSureBtn:(UIButton *)sender
{
    // 通过点击的 selectNum 的数字来判断 提交哪个
    if (selectNum == 1)
    {
        RegisterParams* params = [[RegisterParams alloc]init];
        params.telephone = _textfield.text;
        params.verifycode = _recive.text;
        params.pswd = _passWordTF.text;
        params.markettypeid = @"1";
        [RequestTool registe:params success:^(ResultsModel *result) {
            
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                LoginParams* loginParams = [[LoginParams alloc]init];
                loginParams.telephone = _textfield.text;
                loginParams.pswd = _passWordTF.text;
                [RequestTool login:loginParams success:^(ResultsModel *result)
                 {
                     HDCLog(@"%@", result.ModelList[0]);
                     CommonShopsRegisterViewController* ordinaryBusinessRegisterVC = [[CommonShopsRegisterViewController alloc] init];
                     ordinaryBusinessRegisterVC.marketuserid = result.ModelList[0][@"marketuserid"];
                     [self.navigationController pushViewController:ordinaryBusinessRegisterVC animated:YES];
                 } failure:^(NSError *error) {
                     ;
                 }];
                
            }
            [MBProgressHUD showSuccess:result.ErrorMsg];
            
        } failure:^(NSError *error) {
            ;
        }];
    }
    else if (selectNum == 2)
    {
        RegisterParams* params = [[RegisterParams alloc]init];
        params.telephone = _textfield.text;
        params.verifycode = _recive.text;
        params.pswd = _passWordTF.text;
        params.markettypeid = @"2";
        [RequestTool registe:params success:^(ResultsModel *result) {
            
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                LoginParams* loginParams = [[LoginParams alloc]init];
                loginParams.telephone = _textfield.text;
                loginParams.pswd = _passWordTF.text;
                [RequestTool login:loginParams success:^(ResultsModel *result)
                 {
                     HDCLog(@"%@", result.ModelList[0]);
                     CommunityShopRegisterViewController* communityShopRegisterVC = [[CommunityShopRegisterViewController alloc] init];
                     communityShopRegisterVC.marketuserid = result.ModelList[0][@"marketuserid"];
                     [self.navigationController pushViewController:communityShopRegisterVC animated:YES];
                 } failure:^(NSError *error) {
                     ;
                 }];
            }
            [MBProgressHUD showSuccess:result.ErrorMsg];
            
        } failure:^(NSError *error) {
            ;
        }];
    }
    else
    {
        RegisterParams* params = [[RegisterParams alloc]init];
        params.telephone = _textfield.text;
        params.verifycode = _recive.text;
        params.pswd = _passWordTF.text;
        params.markettypeid = @"3";
        [RequestTool registe:params success:^(ResultsModel *result) {
            
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                LoginParams* loginParams = [[LoginParams alloc]init];
                loginParams.telephone = _textfield.text;
                loginParams.pswd = _passWordTF.text;
                [RequestTool login:loginParams success:^(ResultsModel *result)
                 {
                     HDCLog(@"%@", result.ModelList[0]);
                     BrandShopRegisterViewController* brandShopRegisterVC = [[BrandShopRegisterViewController alloc] init];
                     brandShopRegisterVC.marketuserid = result.ModelList[0][@"marketuserid"];
                     [self.navigationController pushViewController:brandShopRegisterVC animated:YES];
                 } failure:^(NSError *error) {
                     ;
                 }];
            }
            [MBProgressHUD showSuccess:result.ErrorMsg];
            
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
/** 点击空白处收起键盘 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textfield resignFirstResponder];
    [_passWordTF resignFirstResponder];
    [_recive resignFirstResponder];
}
/** 弹出数字键盘 */
- (void)popNumberKeyBoard
{
    _textfield.keyboardType = UIKeyboardTypeNumberPad;
    _recive.keyboardType = UIKeyboardTypeNumberPad;
    _passWordTF.returnKeyType = UIReturnKeyDone;
}

#pragma mark --- UITextFieldDelegate 回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _passWordTF)
    {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
