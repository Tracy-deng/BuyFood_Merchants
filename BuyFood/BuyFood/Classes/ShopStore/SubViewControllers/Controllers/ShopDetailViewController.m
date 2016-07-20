//
//  ShopDetailViewController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "SalesPromotionCell.h"
#import "UIImageView+WebCache.h"
@interface ShopDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* imageView;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"编辑商品";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self addShopsImage];
    [self createTableViewAndBottomBtn];
    NSLog(@"%@",self.detailModel);
}

- (void)addShopsImage
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopsImage"]];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.productpic] placeholderImage:nil];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.25);
    }];
    // 1.创建Tap手势
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    // 2.设置手势的属性
    // 设置需要触发手势的点击数
    tapGR.numberOfTapsRequired = 1;
    
    // 设置需要触发手势的触点的个数
    tapGR.numberOfTouchesRequired = 1;
    
    // 3.将手势与具体的视图绑定在一起
    [self.imageView addGestureRecognizer:tapGR];
}

- (void)createTableViewAndBottomBtn
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 0.25*SCREEN_HEIGHT - 64));
    }];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.tableFooterView = view;
    
    
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 3.0;
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@40);
        
    }];
    
    UIButton* deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleBtn setBackgroundColor:[UIColor colorWithRed:1.000 green:0.442 blue:0.113 alpha:1.000]];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleBtn.layer.cornerRadius = 3.0;
    [self.view addSubview:deleBtn];
    [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomBtn.mas_top).offset(-5);
        make.left.right.height.equalTo(bottomBtn);
        
    }];
    
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.cornerRadius = 4;
    deleBtn.layer.masksToBounds = YES;
    deleBtn.layer.cornerRadius = 4;

    
}

- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    NSLog(@"点击添加图片");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SalesPromotionCell* cell = [SalesPromotionCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0)
    {
        [cell setTitleLabel:@"商品名称:" andContentLabel:self.detailModel.productname];
    }
    else if (indexPath.row == 1)
    {
        [cell setTitleLabel:@"分类:" andContentLabel:self.detailModel.threecategoryname];
    }
    else if (indexPath.row == 2)
    {
        [cell setTitleLabel:@"价格:" andContentLabel:self.detailModel.productoutprice];
    }
    else if (indexPath.row == 3)
    {
        [cell setTitleLabel:@"单位" andContentLabel:self.detailModel.productunit];
    }
    else if (indexPath.row == 4)
    {

        [cell setTitleLabel:@"重量:" andContentLabel:@"11"];
    }else
        
        [cell setTitleLabel:@"标签" andContentLabel:self.detailModel.productlabel];
        
        
    return cell;
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
