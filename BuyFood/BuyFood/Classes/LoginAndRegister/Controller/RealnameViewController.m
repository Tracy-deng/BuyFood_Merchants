//
//  RealnameViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "RealnameViewController.h"
#import "userTextField.h"
#import "tapImageView.h"
#import "UpLoadImageUtil.h"
#import "RequestTool.h"
#import "ResultsModel.h"
#import "MHActionSheet.h"
#import "realNameParams.h"
#import "MBProgressHUD.h"
#import "CheckStatusViewController.h"

@interface RealnameViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong) userTextField * nameTF;
@property (nonatomic, strong) userTextField * cardTF;
@property (nonatomic, strong) UIImageView * firstImage; // 上传身份证
@property (nonatomic, strong) UIImageView * secondImage;
@property (nonatomic, strong) UIImageView * thirdImage;

@property (nonatomic, strong) UIImageView * forthImage;// 示例图片
@property (nonatomic, strong) UIImageView * fiveImage;
@property (nonatomic, strong) UIImageView * sixImage;

@property (nonatomic, strong) UIImageView * sevenImage; // 上传营业执照

@property (nonatomic, strong) UIImageView * eightImage;

@property (nonatomic, strong) UIImageView * nineImage;// 其他
@property (nonatomic, strong) UIImageView * tenImage;

/** 照片选择器 */
@property (nonatomic, strong) UIImagePickerController *imagePickController;

@end

@implementation RealnameViewController
{
    NSInteger selectIndex;
    
    NSString *picStr1;
    NSString *picStr2;
    NSString *picStr3;
    NSString *picStr7;
    NSString *picStr9;
    NSString *picStr10;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCBackViewColor];
    [self setNavLeftBtn];
    [self setUI];
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
}
/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"实名认证";
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
- (void)setUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounces = NO;
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT));
        make.left.equalTo(self.view);
        
    }];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1.5*SCREEN_HEIGHT);
    
    
    UIView *backGround = [[UIView alloc]init];
    backGround.backgroundColor = [UIColor whiteColor];
    backGround.frame = CGRectMake(0, 10, SCREEN_WIDTH, 90);
    [scrollView addSubview:backGround];
    
    _nameTF = [userTextField textFieldWithheight:10];
    [backGround addSubview:_nameTF];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"姓名";
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [backGround addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.top.equalTo(_nameTF).offset(5);
        
    }];
    
    UIView * linewView1 = [[UIView alloc]init];
    
    linewView1.backgroundColor = [UIColor grayColor];
    
    linewView1.alpha = 0.4;
    
    [backGround addSubview:linewView1];
    
    [linewView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTF.mas_bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH -20));
        make.left.equalTo(backGround).offset(5);
        make.height.equalTo(@0.4);
    }];
    
    
    _cardTF = [userTextField textFieldWithheight:58];
    [backGround addSubview:_cardTF];
    
    UILabel * cardLabel = [UILabel new];
    cardLabel.text = @"身份证号码";
    cardLabel.textColor = [UIColor grayColor];
    cardLabel.font = [UIFont systemFontOfSize:14];
    [backGround addSubview:cardLabel];
    
    
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(nameLabel);
        make.top.equalTo(_cardTF).offset(5);
    }];
    
    UIView * linewView2 = [[UIView alloc]init];
    
    linewView2.backgroundColor = [UIColor grayColor];
    
    linewView2.alpha = 0.4;
    
    [backGround addSubview:linewView2];
    
    [linewView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardTF.mas_bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH -20));
        make.left.equalTo(backGround).offset(5);
        make.height.equalTo(@0.4);
    }];
    
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"请上传您的身份证照片";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backGround.mas_bottom).offset(2);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    
    
    /**
     *  添加身份证图片
     */
    self.firstImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.firstImage];
    [self.firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    self.firstImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstImageIntoPhoto:)];
    [self.firstImage addGestureRecognizer:firstTap];
    
    self.secondImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.secondImage];
    [self.secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstImage);
        make.left.equalTo(_firstImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    self.secondImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *secTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secImageIntoPhoto:)];
    [self.secondImage addGestureRecognizer:secTap];
    
    
    
    self.thirdImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.thirdImage];
    [self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstImage);
        make.left.equalTo(_secondImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    self.thirdImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *thirdTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdImageIntoPhoto:)];
    [self.thirdImage addGestureRecognizer:thirdTap];
    
    UILabel * exampleLabel = [UILabel new];
    exampleLabel.text = @"示例图片";
    exampleLabel.font = [UIFont systemFontOfSize:12];
    exampleLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:exampleLabel];
    [exampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstImage.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    /**
     *   示例图片
     */
    
    /**
     *  添加身份证图片
     */
    self.forthImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"The-sample-one"]];
    [scrollView addSubview:self.forthImage];
    [self.forthImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exampleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    
    self.fiveImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"The-sample-two"]];
    [scrollView addSubview:self.fiveImage];
    [self.fiveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_forthImage);
        make.left.equalTo(_forthImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    self.sixImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"The-sample-three"]];
    [scrollView addSubview:self.sixImage];
    [self.sixImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_forthImage);
        make.left.equalTo(_fiveImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    UILabel * photoLabel = [UILabel new];
    photoLabel.text = @"请上传您的营业执照";
    photoLabel.font = [UIFont systemFontOfSize:12];
    photoLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:photoLabel];
    [photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_forthImage.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@25);
    }];
    
    self.sevenImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.sevenImage];
    [self.sevenImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    self.sevenImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *sevenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sevenImageIntoPhoto:)];
    [self.sevenImage addGestureRecognizer:sevenTap];
    /**
     *  示例图片
     *
     *  @return
     */
    
    UILabel * newLabel = [UILabel new];
    newLabel.text = @"示例图片";
    newLabel.font = [UIFont systemFontOfSize:12];
    newLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:newLabel];
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sevenImage.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@25);
    }];
    
    
    self.eightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"The-sample-fore"]];
    [scrollView addSubview:self.eightImage];
    [self.eightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    UIView * linewView3 = [[UIView alloc]init];
    
    linewView3.backgroundColor = [UIColor grayColor];
    
    linewView3.alpha = 0.4;
    
    [scrollView addSubview:linewView3];
    
    [linewView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_eightImage.mas_bottom).offset(3);
        make.width.equalTo(@(SCREEN_WIDTH -20));
        make.left.equalTo(self.view).offset(5);
        make.height.equalTo(@0.4);
    }];
    
    /**
     *  其他
     */
    
    UILabel * otherLabel = [UILabel new];
    otherLabel.text = @"其他";
    otherLabel.font = [UIFont systemFontOfSize:12];
    otherLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:otherLabel];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linewView3.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@25);
    }];
    
    self.nineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.nineImage];
    [self.nineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(otherLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    self.nineImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *nineTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nineImageIntoPhoto:)];
    [self.nineImage addGestureRecognizer:nineTap];
    
    self.tenImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.tenImage];
    [self.tenImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nineImage);
        make.left.equalTo(_nineImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    self.tenImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tenImageIntoPhoto:)];
    [self.tenImage addGestureRecognizer:tenTap];
    
    UIButton * reciveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [reciveBtn setTitle:@"确认上传" forState:(UIControlStateNormal)];
    reciveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [reciveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    reciveBtn.backgroundColor = [UIColor colorWithRed:0.384 green:0.659 blue:0.235 alpha:1.000];
    reciveBtn.layer.masksToBounds = YES;
    reciveBtn.layer.cornerRadius = 5;
    [scrollView addSubview:reciveBtn];
    [reciveBtn addTarget:self action:@selector(didReciveBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [reciveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tenImage.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@40);
    }];
    
}
/** 添加第一张 */
- (void)firstImageIntoPhoto:(UITapGestureRecognizer *)tap
{
    selectIndex = 1;
    [self imagePick];
}
/** 添加第二张 */
- (void)secImageIntoPhoto:(UITapGestureRecognizer *)tap
{
    selectIndex = 2;
    [self imagePick];
}
/** 添加第三张 */
- (void)thirdImageIntoPhoto:(UITapGestureRecognizer *)tap
{
    selectIndex = 3;
    [self imagePick];
}
/** 添加营业执照 */
- (void)sevenImageIntoPhoto:(UITapGestureRecognizer *)tap
{
    selectIndex = 7;
    [self imagePick];
}
/** 添加其他一 */
- (void)nineImageIntoPhoto:(UITapGestureRecognizer *)tap
{
    selectIndex = 9;
    [self imagePick];
}
/** 添加其他二 */
- (void)tenImageIntoPhoto:(UITapGestureRecognizer *)tap
{
    selectIndex = 10;
    [self imagePick];
}

// 点击提交按钮
- (void)didReciveBtn:(UIButton *)sender
{
    realNameParams *params = [[realNameParams alloc] init];
    params.sfz1 = picStr1;
    params.sfz2 = picStr2;
    params.scsfzpic = picStr3;
    params.realname = self.nameTF.text;
    params.IDCard = self.cardTF.text;
    params.userid = self.userid;
    params.usertype = self.userType;
    params.telephone = self.tele;
    params.businesss = picStr7;
    params.pic1 = picStr9;
    params.pic2 = picStr10;
    if (self.cardTF.text.length != 18 || picStr1.length == 0 || picStr2.length == 0 || picStr3.length == 0 || picStr7.length == 0 || picStr9.length == 0 || picStr10.length == 10)
    {
        if (self.cardTF.text.length != 18)
        {
            [MBProgressHUD showError:@"身份证号码填写错误"];
        }
        else
        {
            [MBProgressHUD showError:@"等待图片上传完毕"];
        }
    }
    else
    {
        [RequestTool realname:params success:^(ResultsModel *result) {
            if ([result.ErrorCode isEqualToString:@"1"])
            {
                [self.navigationController pushViewController:[[CheckStatusViewController alloc] init] animated:YES];
            }
        } failure:^(NSError *error) {
            ;
        }];
    }
}

- (void)imagePick
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
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                HDCLog(@"进去图片库");
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                _imagePickController.sourceType = sourceType;
                
                [self presentViewController:_imagePickController animated:YES completion:nil];
            }
            else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
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
    // 当图片不为空时显示图片并保存图片
    if (image != nil)
    {
        [UpLoadImageUtil upLoadImage:image success:^(id response) {
            if ([response[@"success"] intValue] == 1)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *str = response[@"data"][0][@"littlepic"];
                    switch (selectIndex)
                    {
                        case 1:
                            picStr1 = str;
                            [self.firstImage setImage:image];
                            break;
                        case 2:
                            picStr2 = str;
                            [self.secondImage setImage:image];
                            break;
                        case 3:
                            picStr3 = str;
                            [self.thirdImage setImage:image];
                            break;
                        case 7:
                            picStr7 = str;
                            [self.sevenImage setImage:image];
                            break;
                        case 9:
                            picStr9 = str;
                            [self.nineImage setImage:image];
                            break;
                        case 10:
                            picStr10 = str;
                            [self.tenImage setImage:image];
                            break;
                        default:
                            break;
                    }
                });
                
            }
        } failure:^{
            
        }];
    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 相机选择取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
