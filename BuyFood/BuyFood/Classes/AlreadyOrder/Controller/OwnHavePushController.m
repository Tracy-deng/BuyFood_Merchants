//
//  OwnHavePushController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHavePushController.h"
#import "pushTableViewCell.h"
@interface OwnHavePushController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIButton *pushBtn;
@property (nonatomic, strong) UIButton *alreadBtn;
@property (nonatomic, strong) UITableView * mainPushTabview;
@end

@implementation OwnHavePushController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSegmentControl];
    self.view.backgroundColor = HDCColor(238, 238, 238);
    [self creatTableView];
}


- (void)addSegmentControl
{
    _view1 = [[UIView alloc]init];
    _view1.backgroundColor = greenColor;
    [self.view addSubview:_view1];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.height.equalTo(@33);
        make.width.equalTo(@(SCREEN_WIDTH/2));
    }];
    
    _view2 = [[UIView alloc]init];
    _view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_view1);
        make.left.equalTo(_view1.mas_right);
    }];
    
    _pushBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_pushBtn setTitle:@"配送中" forState:(UIControlStateNormal)];
    [_pushBtn setTitleColor:greenColor forState:(UIControlStateNormal)];
    _pushBtn.backgroundColor = [UIColor whiteColor];
    _pushBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_view1 addSubview:_pushBtn];
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.left.equalTo(_view1);
        make.height.equalTo(@30);
    }];
    [_pushBtn addTarget:self action:@selector(didPushBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _alreadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_alreadBtn setTitle:@"已送达" forState:(UIControlStateNormal)];
    _alreadBtn.backgroundColor = [UIColor whiteColor];
    [_alreadBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _alreadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_view2 addSubview:_alreadBtn];
    [_alreadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.width.equalTo(_view2);
        make.height.equalTo(@30);
    }];
    [_alreadBtn addTarget:self action:@selector(didAlreadyBtn:) forControlEvents:(UIControlEventTouchUpInside)];
   
}
// 点击配送中
- (void)didPushBtn:(UIButton *)sender
{
    [sender setTitleColor:greenColor forState:(UIControlStateNormal)];
    _view1.backgroundColor = greenColor;
    
    [_alreadBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _view2.backgroundColor = [UIColor whiteColor];
}

// 点击已送达
- (void)didAlreadyBtn:(UIButton *)sender
{
   [sender setTitleColor:greenColor forState:(UIControlStateNormal)];
    _view2.backgroundColor = greenColor;
    
    [_pushBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _view1.backgroundColor = [UIColor whiteColor];
    
}

- (void)creatTableView
{
    _mainPushTabview = [[UITableView alloc]init];
    _mainPushTabview.rowHeight = 155;
    [self.view addSubview:_mainPushTabview];
    _mainPushTabview.delegate = self;
    _mainPushTabview.dataSource = self;
    [_mainPushTabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view1.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 64 - 33));
    }];
    _mainPushTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainPushTabview registerClass:[pushTableViewCell class] forCellReuseIdentifier:@"push"];
}
#pragma mark -- TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    pushTableViewCell *cell = [_mainPushTabview dequeueReusableCellWithIdentifier:@"push"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
