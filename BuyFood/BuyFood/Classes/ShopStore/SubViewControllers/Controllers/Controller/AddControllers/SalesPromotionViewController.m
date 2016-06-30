//
//  SalesPromotionViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/24.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SalesPromotionViewController.h"
#import "SalesPromotionCell.h"

@interface SalesPromotionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* imageView;


@end

@implementation SalesPromotionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加促销商品";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addShopsImage];
    [self createTableViewAndBottomBtn];
}

- (void)addShopsImage
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addShopsImage"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
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
    
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
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
        make.bottom.mas_equalTo(bottomBtn.mas_top).offset(-10);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - self.imageView.frame.size.height - self.imageView.frame.origin.y - 100));
    }];
}

- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    NSLog(@"点击添加图片");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
        cell.textLabel.text = @"商品名称:";
        cell.textLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        UITextField* textField = [[UITextField alloc] init];
        textField.placeholder = @"输入蔬菜名";
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
        SalesPromotionCell* cell = [SalesPromotionCell cellWithTableView:tableView];
        if (indexPath.row == 1)
        {
            [cell setTitleLabel:@"分类:" andContentLabel:@"蔬菜类"];
        }
        else if (indexPath.row == 2)
        {
            [cell setTitleLabel:@"价格:" andContentLabel:@"0.00"];
        }
        else if (indexPath.row == 3)
        {
            [cell setTitleLabel:@"单位" andContentLabel:@"份"];
        }
        else if (indexPath.row == 4)
        {
            static NSString* ID = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            }
            cell.textLabel.text = @"重量:";
            cell.textLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
            cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
            UITextField* textField = [[UITextField alloc] init];
            textField.placeholder = @"输入重量";
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
        else if (indexPath.row == 5)
        {
            [cell setTitleLabel:@"标签" andContentLabel:@"特价"];
        }
        else if (indexPath.row == 6)
        {
            [cell setTitleLabel:@"描述" andContentLabel:@"二十字以内"];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
