//
//  HDCTabBarViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "HDCTabBarViewController.h"
#import "AlreadyOrderViewController.h"
#import "UntreatedOrderViewController.h"
#import "SettingViewController.h"
#import "ShopStoreViewController.h"
#import "HDCNavigationController.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "BrandUnOrderViewController.h"
#import "BrandAlreadyOrderViewController.h"

@interface HDCTabBarViewController ()

@end

@implementation HDCTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ShopsUserInfo* shopUserInfo = [ShopsUserInfoTool account];
    if ([shopUserInfo.markettypeid isEqualToString:@"1"] || [shopUserInfo.markettypeid isEqualToString:@"2"])
    {
        [self addChildVc:[[UntreatedOrderViewController alloc] init] title:@"未处理" image:@"icon_tabbar_nor4" selectedImage:@"icon_tabbar_selected4"];
        [self addChildVc:[[AlreadyOrderViewController alloc] init] title:@"已处理" image:@"icon_tabbar_nor3" selectedImage:@"icon_tabbar_selected3"];
    }
    else
    {
        [self addChildVc:[[BrandUnOrderViewController alloc] init] title:@"未处理" image:@"icon_tabbar_nor4" selectedImage:@"icon_tabbar_selected4"];
        [self addChildVc:[[BrandAlreadyOrderViewController alloc] init] title:@"已处理" image:@"icon_tabbar_nor3" selectedImage:@"icon_tabbar_selected3"];
    }
    [self addChildVc:[[ShopStoreViewController alloc] init] title:@"门店管理" image:@"icon_tabbar_nor2" selectedImage:@"icon_tabbar_selected2"];
    [self addChildVc:[[SettingViewController alloc] init] title:@"我的" image:@"icon_tabbar_nor1" selectedImage:@"icon_tabbar_selected1"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123.0/255 green:123.0/255 blue:123.0/255 alpha:1];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = HDCColor(46, 192, 70);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    // 先给外面传进来的小控制器 包装 一个导航控制器
    HDCNavigationController *nav = [[HDCNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}




@end
