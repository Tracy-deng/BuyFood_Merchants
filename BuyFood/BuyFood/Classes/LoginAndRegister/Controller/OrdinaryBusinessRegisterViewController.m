//
//  OrdinaryBusinessRegisterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/9.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OrdinaryBusinessRegisterViewController.h"
#import "RealnameViewController.h"
#import "RegisterCell.h"
#import "ClassModel.h"
#import "FoodMarketModel.h"
#import "MHActionSheet.h"
#import "RequestTool.h"
#import "ResultsModel.h"
#import "MJExtension.h"
#import <CoreLocation/CoreLocation.h>
#import "NearbyMarketsParams.h"
#import "ImproveinformationParams.h"
#import "ShopsUserInfoTool.h"
#import "UpLoadImageUtil.h"

@interface OrdinaryBusinessRegisterViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) RegisterCell* cell;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* classModelArray;
@property (nonatomic, strong) NSArray* foodMarketModelArray;

/** 后两行的按钮 */
@property (nonatomic, strong) UIButton* contentBtn;
@property (nonatomic, strong) UILabel* classLabel;
@property (nonatomic, strong) UILabel* foodMarketLabel;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, assign)float lon1;
@property (nonatomic, assign)float lat1;
@property (nonatomic, assign) NSInteger selectClassIndex;
@property (nonatomic, assign) NSInteger selectMarketIndex;

@property (nonatomic, strong) NSString* marketname;
@property (nonatomic, strong) NSString* telephone;
@property (nonatomic, strong) NSString* address;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePickController;

@end

@implementation OrdinaryBusinessRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavLeftBtn];
    self.view.backgroundColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    [self createTableView];
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // 初始化定位
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self findMe];
    [self setUpNextBtn];
    
}

/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"普通商家注册";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [RegisterCell cellWithTableView:tableView];
    self.cell.contentTextField.tag = indexPath.row;
    if (indexPath.row == 0)
    {
        [self.cell setLeftTitleLabel:@"店铺名称:" andContentTextFieldPlaceholder:@"请输入店铺名称"];
    }
    else if (indexPath.row == 1)
    {
        [self.cell setLeftTitleLabel:@"联系电话:" andContentTextFieldPlaceholder:@"请输入联系电话"];
    }
    else if (indexPath.row == 2)
    {
        [self.cell setLeftTitleLabel:@"详细地址:" andContentTextFieldPlaceholder:@"请输入店铺详细地址"];
        self.cell.contentTextField.delegate = self;
    }
    else if (indexPath.row == 3)
    {
        self.cell.contentTextField.hidden = YES;
        self.cell.leftTitleLabel.text = @"分类名称:";
        self.contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentBtn setImage:[UIImage imageNamed:@"under"] forState:UIControlStateNormal];
        [self.contentBtn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cell.contentView addSubview:self.contentBtn];
        [self.contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cell.contentView.mas_right).offset(-5);
            make.top.equalTo(self.cell.contentView.mas_top).offset(5);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        self.classLabel = [[UILabel alloc] init];
        [self.cell.contentView addSubview:self.classLabel];
        [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cell.leftTitleLabel.mas_right).offset(5);
            make.top.equalTo(self.cell.leftTitleLabel);
            make.width.equalTo(@180);
            make.height.equalTo(@30);
        }];
    }
    else
    {
        self.cell.contentTextField.hidden = YES;
        self.cell.leftTitleLabel.text = @"所属菜场:";
        self.contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentBtn setImage:[UIImage imageNamed:@"under"] forState:UIControlStateNormal];
        [self.contentBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cell.contentView addSubview:self.contentBtn];
        [self.contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cell.contentView.mas_right).offset(-5);
            make.top.equalTo(self.cell.contentView.mas_top).offset(5);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        self.foodMarketLabel = [[UILabel alloc] init];
        [self.cell.contentView addSubview:self.foodMarketLabel];
        [self.foodMarketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cell.leftTitleLabel.mas_right).offset(5);
            make.top.equalTo(self.cell.leftTitleLabel);
            make.width.equalTo(@180);
            make.height.equalTo(@30);
        }];
    }
    [self.cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    return self.cell;
}
/** 获取分类名称 */
- (void)fourBtnClick:(UIButton* )sender
{
    [RequestTool shopsListAll:nil success:^(ResultsModel *result) {
        self.classModelArray = [ClassModel mj_objectArrayWithKeyValuesArray:result.ModelList];
        
        NSMutableArray* array = [NSMutableArray array];
        for (ClassModel* classModel in self.classModelArray)
        {
            [array addObject:classModel.categoryname];
        }
        for (ClassModel* classModel in self.classModelArray) {
            HDCLog(@"%@", classModel.categoryid);
        }
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"分类选择" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.classLabel.text = title;
             self.selectClassIndex = index;
         }];

    } failure:^(NSError *error) {
        ;
    }];
}
/** 获取附近菜场 */
- (void)fiveBtnClick:(UIButton* )sender
{
    NearbyMarketsParams* marketsParams = [[NearbyMarketsParams alloc] init];
    marketsParams.lon = self.lon1;
    marketsParams.lat = self.lat1;
    marketsParams.ismarket = [NSString stringWithFormat:@"2"];
    marketsParams.distance = [NSString stringWithFormat:@"%d", 500];
    marketsParams.pageindex = [NSString stringWithFormat:@"%d", 1];
    marketsParams.pagesize = [NSString stringWithFormat:@"%d", 50];
    marketsParams.markettypeid = [NSString stringWithFormat:@"1"];
   [RequestTool nearbyMarketsListAll:marketsParams success:^(ResultsModel *result) {
       self.foodMarketModelArray = [FoodMarketModel mj_objectArrayWithKeyValuesArray:result.ModelList];
       NSMutableArray* array = [NSMutableArray array];
       for (FoodMarketModel* marketModel in self.foodMarketModelArray)
       {
          [array addObject:marketModel.marketname];
       }
       MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择菜场" style:MHSheetStyleWeiChat itemTitles:array];
       actionSheet.cancleTitle = @"取消选择";
       [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
        {
            self.foodMarketLabel.text = title;
            self.selectMarketIndex = index;
        }];
   } failure:^(NSError *error) {
       ;
   }];

}
- (void)findMe
{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
}
#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    HDCLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    self.lat1 = coordinate.latitude;
    self.lon1 = coordinate.longitude;
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}
#pragma mark --- UITextFieldDelegate 回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 2)
    {
        [textField resignFirstResponder];
    }
    return YES;
}
/** 设置下一步按钮 */
- (void)setUpNextBtn
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

- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    HDCLog(@"添加图片...");
    NSArray *photoArray = @[@"相机拍照",@"本地上传"];
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleWeiChat itemTitles:photoArray];
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
                
            }else{
                
                UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"抱歉,您还没有相机权限" message:@"请您在设置里面打开权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [selct addAction:action];
                [self presentViewController:selct animated:YES completion:nil];
            }
            
            
            
        }else{
            
            NSLog(@"本地上传");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                NSLog(@"进去图片库");
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _imagePickController.sourceType = sourceType;
                
                [self presentViewController:_imagePickController animated:YES completion:nil];
                
                
            }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                NSLog(@"进入相册");
                
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

- (void)nextBtnClick:(UIButton* )sender
{
    [UpLoadImageUtil upLoadImage:self.imageView.image success:^(id response) {
        ;
        ImproveinformationParams *params = [[ImproveinformationParams alloc] init];
        params.marketname = self.marketname;
        params.telephone2 = self.telephone;
        params.detailaddress = self.address;
        params.marketuserid = self.marketuserid;
        params.marketsubname = _foodMarketLabel.text;
        params.marketsubid = [NSString stringWithFormat:@"%ld",_selectMarketIndex];
        params.categoryid = [NSString stringWithFormat:@"%ld", self.selectClassIndex];
        params.pic = response[@"data"][0][@"littlepic"];
        [RequestTool improveInformation:params success:^(ResultsModel *result) {
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                [MBProgressHUD showSuccess:result.ErrorMsg];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            ;
        }];
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
        case 2:
            self.address = textField.text;
            break;
        default:
            break;
    }
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
    if (textField.tag == 3 || textField.tag == 5 || textField.tag == 7) {
        
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
