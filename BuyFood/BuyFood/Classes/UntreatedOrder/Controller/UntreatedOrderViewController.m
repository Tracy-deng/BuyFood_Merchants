//
//  UntreatedOrderViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "UntreatedOrderViewController.h"
#import "DistributionViewController.h"
#import "InviteViewController.h"

@interface UntreatedOrderViewController ()

/** 自提订单 */
@property (nonatomic, strong) InviteViewController* pickUpVC;
/** 配送订单 */
@property (nonatomic, strong) DistributionViewController* dispatchVC;


@end

@implementation UntreatedOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    
    [self setUpSegmentedControl];
    [self superInitView];
}

// 默认的加载视图
- (void)superInitView
{
    self.pickUpVC = [[InviteViewController alloc] init];
    self.dispatchVC = [[DistributionViewController alloc] init];
    [self addCon:self.pickUpVC addOtherView:self.pickUpVC.view bringView:self.pickUpVC.view WdeleOtherView:self.dispatchVC.view];
}

- (void)setUpSegmentedControl
{
    NSArray* segmentedArray = @[@"自提订单",@"配送订单"];
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    [segmentedControl setFrame:CGRectMake(0, 0, self.view.width * 0.58, self.view.height * 0.05)];
    segmentedControl.tintColor = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
}

- (void)doSomethingInSegment:(UISegmentedControl* )sender
{
    
    if (sender.selectedSegmentIndex == 0)
    {
        [self addCon:self.pickUpVC addOtherView:self.pickUpVC.view bringView:self.pickUpVC.view WdeleOtherView:self.dispatchVC.view];
    }
    else
    {
        [self addCon:self.dispatchVC addOtherView:self.dispatchVC.view bringView:self.dispatchVC.view WdeleOtherView:self.pickUpVC.view];
        [self.pickUpVC removeFromParentViewController];
    }
}


// 加载移除视图
- (void)addCon:(UIViewController *)VC addOtherView:(UIView *)View  bringView:(UIView *)binview WdeleOtherView:(UIView *)otherView
{
    [self addChildViewController:VC];
    [self.view addSubview:View];
    [self.view bringSubviewToFront:binview];
    [otherView removeFromSuperview];
}

@end
