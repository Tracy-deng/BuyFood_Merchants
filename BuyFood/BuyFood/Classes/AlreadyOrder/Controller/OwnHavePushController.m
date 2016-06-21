//
//  OwnHavePushController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHavePushController.h"

@interface OwnHavePushController ()

@end

@implementation OwnHavePushController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSegmentControl];
    
}


- (void)addSegmentControl
{
    NSArray *array = @[@"配送中",@"已送达"];
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:array];
    [control setTintColor:greenColor];
    [self.view addSubview:control];
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@39);
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
