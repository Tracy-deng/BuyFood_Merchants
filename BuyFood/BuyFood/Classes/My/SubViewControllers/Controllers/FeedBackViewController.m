//
//  FeedBackViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Button.h"

@interface FeedBackViewController ()<UITextViewDelegate>

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
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.width * 0.03, self.view.height * 0.15, self.view.width * 0.95, self.view.height * 0.25)];
    textView.delegate = self;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    // 设置光标从0,0的位置开始
    self.automaticallyAdjustsScrollViewInsets = NO;
    [textView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:textView];
    
    // 设置textView的placeholder
    self.placeholder = [[UITextView alloc] initWithFrame:CGRectMake(self.view.width * 0.20, self.view.height * 0.08, self.view.width * 0.60, self.view.height * 0.10)];
    self.placeholder.textColor = HDCColor(213, 213, 213);
    self.placeholder.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.placeholder.userInteractionEnabled = NO;
    self.placeholder.text = @"请写下您的对我们产品的建议与意见帮助我们一起做的更好";
    [textView addSubview:self.placeholder];
    
    // 确定按钮
    Button* button = [Button initButton];
    [button setButtonTitle:@"发送" andButtonX:self.view.width * 0.06 andButtonY:self.view.height * 0.65 andButtonHeight:self.view.height * 0.08 andButtonWidth:self.view.width * 0.89 andButtonNormalImage:nil andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:HDCColor(255, 255, 255)];
    [button setBackgroundColor:HDCColor(35, 192, 58)];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
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
    return YES;
}

@end
