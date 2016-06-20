//
//  HDCNavigationController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "HDCNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface HDCNavigationController ()

@end

@implementation HDCNavigationController


+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    //    // 设置不可用状态
    //    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    //    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    //    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    //    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** 设置标题文字颜色 */
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    /** 设置导航条颜色 */
    self.navigationBar.barTintColor = HDCColor(46, 192, 70);
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        self.navigationBar.hidden = NO;
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_left_back" highImage:@"icon_left_back"];
        
//        // 设置右边的更多按钮
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

//- (void)more
//{
//    [self popToRootViewControllerAnimated:YES];
//}


@end
