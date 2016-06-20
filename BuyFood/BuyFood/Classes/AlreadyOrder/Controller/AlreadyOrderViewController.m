//
//  AlreadyOrderViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AlreadyOrderViewController.h"
#import "OwnHaveProvideController.h"
#import "OwnHavePushController.h"
#import "OwnHaveNoSolvedController.h"
@interface AlreadyOrderViewController ()
@property (nonatomic, strong)OwnHaveProvideController *ownVC; // 自提订单
@property (nonatomic, strong)OwnHavePushController *pushVC; // 配送订单
@property (nonatomic, strong)OwnHaveNoSolvedController *solvedVC; // 失效订单

@end

@implementation AlreadyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    
    [self superInitView];
    [self setUpSegmentedControl];
    
    // 设置导航栏
    //[self setupNav];
}

// 默认的加载视图
- (void)superInitView
{
    _ownVC = [[OwnHaveProvideController alloc]init];
    
    _pushVC = [[OwnHavePushController alloc]init];
    
    _solvedVC = [[OwnHaveNoSolvedController alloc]init];
    
    [self addCon:_ownVC addOtherView:_ownVC.view bringView:_ownVC.view WdeleOtherView:_pushVC.view ithdelOtherView:_solvedVC.view];
}
/**
 *  设置分段控件
 */
- (void)setUpSegmentedControl
{
 
    NSArray *controllArray = @[@"自提订单",@"配送订单",@"失效订单"];
    
    UISegmentedControl *selectControl = [[UISegmentedControl alloc]initWithItems:controllArray];
    
    selectControl.tintColor = [UIColor whiteColor];
    
    selectControl.selectedSegmentIndex = 0;
    
    [selectControl addTarget:self action:@selector(didSelectControl:) forControlEvents:(UIControlEventValueChanged)];
    
    self.navigationItem.titleView = selectControl;

    [selectControl setFrame:CGRectMake(0, 0, self.view.width * 0.8, self.view.height * 0.05)];
}

// 分段控件的实施
- (void)didSelectControl:(UISegmentedControl *)sender
{

    if (sender.selectedSegmentIndex == 0){
        
        NSLog(@"你当前选择的是自提订单");
        
        [self addCon:_ownVC addOtherView:_ownVC.view bringView:_ownVC.view WdeleOtherView:_pushVC.view ithdelOtherView:_solvedVC.view];
        

    }else if (sender.selectedSegmentIndex == 1){
        
        NSLog(@"你当前选择的是配送订单");
        
        [self addCon:_pushVC addOtherView:_pushVC.view bringView:_pushVC.view WdeleOtherView:_ownVC.view ithdelOtherView:_solvedVC.view];
        
    }else{
        
        NSLog(@"你当前选择的是失效订单");
        
        [self addCon:_solvedVC addOtherView:_solvedVC.view bringView:_solvedVC.view WdeleOtherView:_ownVC.view ithdelOtherView:_pushVC.view];
    }
}

/** 设置导航栏 */
- (void)setupNav
{
    NSArray *segmentedArray = @[@""];
    NSLog(@"%@",segmentedArray);
   
}

// 加载移除视图
- (void)addCon:(UIViewController *)VC addOtherView:(UIView *)View  bringView:(UIView *)binview WdeleOtherView:(UIView *)otherView  ithdelOtherView:(UIView *)delView
{
    [self addChildViewController:VC];
    [self.view addSubview:View];
    [self.view bringSubviewToFront:binview];
    [delView removeFromSuperview];
    [otherView removeFromSuperview];
    
}

@end
