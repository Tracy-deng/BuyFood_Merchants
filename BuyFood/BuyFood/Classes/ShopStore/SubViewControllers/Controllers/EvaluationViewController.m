//
//  EvaluationViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationHeaderView.h"
#import "EvaluateCell.h"
#import "EvaluationParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"
#import "RequestTool.h"
#import "MJExtension.h"
#import "HttpRequestTool.h"
#import "RequestTool.h"
#import "jadeModel.h"
#import "JADEMethods.h"
#import "ReplyEvaluationParams.h"
#import "MJRefresh.h"
#import "LoadView.h"
#import "MBProgressHUD.h"

static CGFloat textFieldH = 40;
@interface EvaluationViewController ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, strong) EvaluationHeaderView* contentHeaderView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ShopsUserInfo* userInfo;
@property (nonatomic, assign) CGRect rect;

@end

@implementation EvaluationViewController
{
    NSMutableArray *dataSource;
    UITextView *_textView;
    NSString  *chartID;
    NSIndexPath *_currentEditingIndexthPath;
    CGFloat _totalKeybordHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Replay:) name:@"Replay" object:nil];
    [self createTableView];
    self.title = @"评价详情";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.userInfo = [ShopsUserInfoTool account];
    [self prepareEvaluationData];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self prepareEvaluationData];
    }];
}

/** 请求cell的数据 */
-(void)prepareEvaluationData
{
    [MBProgressHUD showMessage:@"数据加载中..."];
    EvaluationParams *params = [[EvaluationParams alloc] init];
    params.marketuserid = self.userInfo.marketuserid;
    [RequestTool evaluation:params success:^(ResultsModel *result) {
        if ([result.totalcount isEqualToString:@"0"])
        {
             [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"暂无数据!"];
           
        }
        else
        {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"数据加载成功!"];
            dataSource = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in result.ModelList)
            {
                jadeModel *model = [[jadeModel alloc]initWithDic:dic];
                [dataSource addObject:model];
                [self.tableView reloadData];
            }
            
        }
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"数据加载失败"];
    }];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _textView  = [[UITextView alloc]init];
    _textView.frame = CGRectMake(0,JADESIZE.height,JADESIZE.width, 50);
    _textView.delegate = self;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.hidden = YES;
    _textView.layer.borderWidth = 1;
    
    [self.view addSubview:_textView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    jadeModel *model1 = dataSource[indexPath.row];
    NSString *replay = [NSString stringWithFormat:@"%@%@",@"商家回复：",model1.charcontent2];
    return ( [JADEMethods getHeightByWidth:JADESIZE.width-10*JADESCREENSCALE title:model1.charcontent font:[UIFont systemFontOfSize:14*JADESCREENSCALE ]])+[JADEMethods getHeightByWidth:JADESIZE.width-60*JADESCREENSCALE title:replay font:[UIFont systemFontOfSize:14*JADESCREENSCALE ]]+self.view.height*0.15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvaluateCell *cell = [EvaluateCell cellWithTableView:tableView];
    cell.model = dataSource[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.height * 0.14;
}

/** 设置表的headerView */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.contentHeaderView = [EvaluationHeaderView initEvaluationHeaderView];
    [self.contentHeaderView creatHeaderContentView];
    
    [self.contentHeaderView setBackgroundColor:HDCColor(250, 250, 250)];
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"statistics/GetMarketUserScore"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"marketuserid"] = self.userInfo.marketuserid;
    [HttpRequestTool GET:url parameters:dic progress:nil completionHandler:^(id model, NSError *error)
    {
        NSString *score = model[@"score"];
        if ([model[@"score"] isEqualToString:@""])
        {
            score = @"0";
        }
        [self.contentHeaderView setOrderNumberLabel:model[@"totalordercount"] andGreatEvaluationLabel:score];
    }];
    return self.contentHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)Replay:(NSNotification *)notifice
{
    
    [_textView becomeFirstResponder];
    
    [self adjustTableViewToFitKeyboard];
    
     self.tableView.userInteractionEnabled = YES;
    _textView.hidden = NO;
    _textView.backgroundColor = [UIColor whiteColor];
    [_textView becomeFirstResponder];//弹出键盘
    NSDictionary *dic = [notifice object];
    chartID = [dic objectForKey:@"charID"];
    _currentEditingIndexthPath  = [dic objectForKey:@"indexpath"];
    NSLog(@"%@",_currentEditingIndexthPath);
    
    [self adjustTableViewToFitKeyboard];
    NSLog(@"%@",chartID);
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_textView resignFirstResponder];
        _textView.hidden = YES;
        ReplyEvaluationParams *params = [[ReplyEvaluationParams alloc] init];
        params.chartid = chartID;
        params.charcontent2 = _textView.text;
        [RequestTool replyEvaluation:params success:^(ResultsModel *result) {
            if ([result.ErrorCode isEqualToString:@"1"]) {
                [self prepareEvaluationData];
                [_tableView reloadData];
            }
            
        } failure:^(NSError *error) {
            ;
        }];
        
        return NO;
        //发送信息
    }
    return YES;
}
- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textView.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}
- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = _tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [_tableView setContentOffset:offset animated:YES];
}

@end
