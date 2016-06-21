//
//  OwnHaveProvideController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHaveProvideController.h"
#import "haveTableViewCell.h"
@interface OwnHaveProvideController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *haveTableView;
@end

@implementation OwnHaveProvideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _haveTableView = [[UITableView alloc]init];
    _haveTableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_haveTableView];
    _haveTableView.delegate = self;
    _haveTableView.dataSource = self;
    [_haveTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 44));
    }];
    _haveTableView.rowHeight = 155;
    _haveTableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    [_haveTableView registerClass:[haveTableViewCell class] forCellReuseIdentifier:@"haveView"];
    
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
    haveTableViewCell *cell = [_haveTableView dequeueReusableCellWithIdentifier:@"haveView"];
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
