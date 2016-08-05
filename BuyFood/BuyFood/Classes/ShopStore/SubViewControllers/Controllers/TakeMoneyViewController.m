//
//  TakeMoneyViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "TakeMoneyViewController.h"
#import "TakeMoneyCell.h"

@interface TakeMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIButton *button;
}
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation TakeMoneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"取现";
    [self setUpTableViewAndBtn];
}

- (void)setUpTableViewAndBtn
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.60);
    }];
     self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor:HDCColor(35, 194, 61)];
    btn.layer.cornerRadius = 3.0;
    [btn setTitle:@"提交审核" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(21);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
        make.width.equalTo(@(SCREEN_WIDTH - 2 * 21));
        make.height.equalTo(@(50));
    }];
}

- (void)btnClick:(UIButton* )sender
{
    HDCLog(@"提交审核");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TakeMoneyCell* cell = [TakeMoneyCell cellWithTableView:tableView];
    if (indexPath.row == 0)
    {
        if (self.selectIndex == 0)
        {
            [cell setUpTitleText:@"支付宝号:" andInputTextPlaceholder:@"请输入支付宝账号" andInputText:@""];
        }
        else
        {
            [cell setUpTitleText:@"银行卡号:" andInputTextPlaceholder:@"请输入银行卡号" andInputText:@""];
        }
    }
    else if (indexPath.row == 1)
    {
        [cell setUpTitleText:@"姓名:" andInputTextPlaceholder:@"请输入姓名" andInputText:@""];
    }
    else if (indexPath.row == 2)
    {
        [cell setUpTitleText:@"提现金额:" andInputTextPlaceholder:@"请输入提现金额" andInputText:@""];
    }
    else
    {
        // 设置验证码按钮
        button = [[UIButton alloc] init];
        [button setTitle:@"发送验证码" forState:UIControlStateNormal];
        button .titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:WhiteColor forState:UIControlStateNormal];
        [button setBackgroundColor:greenColor];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView.mas_right).offset(-5);
            make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            make.width.equalTo(@(125));
            make.height.equalTo(@(40));
        }];
        [cell setUpTitleText:@"验证码:" andInputTextPlaceholder:@"请输入验证码" andInputText:@""];
    }
    
    return cell;
}

- (void)buttonClick:(UIButton *)sender
{
    button.userInteractionEnabled = NO;
    HDCLog(@"发送验证码");
    [self startTime];
}



-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [ button setTitle:@"发送验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [button setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}


@end
