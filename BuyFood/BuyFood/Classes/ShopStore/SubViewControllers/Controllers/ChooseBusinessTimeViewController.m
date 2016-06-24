//
//  ChooseBusinessTimeViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ChooseBusinessTimeViewController.h"
#import "ChooseBusinessTimeView.h"
#import "MHDatePicker.h"

@interface ChooseBusinessTimeViewController ()

@property (nonatomic, strong) ChooseBusinessTimeView* chooseStartBusinessTimeView;
@property (nonatomic, strong) ChooseBusinessTimeView* chooseStopBusinessTimeView;
@property (strong, nonatomic) MHDatePicker *selectTimePicker;

@end

@implementation ChooseBusinessTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改营业时间";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self setChooseBusinessTimeView];
    [self setUpBusinessStatusBtn];
}

- (void)setChooseBusinessTimeView
{
    self.chooseStartBusinessTimeView = [ChooseBusinessTimeView initChooseBusinessTimeView];
    [self.chooseStartBusinessTimeView creatChooseBusinessTimeView];
    [self.chooseStartBusinessTimeView setTimeLabelText:@"开始时间" andBusinessTimeTitle:@"09：30"];
    [self.chooseStartBusinessTimeView.businessTime addTarget:self action:@selector(startBusinessTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseStartBusinessTimeView];
    [self.chooseStartBusinessTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(79);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.10);
    }];
    
    self.chooseStopBusinessTimeView = [ChooseBusinessTimeView initChooseBusinessTimeView];
    [self.chooseStopBusinessTimeView creatChooseBusinessTimeView];
    [self.chooseStopBusinessTimeView setTimeLabelText:@"结束时间" andBusinessTimeTitle:@"21：30"];
    [self.chooseStopBusinessTimeView.businessTime addTarget:self action:@selector(stopBusinessTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseStopBusinessTimeView];
    [self.chooseStopBusinessTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.chooseStartBusinessTimeView);
        make.top.mas_equalTo(self.chooseStartBusinessTimeView.mas_bottom).offset(15);
        make.width.equalTo(self.chooseStartBusinessTimeView);
        make.height.equalTo(self.chooseStartBusinessTimeView);
    }];
}

- (void)setUpBusinessStatusBtn
{
    UIButton* businessStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [businessStatusBtn setBackgroundImage:[UIImage imageNamed:@"businessStatus"] forState:UIControlStateNormal];
    [businessStatusBtn setTitle:@"保存修改" forState:UIControlStateNormal];
    [businessStatusBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    businessStatusBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [businessStatusBtn addTarget:self action:@selector(businessStatusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:businessStatusBtn];
    [businessStatusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chooseStopBusinessTimeView.mas_bottom).offset(150);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.89);
    }];
}

- (void)startBusinessTimeBtnClick:(UIButton* )startBtn
{
    _selectTimePicker = [[MHDatePicker alloc] init];
    __weak typeof(self) weakSelf = self;
    [_selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate)
    {
        NSString* title = [weakSelf dateStringWithDate:selectedDate DateFormat:@"HH: mm"];
        [startBtn setTitle:title forState:UIControlStateNormal];

    }];
}

- (void)stopBusinessTimeBtnClick:(UIButton* )stopBtn
{
    _selectTimePicker = [[MHDatePicker alloc] init];
    __weak typeof(self) weakSelf = self;
    [_selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate)
     {
         NSString* title = [weakSelf dateStringWithDate:selectedDate DateFormat:@"HH: mm"];
         [stopBtn setTitle:title forState:UIControlStateNormal];
     }];
}
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}
- (void)businessStatusBtnClick:(UIButton* )statusBtn
{
    HDCLog(@"...");
}

@end
