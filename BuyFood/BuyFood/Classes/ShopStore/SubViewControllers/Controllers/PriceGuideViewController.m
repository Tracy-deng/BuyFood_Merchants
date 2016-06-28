//
//  PriceGuideViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PriceGuideViewController.h"
#import "SetPriceAdviceCell.h"

#define Start_X self.view.frame.size.width * 0.05  // 第一个label的X坐标
#define Start_Y  8    // 第一个label的Y坐标
#define Width_Space self.view.frame.size.width * 0.20  // 2个label之间的横间距
#define Label_Width self.view.frame.size.width * 0.18 //label宽
#define Label_Height self.view.frame.size.height * 0.03 //label高

@interface PriceGuideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView* titleView;
@property (nonatomic, strong) NSArray* labelTitle;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation PriceGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"定价指导";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self setUpTitleView];
    [self createTableView];
}

- (void)setUpTitleView
{
    self.titleView = [[UIView alloc] init];
    [self.titleView setBackgroundColor:[UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1]];
    [self.view addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
    }];
    self.labelTitle = @[@"商品",
                        @"采购价",
                        @"市场均价"];
    
    for (int i = 0; i < self.labelTitle.count; i ++ )
    {
        UILabel* title = [[UILabel alloc] init];
        NSInteger index = i % 3;
        [title setFrame:CGRectMake(index * (Label_Width + Width_Space) + Start_X, Start_Y, Label_Width, Label_Height)];
        title.text = self.labelTitle[i];
        title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        title.textColor = [UIColor colorWithRed:35/255.0 green:188/255.0 blue:49/255.0 alpha:1];
        [self.titleView addSubview:title];
    }
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - self.titleView.frame.size.height - 64));
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetPriceAdviceCell* cell = [SetPriceAdviceCell cellWithTableView:tableView];
    [cell setTitleLabel:@"白菜" andBuyMoneyLabel:@"2.67" andAveragePrice:@"3.00" andDownOrImageName:@"addShopsImage"];
    return cell;
}



@end
