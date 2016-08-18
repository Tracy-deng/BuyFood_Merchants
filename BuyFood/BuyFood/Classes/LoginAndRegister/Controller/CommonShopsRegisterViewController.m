//
//  CommonShopsRegisterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/2.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CommonShopsRegisterViewController.h"
#import "RealnameViewController.h"
#import "RegisterCell.h"
#import "ClassModel.h"
#import "FoodMarketModel.h"
#import "MHActionSheet.h"
#import "RequestTool.h"
#import "ResultsModel.h"
#import "MJExtension.h"
#import "NearbyMarketsParams.h"
#import "ImproveinformationParams.h"
#import "ShopsUserInfoTool.h"
#import "UpLoadImageUtil.h"
#import "GetCityAndCountryParams.h"
#import "ProvinceAndCityAndCountryModelList.h"
#import "LoadView.h"
#import "GetCityAndCountryParams.h"
#import "MBProgressHUD.h"
#import "LoadView.h"

@interface CommonShopsRegisterViewController ()
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView* tableView;

/** 分类名称 */
@property (nonatomic, strong) NSString* className;
/** 菜场名称 */
@property (nonatomic, strong) NSString* foodMarket;
/** 分类id */
@property (nonatomic, assign) NSInteger selectClassIndex;
/** 菜场id */
@property (nonatomic, assign) NSInteger selectMarketIndex;
/** 店名名称 */
@property (nonatomic, strong) NSString* marketname;
/** 电话 */
@property (nonatomic, strong) NSString* telephone;
/** 详细地址 */
@property (nonatomic, strong) NSString* address;
/** 省 */
@property (nonatomic, strong) NSString *province;
/** 市 */
@property (nonatomic, strong) NSString *city;
/** 县 / 区  */
@property (nonatomic, strong) NSString *country;
/** 上传图片*/
@property (nonatomic, strong) UIImageView *imageView;
/** 经度 */
@property (nonatomic, strong) NSString *lon;
/** 纬度 */
@property (nonatomic, strong) NSString *lat;

@property (nonatomic, strong) UIImagePickerController *imagePickController;


@end

@implementation CommonShopsRegisterViewController
{
    NSMutableArray *provinceDataSource;
    NSMutableArray *cityDataSource;
    NSMutableArray *countryDataSource;
    NSMutableArray *classNameDataSource;
    NSMutableArray *foodMarketDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    [self setNavLeftBtn];
    [self createTableView];
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
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
/** 创建tableView*/
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
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"ID %ld", indexPath.row];
    RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        if (indexPath.row == 0 || indexPath.row == 1)
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
                default:
                    break;
            }
        }
        else
        {
            cell = [[RegisterCell alloc]initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row)
            {
                case 2:
                    [cell setChooseTitleLabel:@"选择省份:" andContentLabel:self.province];
                    break;
                case 3:
                    [cell setChooseTitleLabel:@"选择城市:" andContentLabel:self.city];
                    break;
                case 4:
                    [cell setChooseTitleLabel:@"选择区域:" andContentLabel:self.country];
                    break;
                case 5:
                    [cell setChooseTitleLabel:@"分类名称:" andContentLabel:self.className];
                    break;
                case 6:
                    [cell setChooseTitleLabel:@"所属菜场:" andContentLabel:self.foodMarket];
                    break;
                case 7:
                    [cell setChooseTitleLabel:@"菜场地址:" andContentLabel:@"点击获取地址"];
                    break;
                default:
                    break;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LoadView *loadView = [[LoadView alloc] init];
    /** 获取省 */
    if (indexPath.row == 2)
    {
        [loadView startAnimation];
        [RequestTool getProvinceListSuccess:^(ResultsModel *result)
         {
             if ([result.ErrorCode isEqualToString:@"1"])
             {
                 NSMutableArray *array = [ProvinceAndCityAndCountryModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
                 provinceDataSource = [NSMutableArray array];
                 for (ProvinceAndCityAndCountryModelList *modelList in array)
                 {
                     [provinceDataSource addObject:modelList.province];
                 }
                 MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"城市选择" style:MHSheetStyleDefault itemTitles:provinceDataSource];
                 actionSheet.cancleTitle = @"取消选择";
                 [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                  {
                      self.province = title;
                      [cell setChooseTitleLabel:@"选择省份:" andContentLabel:self.province];
                      [self.tableView reloadData];
                  }];
                 [loadView stopAnimation];
             }
             else
             {
                 [loadView stopAnimation];
             }
         } failure:^(NSError *error) {
             [loadView stopAnimation];
         }];
    }
    /** 获取市 */
    else if (indexPath.row == 3)
    {
        if (self.province.length == 0)
        {
            UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"抱歉,您还没有选择省份" message:@"请您先选择您所在省份" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [selct addAction:action];
            [self presentViewController:selct animated:YES completion:nil];
            return;
        }
        else
        {
            [loadView startAnimation];
            GetCityAndCountryParams *params = [[GetCityAndCountryParams alloc] init];
            params.province = self.province;
            [RequestTool getCityList:params success:^(ResultsModel *result)
             {
                 if ([result.ErrorCode isEqualToString:@"1"])
                 {
                     NSMutableArray *array = [ProvinceAndCityAndCountryModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
                     cityDataSource = [NSMutableArray array];
                     for (ProvinceAndCityAndCountryModelList *modelList in array)
                     {
                         [cityDataSource addObject:modelList.city];
                     }
                     MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"城市选择" style:MHSheetStyleDefault itemTitles:cityDataSource];
                     actionSheet.cancleTitle = @"取消选择";
                     [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                      {
                          self.city = title;
                          [cell setChooseTitleLabel:@"选择城市:" andContentLabel:self.city];
                          [self.tableView reloadData];
                      }];
                     [loadView stopAnimation];
                 }
                 else
                 {
                     [loadView stopAnimation];
                 }
             } failure:^(NSError *error) {
                 
             }];
        }
    }
    /** 获取区域 */
    else if (indexPath.row == 4)
    {
        if (self.city.length == 0)
        {
            UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"抱歉,您还没有选择城市" message:@"请您先选择您所在城市" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [selct addAction:action];
            [self presentViewController:selct animated:YES completion:nil];
            return;
        }
        else
        {
            [loadView startAnimation];
            GetCityAndCountryParams *params = [[GetCityAndCountryParams alloc] init];
            params.city = self.city;
            [RequestTool getCountryList:params success:^(ResultsModel *result)
             {
                 if ([result.ErrorCode isEqualToString:@"1"])
                 {
                     NSMutableArray *array = [ProvinceAndCityAndCountryModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
                     countryDataSource = [NSMutableArray array];
                     for (ProvinceAndCityAndCountryModelList *modelList in array)
                     {
                         [countryDataSource addObject:modelList.country];
                     }
                     MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"区域选择" style:MHSheetStyleDefault itemTitles:countryDataSource];
                     actionSheet.cancleTitle = @"取消选择";
                     [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                      {
                          self.country = title;
                          [cell setChooseTitleLabel:@"选择区域:" andContentLabel:self.country];
                          [self.tableView reloadData];
                      }];
                     [loadView stopAnimation];
                 }
                 else
                 {
                     [loadView stopAnimation];
                 }
             } failure:^(NSError *error) {
                 
             }];
        }
    }
    /** 获取分类 */
    else if(indexPath.row == 5)
    {
        [loadView startAnimation];
        [RequestTool shopsListAll:nil success:^(ResultsModel *result)
         {
             if ([result.ErrorCode isEqualToString:@"1"])
             {
                 NSMutableArray* array = [ClassModel mj_objectArrayWithKeyValuesArray:result.ModelList];
                 classNameDataSource = [NSMutableArray array];
                 for (ClassModel* classModel in array)
                 {
                     [classNameDataSource addObject:classModel.categoryname];
                 }
                 MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"分类选择" style:MHSheetStyleDefault itemTitles:classNameDataSource];
                 actionSheet.cancleTitle = @"取消选择";
                 [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                  {
                      self.className = title;
                      self.selectClassIndex = index + 1;
                      [cell setChooseTitleLabel:@"分类名称:" andContentLabel:self.className];
                      [self.tableView reloadData];
                  }];
                 [loadView stopAnimation];
             }
             else
             {
                 [loadView stopAnimation];
             }
             
         } failure:^(NSError *error) {
             
         }];
        
    }
    /** 获取菜场 */
    else if (indexPath.row == 6 || indexPath.row == 7)
    {
        if (self.country.length == 0)
        {
            UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"请正确选择地址" message:@"请确认好自己的选择地址" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [selct addAction:action];
            [self presentViewController:selct animated:YES completion:nil];
            return;
        }
        else
        {
            if (indexPath.row == 6)
            {
                [loadView startAnimation];
                NearbyMarketsParams *params = [[NearbyMarketsParams alloc] init];
                params.province = self.province;
                params.city = self.city;
                params.country = self.country;
                [RequestTool getMarketsListAll:params success:^(ResultsModel *result) {
                    if ([result.ErrorCode isEqualToString:@"1"])
                    {
                        NSMutableArray* array = [FoodMarketModel mj_objectArrayWithKeyValuesArray:result.ModelList];
                        foodMarketDataSource = [NSMutableArray array];
                        for (FoodMarketModel* classModel in array)
                        {
                            [foodMarketDataSource addObject:classModel.marketname];
                        }
                        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择菜场" style:MHSheetStyleDefault itemTitles:foodMarketDataSource];
                        actionSheet.cancleTitle = @"取消选择";
                        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
                         {
                             FoodMarketModel* classModel = array[index];
                             self.lon = classModel.lon;
                             self.lat = classModel.lat;
                             self.address = classModel.detailaddress;
                             self.foodMarket = title;
                             self.selectMarketIndex = index;
                             [cell setChooseTitleLabel:@"所属菜场:" andContentLabel:self.foodMarket];
                             
                             [self.tableView reloadData];
                         }];
                        [loadView stopAnimation];
                    }
                    else
                    {
                        [MBProgressHUD showError:@"暂无菜场数据"];
                        [loadView stopAnimation];
                    }
                    
                } failure:^(NSError *error) {
                    [loadView stopAnimation];
                }];
            }
            else
            {
                [cell setChooseTitleLabel:@"菜场地址:" andContentLabel:self.address];
                [self.tableView reloadData];
            }
        }
    }
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
/** 上传图片 */
- (void)tap:(UITapGestureRecognizer* )tapGesture
{
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
                
            }else{
                
                UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"抱歉,您还没有相机权限" message:@"请您在设置里面打开权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [selct addAction:action];
                [self presentViewController:selct animated:YES completion:nil];
            }
            
            
            
        }else{
            
            HDCLog(@"本地上传");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                HDCLog(@"进去图片库");
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _imagePickController.sourceType = sourceType;
                
                [self presentViewController:_imagePickController animated:YES completion:nil];
                
                
            }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
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
        default:
            break;
    }
}
/** 下一步按钮 */
- (void)nextBtnClick:(UIButton* )sender
{
    if (self.marketname.length == 0 || self.telephone.length == 0 || self.address.length == 0 || self.foodMarket.length == 0 || self.province.length == 0 || self.city.length == 0 || self.country.length == 0)
    {
        UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"请注意 !!!" message:@"请您填写完整的资料" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [selct addAction:action];
        [self presentViewController:selct animated:YES completion:nil];
        return;
    }
    else
    {
        LoadView *loadView = [[LoadView alloc] init];
        [loadView startAnimation];
        [UpLoadImageUtil upLoadImage:self.imageView.image success:^(id response) {
            
            if ([response[@"success"] intValue] == 1)
            {
                ImproveinformationParams *params = [[ImproveinformationParams alloc] init];
                params.marketuserid = self.marketuserid;
                params.marketname = self.marketname;
                params.telephone2 = self.telephone;
                params.detailaddress = self.address;
                params.marketsubid = [NSString stringWithFormat:@"%ld",_selectMarketIndex];
                params.marketsubname = self.foodMarket;
                params.categoryid = [NSString stringWithFormat:@"%ld", self.selectClassIndex];
                params.pic = response[@"data"][0][@"littlepic"];
                params.province = self.province;
                params.city = self.city;
                params.country = self.country;
                params.lon = self.lon;
                params.lat = self.lat;
                [RequestTool improveInformation:params success:^(ResultsModel *result)
                 {
                     if ([result.ErrorCode isEqualToString:@"1"])
                     {
                         [loadView stopAnimation];
                         [MBProgressHUD showSuccess:result.ErrorMsg];
                         RealnameViewController *realnameVC = [[RealnameViewController alloc] init];
                         realnameVC.tele = self.registerTelephone;
                         realnameVC.userType = self.usertype;
                         realnameVC.userid = self.marketuserid;
                         [self.navigationController pushViewController:realnameVC animated:YES];
                     }
                     else
                     {
                         [loadView stopAnimation];
                     }
                 } failure:^(NSError *error) {
                     ;
                 }];
            }
        } failure:^{
            ;
        }];
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
