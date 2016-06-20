//
//  UntreatedOrderViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "UntreatedOrderViewController.h"
#import "PickUpViewController.h"
#import "DispatchViewController.h"

@interface UntreatedOrderViewController ()

@property (nonatomic, strong) PickUpViewController* pickUpVC;
@property (nonatomic, strong) DispatchViewController* dispatchVC;


@end

@implementation UntreatedOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.pickUpVC = [[PickUpViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.pickUpVC.view setFrame:CGRectMake(self.view.width * 0.03, self.view.height * 0.13, self.view.width - 2 * self.view.width * 0.03, self.view.height - self.view.height * 0.20)];
    [self.navigationController addChildViewController:self.pickUpVC];
    //[self.view addSubview:self.pickUpVC.view];
    [self setUpSegmentedControl];
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
        [self.dispatchVC.view removeFromSuperview];
        
        [self.view addSubview:self.pickUpVC.view];
    }
    else
    {
        [self.pickUpVC.view removeFromSuperview];
        self.dispatchVC = [[DispatchViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.dispatchVC.view setFrame:CGRectMake(self.view.width * 0.03, self.view.height * 0.13, self.view.width - 2 * self.view.width * 0.03, self.view.height - self.view.height * 0.20)];
//        [self.navigationController addChildViewController:self.dispatchVC];
        [self.view addSubview:self.dispatchVC.view];
    }
}

@end
