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

@interface RealnameViewController ()


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

@end

@implementation RealnameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCBackViewColor];
    [self setNavLeftBtn];
    [self setUI];
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didIntoPhoto:)];
    
    
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
    [self.firstImage addGestureRecognizer:tap];
    
    
    self.secondImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.secondImage];
    [self.secondImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstImage);
        make.left.equalTo(_firstImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    self.thirdImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.thirdImage];
    [self.thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstImage);
        make.left.equalTo(_secondImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    
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
    
    self.tenImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addImage"]];
    [scrollView addSubview:self.tenImage];
    [self.tenImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nineImage);
        make.left.equalTo(_nineImage.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 10));
        make.height.equalTo(@60);
    }];
    
    
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

// 点击提交按钮
- (void)didReciveBtn:(UIButton *)sender
{
    NSLog(@"点击提交");
    
}

- (void)didIntoPhoto:(UITapGestureRecognizer *)tap
{
    NSLog(@"添加图片");
}


@end
