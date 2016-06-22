//
//  OwnHaveNoSolvedController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHaveNoSolvedController.h"
#import "ownSlovedTableViewCell.h"
@interface OwnHaveNoSolvedController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * ownSolvedTableView;
@end

@implementation OwnHaveNoSolvedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
}

- (void)creatTableView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = greenColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.height.equalTo(@0.1);
        make.width.equalTo(@(SCREEN_WIDTH/2));
    }];
    
    _ownSolvedTableView = [[UITableView alloc]init];
    [self.view addSubview:_ownSolvedTableView];
    _ownSolvedTableView.delegate = self;
    _ownSolvedTableView.dataSource = self;
    [_ownSolvedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 44 -64));
    }];
    _ownSolvedTableView.rowHeight = 155;
    _ownSolvedTableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    [_ownSolvedTableView registerClass:[ownSlovedTableViewCell class] forCellReuseIdentifier:@"haveView"];
}

/**
 *   实现tableView代理方法
 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ownSlovedTableViewCell *cell = [_ownSolvedTableView dequeueReusableCellWithIdentifier:@"haveView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置分割线颜色
    //    tableView.separatorColor = HDCColor(238, 238, 238);
    
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
