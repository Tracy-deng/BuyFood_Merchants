//
//  AddShopsViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/4.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddShopsViewController.h"
#import "AddShopsCell.h"
#import "GetBrandsAndCommunityClassifyParams.h"
#import "RequestTool.h"
#import "MBProgressHUD.h"
#import "ResultsModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "CtcategoryModelList.h"
#import "MJExtension.h"
#import "MHActionSheet.h"
#import "UpLoadImageUtil.h"
#import "AddProductParams.h"

@interface AddShopsViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 要上传的图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 商品名称 */
@property (nonatomic, strong) NSString *productname;
/** 商品价格 */
@property (nonatomic, strong) NSString *productoutprice;
/** 商品重量 */
@property (nonatomic, strong) NSString *productstock;
/** 商品描述 */
@property (nonatomic, strong) NSString *productremark;
/** 分类名称 */
@property (nonatomic, strong) NSString *className;
/** 分类id */
@property (nonatomic, strong) NSString *selectClassIndex;
/** 商品单位 */
@property (nonatomic, strong) NSString *shopsUnit;
/** 商品标签 */
@property (nonatomic, strong) NSString *shopsTag;

@property (nonatomic, strong) ShopsUserInfo *userInfo;

/** 图片选择器 */
@property (nonatomic, strong) UIImagePickerController *imagePickController;

@end

@implementation AddShopsViewController
{
    UIButton *bottomBtn;
    NSMutableArray *selectedDataSource;
    NSMutableArray *selectClassIndexDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"添加商品";
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    self.userInfo = [ShopsUserInfoTool account];
    [self addShopsImage];
    [self createTableViewAndBottomBtn];
}

- (void)addShopsImage
{
    UIView *imageBackView = [[UIView alloc] init];
    [imageBackView setBackgroundColor:HDCColor(216, 216, 216)];
    [self.view addSubview:imageBackView];
    [imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.25);
        make.top.mas_equalTo(self.view.mas_top).offset(64);
    }];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addShopsImage"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageBackView.mas_centerX);
        make.top.equalTo(imageBackView.mas_top);
        make.width.mas_equalTo(self.view.mas_height).multipliedBy(0.25);
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
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6)
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
                case 2:
                    [cell setTitleLabel:@"价格:" andContentTextFieldPlaceholder:@"请输入商品价格"];
                    break;
                case 4:
                    [cell setTitleLabel:@"重量:" andContentTextFieldPlaceholder:@"请输入商品重量"];
                    break;
                case 6:
                    [cell setTitleLabel:@"描述:" andContentTextFieldPlaceholder:@"二十字以内"];
                    break;
                default:
                    break;
            }
        }
        else
        {
            cell = [[AddShopsCell alloc]initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row)
            {
                case 1:
                    [cell setChooseTitleLabel:@"分类名称:" andContentLabel:self.className];
                    break;
                case 3:
                    [cell setChooseTitleLabel:@"单位:" andContentLabel:_shopsUnit];
                    break;
                case 5:
                    [cell setChooseTitleLabel:@"标签:" andContentLabel:_shopsTag];
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
    switch (textField.tag)
    {
        case 0:
            self.productname = textField.text;
            break;
        case 2:
            self.productoutprice= textField.text;
            break;
        case 4:
            self.productstock = textField.text;
            break;
        case 6:
            self.productremark = textField.text;
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddShopsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5)
    {
        if (indexPath.row == 1)
        {
            [MBProgressHUD showMessage:@"数据读取中..."];
            GetBrandsAndCommunityClassifyParams *params = [[GetBrandsAndCommunityClassifyParams alloc] init];
            params.userid = self.userInfo.marketuserid;
            [RequestTool searchCtcategory:params success:^(ResultsModel *result)
             {
                 if ([result.totalcount isEqualToString:@"0"])
                 {
                     [MBProgressHUD hideHUD];
                     [MBProgressHUD showError:@"暂无数据"];
                 }
                 else
                 {
                     selectedDataSource = [NSMutableArray array];
                     NSMutableArray *array = [CtcategoryModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
                     for (CtcategoryModelList *modelList in array)
                     {
                         [selectedDataSource addObject:modelList.threecategoryname];
                     }
                     MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品分类" style:MHSheetStyleDefault itemTitles:selectedDataSource];
                     actionSheet.cancleTitle = @"取消选择";
                     [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                      {
                          CtcategoryModelList *modelList = array[index];
                          self.selectClassIndex = modelList.threecategoryid;
                          self.className = title;
                          [cell setChooseTitleLabel:@"分类名称:" andContentLabel:self.className];
                          [self.tableView reloadData];
                      }];
                     [MBProgressHUD hideHUD];
                     [MBProgressHUD showSuccess:@"数据获取成功"];
                 }
             } failure:^(NSError *error) {
                 [MBProgressHUD hideHUD];
                 [MBProgressHUD showError:@"获取列表失败"];
             }];
        }
        else if (indexPath.row == 3)
        {
            NSArray * array = @[@"份",
                                @"克"];
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择单位" style:MHSheetStyleDefault itemTitles:array];
            actionSheet.cancleTitle = @"取消选择";
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
             {
                 self.shopsUnit = title;
                 [cell setChooseTitleLabel:@"单位:" andContentLabel:self.shopsUnit];
                 [self.tableView reloadData];
             }];
        }
        else if (indexPath.row == 5)
        {
            NSArray * array = @[@"普通",
                                @"热销"];
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品标签" style:MHSheetStyleDefault itemTitles:array];
            actionSheet.cancleTitle = @"取消选择";
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
             {
                 self.shopsTag = title;
                 [cell setChooseTitleLabel:@"标签:" andContentLabel:self.shopsTag];
                 [self.tableView reloadData];
             }];
        }
    }
}


- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    NSLog(@"点击添加图片");
    NSArray *photoArray = @[@"相机拍照",@"本地上传"];
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleWeiChat itemTitles:photoArray];
    actionSheet.cancleTitle = @"取消选择";
    static NSInteger sourceType = 0 ;
    
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
        if (index == 0) {
            NSLog(@"相机拍照");
            // 判断相机有没有权限
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片存入相册
    
    [self saveImage:image withName:@"IMAGE_0.jpg"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"IMAGE_0.jpg"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [self.imageView setImage:savedImage];
    
    self.imageView.tag = 100;
    
}
// 相机选择取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)saveBtnClick:(UIButton *)sender
{
    [MBProgressHUD showMessage:@"商品上传中..."];
    
    [UpLoadImageUtil upLoadImage:self.imageView.image success:^(id response) {
        if ([response[@"success"] intValue] == 1)
        {
           AddProductParams* params = [[AddProductParams alloc] init];
            params.marketuserid = self.userInfo.marketuserid;
            params.threecategoryid = self.selectClassIndex;
            params.productname = self.productname;
            params.productstock = self.productstock;
            params.productoutprice = self.productoutprice;
            params.productremark = self.productremark;
            params.Productlabel = self.shopsTag;
            params.productunit = self.shopsUnit;
            params.promotion = @"1";
            params.productpic = response[@"data"][0][@"littlepic"];
            [RequestTool addProducts:params success:^(ResultsModel *result) {
                HDCLog(@"%@",result);
                if ([result.ErrorCode isEqualToString:@"1"])
                {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showSuccess:@"商品添加成功"];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"twoViewController" object:self];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showError:@"商品添加失败"];
                }
                
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"商品添加失败"];
            }];
        }
    } failure:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"上传失败"];
    }];
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
    if (textField.tag == 2 || textField.tag == 4 || textField.tag == 6) {
        
        //设置动画的名字
        [UIView beginAnimations:@"Animation" context:nil];
        //设置动画的间隔时间
        [UIView setAnimationDuration:0.20];
        //??使用当前正在运行的状态开始下一段动画
        [UIView setAnimationBeginsFromCurrentState: YES];
        if (isShow == YES)
        {
            //设置视图下移动的位移
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 0.3*SCREEN_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
        }
        else
        {
            //设置视图上移动的位移
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 0.3*SCREEN_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
        }
        //设置动画结束
        [UIView commitAnimations];
    }
    else
    {
        return ;
    }
}

@end
