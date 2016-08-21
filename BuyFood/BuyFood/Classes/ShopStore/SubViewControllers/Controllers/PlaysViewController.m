//
//  PlaysViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/18.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PlaysViewController.h"
#import <WebKit/WebKit.h>

@interface PlaysViewController ()<UIWebViewDelegate, WKNavigationDelegate>
{
    WKWebView *webView;
    UIImageView *view;
}

@end

@implementation PlaysViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"小游戏";
    [self loadWebView];
}
/** 加载网页 */
- (void)loadWebView
{
    webView  = [[ WKWebView alloc] init];
    
    [webView setUserInteractionEnabled:YES];  //是否支持交互
    
    [webView setOpaque:NO];  //透明
    
    [self.view  addSubview:webView];  //加载到自己的view
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    
    [webView setNavigationDelegate:self];
    
    //加载网页的方式
    //1.创建并加载远程网页

    NSURL* url = [NSURL URLWithString:@"http://www.html5tricks.com/demo/html5-fruit-ninja/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    view = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:view];
}

// 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    view.hidden = NO;
}

// 页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    view.hidden = YES;
}

// 界面加载失败的时候
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    view.hidden = YES;
}
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

//是否可以旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:YES];
//    [webView removeFromSuperview];
//}

@end
