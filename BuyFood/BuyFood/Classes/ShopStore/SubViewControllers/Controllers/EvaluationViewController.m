//
//  EvaluationViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationHeaderView.h"
#import "EvaluationFooterView.h"
#import "EvaluateCell.h"
#import "EvaluationParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"
#import "RequestTool.h"
#import "EvaluationModelList.h"
#import "MJExtension.h"
#import "HttpRequestTool.h"
#import "RequestTool.h"


@interface EvaluationViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL  Display[100];
    
}
@property (nonatomic, strong) EvaluationHeaderView* contentHeaderView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) EvaluationFooterView* footerView;
@property (nonatomic, strong) NSMutableArray* array;
@property (nonatomic, strong) ShopsUserInfo* userInfo;
@property (nonatomic, assign) CGRect rect;


@end

@implementation EvaluationViewController

- (NSMutableArray *)array
{
    if (_array == nil)
    {
        self.array = [NSMutableArray arrayWithCapacity:0];
    }
    return _array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"评价详情";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    
    [self setUpContentHeaderView];
    [self createTableViewCell];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getEvaluationList];
}

/** 获取留言评价列表 */
- (void)getEvaluationList
{
    self.userInfo = [ShopsUserInfoTool account];
    EvaluationParams* params = [[EvaluationParams alloc] init];
    params.marketuserid = self.userInfo.marketuserid;
    [RequestTool evaluation:params success:^(ResultsModel *result)
    {
        self.array = [EvaluationModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ;
    }];
    
    
}
- (void)setUpContentHeaderView
{
    self.contentHeaderView = [EvaluationHeaderView initEvaluationHeaderView];
    [self.contentHeaderView creatHeaderContentView];
    
    [self.contentHeaderView setBackgroundColor:HDCColor(250, 250, 250)];
    [self.view addSubview:self.contentHeaderView];
    [self.contentHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.14);
    }];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"statistics/GetMarketUserScore"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"marketuserid"] = self.userInfo.marketuserid;
    [HttpRequestTool GET:url parameters:dic progress:nil completionHandler:^(id model, NSError *error) {
        HDCLog(@"%@", model);
        HDCLog(@"%@", model[@"totalordercount"]);
        HDCLog(@"%@", model[@"score"]);
        [self.contentHeaderView setOrderNumberLabel:model[@"totalordercount"] andGreatEvaluationLabel:model[@"score"]];
    }];
}

- (void)createTableViewCell
{
    UILabel* titleForHeader = [[UILabel alloc] init];
    titleForHeader.backgroundColor = [UIColor clearColor];
    titleForHeader.text = @"评价详情";
    titleForHeader.textColor = HDCColor(153, 153, 153);
    titleForHeader.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self.view addSubview:titleForHeader];
    [titleForHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentHeaderView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.width.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight= 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleForHeader.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.70);
    }];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Display[section] == YES)
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvaluateCell* cell = [EvaluateCell cellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.height * 0.15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height * 0.17;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.footerView = [EvaluationFooterView initFootView];
    self.footerView.userInteractionEnabled = YES;
    [self.footerView setBackgroundColor:[UIColor whiteColor]];
    [self.footerView setUpContentView];
    
    EvaluationModelList *modelList = [self.array objectAtIndex:section];
    NSRange range = [modelList.modifytime rangeOfString:@"T"];
    NSString *modifytime = [modelList.modifytime substringToIndex:range.location];
    NSString *evaluation;
    if ([modelList.score isEqualToString:@"1"])
    {
        evaluation = @"好评";
    }
    else if ([modelList.score isEqualToString:@"2"])
    {
        evaluation = @"中评";
    }
    else
    {
        evaluation = @"差评";
    }
    [self.footerView setFooterViewContentWithHeaderImage:@"rectangle9" andUserName:modelList.showname andEvaluate:evaluation andEvaluateContent:modelList.charcontent andEvaluateTime:modifytime];
    self.rect = [self.footerView.evaluateContent.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.footerView.evaluateContent.font} context:nil];
    HDCLog(@"%lf",self.rect.size.height);
    if (section != 0)
    {
        UILabel* line1 = [[UILabel alloc] initWithFrame:CGRectMake(5, self.footerView.height, self.view.frame.size.width - 10, 1)];
        [line1 setBackgroundColor:[UIColor grayColor]];
        [self.footerView addSubview:line1];
    }
    [self.footerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(display1:)]];
    [self.footerView.replyBtn addTarget:self action:@selector(replyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.footerView.tag = section;
    self.footerView.replyBtn.tag = section;
    self.footerView.replyBtn.hidden = !Display[section];
    return self.footerView;
}

- (void)display1:(UITapGestureRecognizer *)tap
{
    NSInteger section = tap.view.tag;
    Display[section] = YES;
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
- (void)replyBtnClick:(UIButton* )sender
{
    NSLog(@"。。。。");
    NSLog(@"%ld",sender.tag);
    Display[sender.tag] = NO;
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:sender.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
