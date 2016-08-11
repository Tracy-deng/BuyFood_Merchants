//
//  LoginViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "LoginViewController.h"
#import "InputTextField.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "HDCTabBarViewController.h"
#import "RequestTool.h"
#import "LoginParams.h"
#import "ResultsModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "MJExtension.h"

#import "CommonShopsRegisterViewController.h"
#import "CommunityShopRegisterViewController.h"
#import "BrandShopRegisterViewController.h"
#import "RealnameViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) InputTextField* phoneTextField;
@property (nonatomic, strong) InputTextField* passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationStyle];
    [self setPhoneInputTextFieldAndPasswordTextField];
    [self setBtn];
}
/** 设置导航条样式 */
- (void)setUpNavigationStyle
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = HDCColor(46, 192, 70);
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"登录";
}
/** 设置手机号输入框和密码输入框 */
- (void)setPhoneInputTextFieldAndPasswordTextField
{
    /** 设置手机号输入框 */
    self.phoneTextField = [InputTextField inputTextField];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneTextField createTextFieldPlaceholder:@"请输入手机号" andinputIcon:@"icon_Screen-smartphone - simple-line-icons"];
    self.phoneTextField.x = 50;
    self.phoneTextField.y = Top;
    self.phoneTextField.height = textFieldHeight;
    self.phoneTextField.width = self.view.width - self.phoneTextField.x * 2;
    [self.view addSubview:self.phoneTextField];
    
    /** 手机号分割线 */
    UILabel* phoneSplitLine = [[UILabel alloc] init];
    [phoneSplitLine setBackgroundColor:HDCColor(151, 151, 151)];
    phoneSplitLine.x = self.phoneTextField.x;
    phoneSplitLine.y = self.phoneTextField.y + self.phoneTextField.height;
    phoneSplitLine.height = 1;
    phoneSplitLine.width = self.phoneTextField.width;
    [self.view addSubview:phoneSplitLine];
    
    /** 设置密码输入框 */
    self.passwordTextField = [InputTextField inputTextField];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.passwordTextField createTextFieldPlaceholder:@"请输入密码" andinputIcon:@"icon_Lock - simple-line-icons"];
    self.passwordTextField.x = self.phoneTextField.x;
    self.passwordTextField.y = phoneSplitLine.y + 30;
    self.passwordTextField.height = 30;
    self.passwordTextField.width = self.phoneTextField.width;
    [self.view addSubview:self.passwordTextField];
    
    /** 密码分割线 */
    UILabel* passwordSplitLine = [[UILabel alloc] init];
    [passwordSplitLine setBackgroundColor:HDCColor(151, 151, 151)];
    passwordSplitLine.x = self.passwordTextField.x;
    passwordSplitLine.y = self.passwordTextField.y + self.passwordTextField.height;
    passwordSplitLine.height = 1;
    passwordSplitLine.width = self.passwordTextField.width;
    [self.view addSubview:passwordSplitLine];
}
/** 设置忘记密码、登录、注册按钮 */
- (void)setBtn
{
    /** 忘记密码按钮 */
    UIButton* forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    forgetPwdBtn.x = 120;
    forgetPwdBtn.y = self.passwordTextField.y + self.passwordTextField.height + 40;
    forgetPwdBtn.height = 10 * 2;
    forgetPwdBtn.width = self.view.width - forgetPwdBtn.x * 2;
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    /** 登录按钮 */
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"bj_biaoqian"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:HDCColor(255, 255, 255) forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    loginBtn.x = 15;
    loginBtn.y = forgetPwdBtn.y + forgetPwdBtn.height + 15;
    loginBtn.height = 40;
    loginBtn.width = self.view.width - loginBtn.x * 2;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    /** 注册按钮 */
    UIButton* registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"还没有账号? 立即注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:HDCColor(46, 192, 70) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    registerBtn.x = 15;
    registerBtn.y = loginBtn.y + loginBtn.height + 15;
    registerBtn.height = 40;
    registerBtn.width = loginBtn.width;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
}
/** 忘记密码按钮点击 */
- (void)forgetPwdBtnClick:(UIButton* )sender
{
    [self.navigationController pushViewController:[[ForgetPwdViewController alloc]init] animated:YES];
}
/** 登录按钮点击 */
- (void)loginBtnClick:(UIButton* )sender
{
 
    HDCLog(@"点击登录");
    
//    [MBProgressHUD showMessage:@"正在登录中..."];
//
//    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1+[3578]+\\d{9}"] evaluateWithObject:_phoneTextField.text])
//    {
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showSuccess:@"请输入正确的的手机号码"];
//        
//    }
//    else
//    {
        LoginParams* params = [[LoginParams alloc]init];
//            params.telephone = _phoneTextField.text;
//            params.pswd = _passwordTextField.text;
            params.telephone = @"13088888888"; // 品牌馆
//            params.telephone = @"13999999999"; // 社区店
//            params.telephone = @"13777777777";   // 普通商家
//              params.telephone = @"13055555555";
            params.pswd = @"1";
        [RequestTool login:params success:^(ResultsModel *result)
         {
             HDCLog(@"%@", result.ModelList);
             if ([result.ErrorCode isEqualToString:@"1"])
             {
                 NSArray* userInfoArray = [ShopsUserInfo mj_objectArrayWithKeyValuesArray:result.ModelList];
                 ShopsUserInfo *tmp = userInfoArray[0];
                 [ShopsUserInfoTool saveAccount:tmp];
                [self restoreRootViewController:[[HDCTabBarViewController alloc] init]];
                 [MBProgressHUD hideHUD];
                 [MBProgressHUD showSuccess:@"登录成功"];
             }
             else
             {
                 [MBProgressHUD hideHUD];
                 [MBProgressHUD showError:result.ErrorMsg];
             }
             
         } failure:^(NSError *error) {
             [MBProgressHUD hideHUD];
         }];
//    }

}
/** 切换根视图 */
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

/** 注册按钮点击 */
- (void)registerBtnClick:(UIButton* )sender
{
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[CommonShopsRegisterViewController alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[CommunityShopRegisterViewController alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[BrandShopRegisterViewController alloc] init] animated:YES];
//    
//    [self.navigationController pushViewController:[[ RealnameViewController alloc] init] animated:YES];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}




@end
