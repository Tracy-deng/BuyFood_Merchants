//
//  InformationViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/18.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "InformationViewController.h"
#import <WebKit/WebKit.h>
@interface InformationViewController ()<UIWebViewDelegate, WKNavigationDelegate>
{
    WKWebView *webView;
    UIImageView *view;
}
@end

@implementation InformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"资讯列表";
    [self loadWebView];
}
/** 加载网页 */
- (void)loadWebView
{
    webView  = [[ WKWebView alloc] initWithFrame:self.view.frame];
    [webView setUserInteractionEnabled:YES];  //是否支持交互
    
    [webView setOpaque:NO];  //透明
    
    [self.view  addSubview:webView];  //加载到自己的view
    
    [webView setNavigationDelegate:self];
    
    //加载网页的方式
    //1.创建并加载远程网页
    
    NSURL* url = [NSURL URLWithString:@"http://info.3g.qq.com/"];
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


@end
