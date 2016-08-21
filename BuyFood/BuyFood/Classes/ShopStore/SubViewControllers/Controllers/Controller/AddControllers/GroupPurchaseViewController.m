//
//  GroupPurchaseViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/25.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "GroupPurchaseViewController.h"
#import "picButton.h"
#import "AddShopsCell.h"
#import "MHActionSheet.h"
#import "MHDatePicker.h"
#import "UpLoadImageUtil.h"
#import "AddOutDoorParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "RequestTool.h"
#import "ResultsModel.h"
#import "ProductPictureList.h"

#define Start_X self.view.frame.size.width * 0.05           // 第一个按钮的X坐标
#define Start_Y self.view.frame.size.height - (self.view.frame.size.height * 0.19) - (self.view.frame.size.width * 0.27)          // 第一个按钮的Y坐标
#define Width_Space self.view.frame.size.width * 0.05        // 2个按钮之间的横间距
#define Button_Width self.view.frame.size.width * 0.27 //宽


@interface GroupPurchaseViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView* tableView;
/** 商品名称 */
@property (nonatomic, strong) NSString *productName;
/** 团购价 */
@property (nonatomic, strong) NSString *groupPrice;
/** 原价 */
@property (nonatomic, strong) NSString *productPrice;
/** 每人限购数量 */
@property (nonatomic, strong) NSString *limitCount;
/** 单位 */
@property (nonatomic, strong) NSString *unitStr;
/** 重量 */
@property (nonatomic, strong) NSString *shopsWeight;
/** 团购时间 */
@property (nonatomic, strong) NSString *groupDate;
/** 团购开始时间 */
@property (nonatomic, strong) NSString *groupStartTime;
/** 团购结束时间 */
@property (nonatomic, strong) NSString *groupEndTime;
/** 活动描述 */
@property (nonatomic, strong) NSString *groupDescribe;

/** 时间选择器 */
@property (strong, nonatomic) MHDatePicker *selectTimePicker;

@property (nonatomic, strong) UIImagePickerController *imagePickController;
@property (nonatomic, strong) picButton *imageViewBtn;
@property (nonatomic, strong) picButton *lastButton;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) ShopsUserInfo *userInfo;
@end

@implementation GroupPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"团购管理";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createTableViewAndBottomBtn];
    [self setAddImageView];
    self.picArray = [NSMutableArray array];
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.userInfo = [ShopsUserInfoTool account];
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
    [bottomBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 3.0;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)bottomBtnClick:(UIButton *)sender
{
    picButton *find_btn1 = (picButton *)[self.view viewWithTag:100];
    picButton *find_btn2 = (picButton *)[self.view viewWithTag:101];
    picButton *find_btn3 = (picButton *)[self.view viewWithTag:102];

//    for(int i = 0; i < 3; i++){
//        
//        picButton *button_i = (picButton *)[self.view viewWithTag:10i];
//        NSMutableDictionary *pic = [NSMutableDictionary dictionary];
//        [pic setValue:button_i.picString forKey:@"littlepic"];
//        [self.picArray addObject:pic];
//    }
    
    NSMutableDictionary * pic1 = [NSMutableDictionary dictionaryWithCapacity:0];
    [pic1 setObject:find_btn1.picString forKey:@"littlepic"];
    [self.picArray addObject:pic1];
    
    NSMutableDictionary * pic2 = [NSMutableDictionary dictionaryWithCapacity:0];
    [pic1 setObject:find_btn2.picString forKey:@"littlepic"];
    [self.picArray addObject:pic2];
    
    NSMutableDictionary * pic3 = [NSMutableDictionary dictionaryWithCapacity:0];
    [pic1 setObject:find_btn3.picString forKey:@"littlepic"];
    [self.picArray addObject:pic3];

    HDCLog(@"%@", find_btn1.picString);
    HDCLog(@"%@", find_btn2.picString);
    HDCLog(@"%@", find_btn3.picString);
  
    if (find_btn1.picString.length == 0)
    {
        [MBProgressHUD showError:@"第一张图片上传失败"];
        return;
    }
    if (find_btn2.picString.length == 0)
    {
        [MBProgressHUD showError:@"第二张图片上传失败"];
        return;
    }
    if (find_btn3.picString.length == 0)
    {
        [MBProgressHUD showError:@"第三张图片上传失败"];
        return;
    }
    
    if (self.productName.length == 0 || self.groupPrice.length == 0 || self.productPrice.length == 0 || self.limitCount.length == 0 || self.shopsWeight.length == 0 || self.unitStr.length == 0 || self.groupStartTime.length == 0 || self.groupEndTime.length == 0)
    {
        [MBProgressHUD showError:@"请完整填写活动信息"];
        return;
    }
    else
    {
        [MBProgressHUD showMessage:@"正在上传中..."];
        
        AddOutDoorParams *params = [[AddOutDoorParams alloc] init];
        params.outname = self.productName;
        params.oldprice = [self.productPrice doubleValue];
        params.newprice = [self.groupPrice doubleValue];
        params.personcount = [self.limitCount integerValue];
        params.outtime = self.groupDate;
        params.starttime = self.groupStartTime;
        params.endtime = self.groupEndTime;
        params.rule1 = @"无需预约可直接上门";
        params.rule2 = @"最多可使用十张、不兑现、不找零";
        params.rule3 = @"仅限本人使用";
        params.productunit = self.unitStr;
        params.marketuserid = self.userInfo.marketuserid;
        params.remark = self.groupDescribe;
        params.pic = find_btn3.picString;
        params.ProductPictureList = self.picArray;
        [RequestTool addGroupBuy:params success:^(ResultsModel *result) {
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"上传成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"上传失败"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"上传失败"];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *ID = [NSString stringWithFormat:@"ID %ld", indexPath.row];
    AddShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 ||indexPath.row == 4 ||indexPath.row == 9)
        {
            cell = [[AddShopsCell alloc] initWithInputCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.contentTextField.tag = indexPath.row;
            cell.contentTextField.delegate = self;
            [cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
            switch (cell.contentTextField.tag)
            {
                case 0:
                    [cell setTitleLabel:@"商品名称:" andContentTextFieldPlaceholder:@"输入商品名"];
                    break;
                case 1:
                    [cell setTitleLabel:@"团购价:" andContentTextFieldPlaceholder:@"请输入团购价"];
                    break;
                case 2:
                    [cell setTitleLabel:@"原价:" andContentTextFieldPlaceholder:@"请输入原价格"];
                    break;
                case 3:
                    [cell setTitleLabel:@"每人限购:" andContentTextFieldPlaceholder:@"请输入限购数量"];
                    break;
                case 4:
                    [cell setTitleLabel:@"重量:" andContentTextFieldPlaceholder:@"请输入商品重量"];
                     break;
                case 9:
                    [cell setTitleLabel:@"活动描述:" andContentTextFieldPlaceholder:@"二十字以内"];
                    break;
                default:
                    break;
            }
        }
        else
        {
            cell = [[AddShopsCell alloc] initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row)
            {
                case 5:
                    [cell setChooseTitleLabel:@"单位:" andContentLabel:self.unitStr];
                    break;
                case 6:
                    [cell setChooseTitleLabel:@"活动时间:" andContentLabel:self.groupDate];
                    break;
                case 7:
                    [cell setChooseTitleLabel:@"活动开始时间:" andContentLabel:self.groupStartTime];
                    break;
                case 8:
                    [cell setChooseTitleLabel:@"活动结束时间:" andContentLabel:self.groupEndTime];
                    break;
                default:
                    break;
            }
        }

    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)changeValue:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 0:
            self.productName = textField.text;
            break;
        case 1:
            self.groupPrice = textField.text;
            break;
        case 2:
            self.productPrice = textField.text;
            break;
        case 3:
            self.limitCount = textField.text;
            break;
        case 4:
            self.shopsWeight = textField.text;
            break;
        case 9:
            self.groupDescribe = textField.text;
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddShopsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 5)
    {
        /** 
         份
         公斤
         斤
         两
         克
         千克
         条
         只
         瓶
         个
         箱
         袋
         次*/
        NSArray *array = @[@"份",
                           @"公斤",
                           @"斤",
                           @"两",
                           @"克",
                           @"千克",
                           @"条",
                           @"只",
                           @"瓶",
                           @"个",
                           @"箱",
                           @"袋",
                           @"次",];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品单位" style:MHSheetStyleDefault itemTitles:array];
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
        _selectTimePicker.isBeforeTime = YES;
        _selectTimePicker.datePickerMode = UIDatePickerModeDate;
        __weak typeof(self) weakSelf = self;
        [_selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate)
         {
             self.groupDate = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日"];
             [cell setChooseTitleLabel:@"活动日期:" andContentLabel:self.groupDate];
             [self.tableView reloadData];
         }];
    }
    if (indexPath.row == 7)
    {
        _selectTimePicker = [[MHDatePicker alloc] init];
        __weak typeof(self) weakSelf = self;
        _selectTimePicker.isBeforeTime = YES;
        _selectTimePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_selectTimePicker didFinishSelectedDate:^(NSDate *selectedDate)
         {
             self.groupStartTime = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日 HH: mm"];
             [cell setChooseTitleLabel:@"活动开始时间:" andContentLabel:self.groupStartTime];
             [self.tableView reloadData];
         }];
    }
    if (indexPath.row == 8)
    {
        MHDatePicker *timePicker = [[MHDatePicker alloc] init];
        timePicker.isBeforeTime = YES;
        timePicker.datePickerMode = UIDatePickerModeDateAndTime;
        __weak typeof(self) weakSelf = self;
        [timePicker didFinishSelectedDate:^(NSDate *selectedDate)
         {
             self.groupEndTime = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日 HH: mm"];
             [cell setChooseTitleLabel:@"活动结束时间:" andContentLabel:self.groupEndTime];
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

#pragma 添加图片
- (void)setAddImageView
{
    for (int i = 0; i < 3; i ++ )
    {
        self.imageViewBtn = [picButton buttonWithType:UIButtonTypeCustom];
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        self.imageViewBtn.tag = i + 100;
        [self.imageViewBtn setFrame:CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Width )+Start_Y, Button_Width, Button_Width)];
        [self.imageViewBtn setBackgroundImage:[UIImage imageNamed:@"addShopsImage"] forState:UIControlStateNormal];
        [self.imageViewBtn addTarget:self action:@selector(imageViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.imageViewBtn];
    }
}

- (void)imageViewBtnClick:(picButton* )sender
{
    _lastButton = sender;
    NSArray *photoArray = @[@"相机拍照",@"本地上传"];
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:photoArray];
    actionSheet.cancleTitle = @"取消选择";
    static NSInteger sourceType = 0 ;
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if (index == 0) {
            NSLog(@"相机拍照");
            // 判断相机有没有权限
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                sourceType = UIImagePickerControllerSourceTypeCamera;
                _imagePickController.sourceType = sourceType;
                // 进入相机
                [self presentViewController:_imagePickController animated:YES completion:nil];
            }
            else
            {
                
                UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"抱歉,您还没有相机权限" message:@"请您在设置里面打开权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [selct addAction:action];
                [self presentViewController:selct animated:YES completion:nil];
            }
        }
        else
        {
            HDCLog(@"本地上传");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                HDCLog(@"进去图片库");
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _imagePickController.sourceType = sourceType;
                
                [self presentViewController:_imagePickController animated:YES completion:nil];
            }
            else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                HDCLog(@"进入相册");
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                _imagePickController.sourceType = sourceType;
                
                [self presentViewController:_imagePickController animated:YES completion:nil];
            }
        }
    }];
}
#pragma mark-- imagePicker delegate 事件
/**
 * 图像选取器的委托方法，选完图片后回调该方法
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"图片上传中...";
    // 当图片不为空时显示图片并保存图片
    if (image != nil)
    {
        [UpLoadImageUtil upLoadImage:image success:^(id response) {
            if ([response[@"success"] intValue] == 1)
            {
                hud.labelText = @"图片上传成功";
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_lastButton setImage:image forState:UIControlStateNormal];
                });
                
                NSString *str = response[@"data"][0][@"littlepic"];
                _lastButton.picString = str;
            }
            
        } failure:^{
            
        }];
    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 点击键盘上的return按钮  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
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
    if (textField.tag == 4 || textField.tag == 9)
    {
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
