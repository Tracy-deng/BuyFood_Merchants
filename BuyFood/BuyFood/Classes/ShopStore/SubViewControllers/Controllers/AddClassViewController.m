//
//  AddClassViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddClassViewController.h"
#import "MHActionSheet.h"
#import "MBProgressHUD.h"
#import "UpLoadImageUtil.h"
#import "RequestTool.h"
#import "AddCtcategoryParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"

@interface AddClassViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePickController;
@property (nonatomic, strong) ShopsUserInfo *userInfo;


@end

@implementation AddClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"添加分类";
    [self createTextField];
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    self.userInfo = [ShopsUserInfoTool account];
}

- (void)createTextField
{
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.delegate = self;
    self.inputTextField.placeholder = @"请输入品类";
    [self.view addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@(45));
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = HDCColor(224, 224, 224);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTextField);
        make.top.equalTo(self.inputTextField.mas_bottom);
        make.width.equalTo(self.inputTextField);
        make.height.equalTo(@(1));
    }];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addShopsImage"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.top.mas_equalTo(line.mas_bottom).offset(30);
        make.width.equalTo(@(SCREEN_WIDTH - 100));
        make.height.equalTo(@(100));
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
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:greenColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(45));
    }];
}

/** 上传图片 */
- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    HDCLog(@"。。。。");
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

- (void)buttonClick:(UIButton *)sender
{
    [MBProgressHUD showMessage:@"正在添加分类..."];
    if (self.inputTextField.text.length < 1)
    {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"请填写分类名称"];
    }
    else
    {
        [UpLoadImageUtil upLoadImage:self.imageView.image success:^(id response) {
            if ([response[@"success"] intValue] == 1)
            {
                AddCtcategoryParams *params = [[AddCtcategoryParams alloc] init];
                params.threecategoryname = self.inputTextField.text;
                if ([self.userInfo.markettypeid isEqualToString:@"2"])
                {
                    params.categoryid = @"0";
                }
                else
                {
                    params.categoryid = self.userInfo.categoryid;
                }
                HDCLog(@"%@", params.categoryid);
                params.subcategoryid = @"0";
                params.markettypeid = self.userInfo.markettypeid;
                params.userid = self.userInfo.marketuserid;
                [RequestTool addCtcategory:params success:^(ResultsModel *result) {
                    if ([result.ErrorCode isEqualToString:@"1"])
                    {
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showSuccess:@"添加成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showError:@"添加失败"];
                    }
                } failure:^(NSError *error) {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showError:@"添加失败"];
                }];
            }
        } failure:^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"图片上传失败"];
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
