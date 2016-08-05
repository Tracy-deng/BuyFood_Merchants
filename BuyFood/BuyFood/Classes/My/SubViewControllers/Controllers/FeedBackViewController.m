//
//  FeedBackViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Button.h"
#import "RequestTool.h"
#import "FeedBackParams.h"
#import "ResultsModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "LoadView.h"
#import "MBProgressHUD.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView* textView;

@property (nonatomic, strong) UITextView* placeholder;

@end

@implementation FeedBackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCBackViewColor];
    self.title = @"意见反馈";
    [self setUpContentView];
}

- (void)setUpContentView
{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.width * 0.03, self.view.height * 0.15, self.view.width * 0.95, self.view.height * 0.25)];
    self.textView.delegate = self;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    self.textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    // 设置光标从0,0的位置开始
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.textView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.textView];
    
    // 设置textView的placeholder
    self.placeholder = [[UITextView alloc] initWithFrame:CGRectMake(self.view.width * 0.20, self.view.height * 0.08, self.view.width * 0.60, self.view.height * 0.10)];
    self.placeholder.textColor = HDCColor(213, 213, 213);
    self.placeholder.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.placeholder.userInteractionEnabled = NO;
    self.placeholder.text = @"请写下您的对我们产品的建议与意见帮助我们一起做的更好";
    [self.textView addSubview:self.placeholder];
    
    // 确定按钮
    Button* button = [Button initButton];
    [button setButtonTitle:@"发送" andButtonX:self.view.width * 0.06 andButtonY:self.view.height * 0.65 andButtonHeight:self.view.height * 0.08 andButtonWidth:self.view.width * 0.89 andButtonNormalImage:nil andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:HDCColor(255, 255, 255)];
    [button setBackgroundColor:HDCColor(35, 192, 58)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender
{
//    LoadView *loadView = [[LoadView alloc] init];
//    [loadView startAnimation];
    [MBProgressHUD showMessage:@"意见提交中..."];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    FeedBackParams *params = [[FeedBackParams alloc] init];
    params.userid = userInfo.marketuserid;
    params.usertype = @"2";
    params.remark = self.textView.text;
    [RequestTool feedBack:params success:^(ResultsModel *result)
    {
        if ([result.ErrorCode isEqualToString:@"-1"])
        {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"意见提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"意见提交失败"];
        }
        HDCLog(@"%@", result.ErrorCode);
    } failure:^(NSError *error) {
        ;
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        self.placeholder.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.placeholder.hidden = NO;
    }
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    
    return YES;
}



@end
