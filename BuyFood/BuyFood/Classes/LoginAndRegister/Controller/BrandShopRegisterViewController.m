//
//  BrandShopRegisterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/9.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BrandShopRegisterViewController.h"
#import "RealnameViewController.h"
#import "RegisterCell.h"
#import "CCLocationManager.h"
#import "RequestTool.h"
#import "ClassModel.h"
#import "ResultsModel.h"
#import "MJExtension.h"
#import "MHActionSheet.h"
#import "LoadView.h"
#import "UpLoadImageUtil.h"
#import "ImproveinformationParams.h"

@interface BrandShopRegisterViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    CLLocationManager *locationmanager;
}
@property (nonatomic, strong) UITableView* tableView;

/** 定位地址 */
@property (nonatomic, strong) UILabel* locationAddress;
/** 商家图片 */
@property (nonatomic, strong) UIImageView* imageView;
/** 分类数组 */
@property (nonatomic, strong) NSArray* classModelArray;
/** 一级分类id */
@property (nonatomic, assign) NSInteger selectClassIndex;
/** 一级分类名称 */
@property (nonatomic, strong) NSString* className;
/** 店铺名称 */
@property (nonatomic, strong) NSString* marketname;
/** 店铺电话 */
@property (nonatomic, strong) NSString* telephone;
/** 详细地址 */
@property (nonatomic, strong) NSString* address;

@property (nonatomic, strong) UIImagePickerController *imagePickController;

@end

@implementation BrandShopRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    [self setNavLeftBtn];
    [self createTableView];
    [self setShopsImageAndNextBtn];
    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
    }
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    LoadView *loadView = [[LoadView alloc] init];
    [loadView startAnimation];
    __block __weak BrandShopRegisterViewController *wself = self;
    
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation] getCity:^(NSString *cityString) {
            [wself setLabelText:cityString];
           [loadView stopAnimation];
        }];
    }
}
-(void)setLabelText:(NSString *)text
{
    _locationAddress.text = text;
}

/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"品牌馆注册";
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"icon_left_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* laftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = laftBarItem;
}
/** 返回按钮 */
- (void)backBtnClick:(UIButton* )sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 去掉多余的cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.50);
    }];
}

#pragma tableViewDelegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"ID %ld", indexPath.row];
    RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4)
        {
            cell = [[RegisterCell alloc] initWithInputCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.contentTextField.tag = indexPath.row;
            cell.contentTextField.delegate = self;
            [cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
            switch (cell.contentTextField.tag)
            {
                case 0:
                    [cell setTitleLabel:@"店铺名称:" andContentTextFieldPlaceholder:@"请输入店铺名称"];
                    break;
                case 1:
                    [cell setTitleLabel:@"联系电话:" andContentTextFieldPlaceholder:@"请输入联系电话"];
                    break;
                case 4:
                    [cell setTitleLabel:@"详细地址:" andContentTextFieldPlaceholder:@"请输入菜场详细地址"];
                    break;
                default:
                    break;
            }
        }
        else
        {
            cell = [[RegisterCell alloc]initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 2)
            {
                [cell setChooseTitleLabel:@"分类名称:" andContentLabel:self.className];
            }
            else if (indexPath.row == 3)
            {
                cell = [[RegisterCell alloc] initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                cell.chooseContentLabel.hidden = YES;
                self.locationAddress = [[UILabel alloc] init];
                self.locationAddress.textColor = HDCColor(102, 102, 102);
                self.locationAddress.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
                [cell.contentView addSubview:self.locationAddress];
                [self.locationAddress mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.centerY.width.height.equalTo(cell.chooseContentLabel);
                }];
                [cell setChooseTitleLabel:@"定位地址:" andContentLabel:nil];
            }
        }
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LoadView *loadView = [[LoadView alloc] init];
    if (indexPath.row == 2)
    {
        [loadView startAnimation];
        [RequestTool shopsListAll:nil success:^(ResultsModel *result)
        {
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                self.classModelArray = [ClassModel mj_objectArrayWithKeyValuesArray:result.ModelList];
                
                NSMutableArray* array = [NSMutableArray array];
                for (ClassModel* classModel in self.classModelArray)
                {
                    [array addObject:classModel.categoryname];
                }
                MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"分类选择" style:MHSheetStyleDefault itemTitles:array];
                actionSheet.cancleTitle = @"取消选择";
                [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                 {
                     self.className = title;
                     self.selectClassIndex = index;
                     [cell setChooseTitleLabel:@"分类名称:" andContentLabel:self.className];
                 }];
                [loadView stopAnimation];
            }
            else
            {
                [loadView stopAnimation];
            }
            
        } failure:^(NSError *error) {
            ;
        }];
    }
}

- (void)setShopsImageAndNextBtn
{
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:greenColor];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@50);
        make.width.equalTo(self.view);
    }];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picture"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(30);
        make.bottom.mas_equalTo(nextBtn.mas_top).offset(- 50);
        make.width.equalTo(@(SCREEN_WIDTH - 30 * 2));
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

/** 添加图片手势 */
- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    HDCLog(@"添加图片...");
    NSArray *photoArray = @[@"相机拍照",@"本地上传"];
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:photoArray];
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
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
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
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)nextBtnClick:(UIButton* )sender
{
    HDCLog(@"下一步...");
    if (self.marketname.length == 0 || self.telephone.length == 0 || self.address.length == 0 || self.locationAddress.text.length == 0)
    {
        UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"请注意 !!!" message:@"请您填写完整的资料" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [selct addAction:action];
        [self presentViewController:selct animated:YES completion:nil];
        return;
    }
    LoadView *loadView = [[LoadView alloc] init];
    [loadView startAnimation];
    [UpLoadImageUtil upLoadImage:self.imageView.image success:^(id response)
    {
        if ([response[@"success"] intValue] == 1)
        {
            ImproveinformationParams *params = [[ImproveinformationParams alloc] init];
            params.marketuserid = self.marketuserid;
            params.marketname = self.marketname;
            params.telephone2 = self.telephone;
            params.detailaddress = self.address;
            params.marketsubid = self.marketuserid;
            params.marketsubname = self.marketname;
            params.pic = response[@"data"][0][@"littlepic"];
            params.city = self.locationAddress.text;
            [RequestTool improveInformation:params success:^(ResultsModel *result) {
                if ([result.ErrorCode isEqualToString:@"1"])
                {
                    [loadView stopAnimation];
                    [MBProgressHUD showSuccess:@"资料填写成功"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else
                {
                    [loadView stopAnimation];
                    [MBProgressHUD showError:@"资料填写失败"];
                }
            } failure:^(NSError *error) {
                ;
            }];
        }
        else
        {
            [loadView stopAnimation];
            [MBProgressHUD showError:@"图片上传失败"];
        }
    } failure:^{
        ;
    }];
    
}

- (void)changeValue:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 0:
            self.marketname = textField.text;
            break;
        case 1:
            self.telephone = textField.text;
            break;
        case 4:
            self.address = textField.text;
            break;
        default:
            break;
    }
}
// 点击屏幕空白  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
