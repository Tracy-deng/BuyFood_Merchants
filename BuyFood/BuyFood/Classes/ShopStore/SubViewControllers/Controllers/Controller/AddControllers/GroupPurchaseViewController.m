//
//  GroupPurchaseViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/25.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "GroupPurchaseViewController.h"
#import "SecondsKillCell.h"
#import "AddShopsCell.h"
#define Start_X self.view.frame.size.width * 0.05           // 第一个按钮的X坐标
#define Start_Y self.view.frame.size.height - (self.view.frame.size.height * 0.19) - (self.view.frame.size.width * 0.27)          // 第一个按钮的Y坐标
#define Width_Space self.view.frame.size.width * 0.05        // 2个按钮之间的横间距
#define Button_Width self.view.frame.size.width * 0.27 //宽

@interface GroupPurchaseViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
/** 单位*/
@property (nonatomic, strong) NSString* unitStr;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* imageViewBtn;

@end

@implementation GroupPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"团购管理";
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
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *ID = [NSString stringWithFormat:@"ID %ld", (long)indexPath.row];
    AddShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
            cell = [[AddShopsCell alloc] initWithInputCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.contentTextField.tag = indexPath.row;
            cell.contentTextField.delegate = self;
            [cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
            switch (cell.contentTextField.tag)
            {
                case 0:
                    [cell setTitleLabel:@"商品名称:" andContentTextFieldPlaceholder:@"请输入商品名称"];
                    break;
                case 1:
                    [cell setTitleLabel:@"秒杀价:" andContentTextFieldPlaceholder:@"请输入秒杀价格"];
                    break;
                case 2:
                    [cell setTitleLabel:@"原价:" andContentTextFieldPlaceholder:@"请输入商品原价格"];
                    break;
                    
                case 4:
                    [cell setTitleLabel:@"重量:" andContentTextFieldPlaceholder:@"请输入商品重量"];
                    break;
                    
                case 5:
                    [cell setTitleLabel:@"活动时间" andContentTextFieldPlaceholder:@"输入活动时间"];
                default:
                    break;
            }
        }else{
            cell = [[AddShopsCell alloc]initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case 3:
                    [cell setChooseTitleLabel:@"单位:" andContentLabel:self.unitStr];
                    break;
                    
                default:
                    break;
            }
        }
        

    }
    return cell;
    
    
}

- (void)changeValue:(UITextField *)textField
{
    HDCLog(@"%@", textField.text);
   
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
