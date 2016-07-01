//
//  OutdoorActivitiesViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/25.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OutdoorActivitiesViewController.h" 
#import "SecondsKillCell.h"


#define Start_X self.view.frame.size.width * 0.05           // 第一个按钮的X坐标
#define Start_Y self.view.frame.size.height - (self.view.frame.size.height * 0.19) - (self.view.frame.size.width * 0.27)          // 第一个按钮的Y坐标
#define Width_Space self.view.frame.size.width * 0.05        // 2个按钮之间的横间距
#define Button_Width self.view.frame.size.width * 0.27 //宽

@interface OutdoorActivitiesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* imageViewBtn;

@end

@implementation OutdoorActivitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"户外活动";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createTableViewAndBottomBtn];
    [self setAddImageView];
}
- (void)createTableViewAndBottomBtn
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"申请" forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 3.0;
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(21);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(@(SCREEN_WIDTH - 2 * 21));
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        ;
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.63);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString* ID = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.textLabel.text = @"活动名称:";
        cell.textLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        UITextField* textField = [[UITextField alloc] init];
        textField.placeholder = @"输入活动名称";
        textField.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        [cell.contentView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).offset(120);
            make.top.mas_equalTo(cell.contentView.mas_top).offset(15);
            make.width.equalTo(@150);
            make.height.equalTo(@30);
        }];
        return cell;
    }
    else
    {
        
        SecondsKillCell* cell = [SecondsKillCell cellWithTableView:tableView];
        if (indexPath.row == 1)
        {
            [cell setTitleLabel:@"报名费：" andContentLabel:@"0.00"];
        }
        else if (indexPath.row == 2)
        {
            [cell setTitleLabel:@"人数限制：" andContentLabel:@"0.00"];
        }
        else if (indexPath.row == 3)
        {
            [cell setTitleLabel:@"活动时间" andContentLabel:@""];
        }
        else
        {
            [cell setTitleLabel:@"活动描述" andContentLabel:@""];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)setAddImageView
{
    for (int i = 0; i < 3; i ++ )
    {
        self.imageViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        self.imageViewBtn.tag = i;
        [self.imageViewBtn setFrame:CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Width )+Start_Y, Button_Width, Button_Width)];
        [self.imageViewBtn setBackgroundImage:[UIImage imageNamed:@"addShopsImage"] forState:UIControlStateNormal];
        [self.imageViewBtn addTarget:self action:@selector(imageViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.imageViewBtn];
    }
}

- (void)imageViewBtnClick:(UIButton* )sender
{
    NSLog(@"%ld", sender.tag);
}


@end
