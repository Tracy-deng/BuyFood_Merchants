//
//  FightGroupsViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/25.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "FightGroupsViewController.h"
#import "AddShopsCell.h"
#import "MHActionSheet.h"
#import "MHDatePicker.h"

#define Start_X self.view.frame.size.width * 0.05           // 第一个按钮的X坐标
#define Start_Y self.view.frame.size.height - (self.view.frame.size.height * 0.19) - (self.view.frame.size.width * 0.27)          // 第一个按钮的Y坐标
#define Width_Space self.view.frame.size.width * 0.05        // 2个按钮之间的横间距
#define Button_Width self.view.frame.size.width * 0.27 //宽

@interface FightGroupsViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *imageViewBtn;
/** 单位 */
@property (nonatomic, strong) NSString *unitStr;
/** 商品名称 */
@property (nonatomic, strong) NSString *productname;
/** 商品原价 */
@property (nonatomic, strong) NSString *productprice;
/** 拼购价 */
@property (nonatomic, strong) NSString *productprice2;
/** 人数限制 */
@property (nonatomic, strong) NSString *peopleNum;
/** 商品重量 */
@property (nonatomic, strong) NSString *shopsWeight;
/** 时间选择器 */
@property (strong, nonatomic) MHDatePicker *selectTimePicker;
/** 活动时间 */
@property (nonatomic, strong) NSString *fightGroupsTime;

@end

@implementation FightGroupsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"拼团";
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
    
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
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
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"ID %ld", indexPath.row];
    AddShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5)
        {
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
                    [cell setTitleLabel:@"原价:" andContentTextFieldPlaceholder:@"请输入商品原价格"];
                    break;
                case 2:
                    [cell setTitleLabel:@"拼购价:" andContentTextFieldPlaceholder:@"请输入拼购价格"];
                    break;
                case 3:
                    [cell setTitleLabel:@"人数限制:" andContentTextFieldPlaceholder:@"请输入限制人数"];
                    break;
                case 5:
                    [cell setTitleLabel:@"重量:" andContentTextFieldPlaceholder:@"请输入商品重量"];
                    break;
                default:
                    break;
            }
        }
        else
        {
            cell = [[AddShopsCell alloc] initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 4)
            {
                [cell setChooseTitleLabel:@"单位:" andContentLabel:self.unitStr];
            }
            else
            {
                [cell setChooseTitleLabel:@"活动时间:" andContentLabel:self.fightGroupsTime];
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddShopsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 4)
    {
        NSArray *array = @[@"克",
                           @"份"];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品单位" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.unitStr = title;
             [cell setChooseTitleLabel:@"单位:" andContentLabel:self.unitStr];
             [self.tableView reloadData];
         }];
    }
    if (indexPath.row == 6)
    {
        _selectTimePicker = [[MHDatePicker alloc] init];
        __weak typeof(self) weakSelf = self;
        [_selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate)
         {
             //             self.fightGroupsTime = [weakSelf dateStringWithDate:selectedDate DateFormat:@"YYYY/MM/dd hh:mm"];
             self.fightGroupsTime = [weakSelf dateStringWithDate:selectedDate DateFormat:@"YYYY/MM/dd"];
             [cell setChooseTitleLabel:@"活动时间:" andContentLabel:self.fightGroupsTime];
             [self.tableView reloadData];
         }];
    }
}
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}
#pragma textField输入
- (void)changeValue:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 0:
            self.productname = textField.text;
            break;
        case 1:
            self.productprice = textField.text;
            break;
        case 2:
            self.productprice2 = textField.text;
            break;
        case 3:
            self.peopleNum = textField.text;
            break;
        case 5:
            self.shopsWeight = textField.text;
            break;
        default:
            break;
    }
}

/** 添加图片 */
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

#pragma mark -- 点击键盘上的return按钮  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

// 点击屏幕空白  收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 在UITextField 编辑之前调用方法  视图上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self packUpDownTextField:textField isShow:YES];
    
}
// 编辑结束 视图返回
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self packUpDownTextField:textField isShow:NO];
}
- (void)packUpDownTextField:(UITextField *)textField isShow:(BOOL)isShow
{
    if (textField.tag == 0 || textField.tag == 1 || textField.tag == 2 || textField.tag == 3 || textField.tag == 5) {
        
        //设置动画的名字
        [UIView beginAnimations:@"Animation" context:nil];
        //设置动画的间隔时间
        [UIView setAnimationDuration:0.20];
        //??使用当前正在运行的状态开始下一段动画
        [UIView setAnimationBeginsFromCurrentState: YES];
        if (isShow == YES) {
            //设置视图下移动的位移
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 0.3*SCREEN_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
        }else{
            //设置视图上移动的位移
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 0.3*SCREEN_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
            
        }
        
        //设置动画结束
        [UIView commitAnimations];
    }else{
        return ;
    }
}


@end
