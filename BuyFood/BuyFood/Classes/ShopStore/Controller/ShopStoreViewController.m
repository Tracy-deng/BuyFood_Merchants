//
//  ShopStoreViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopStoreViewController.h"
#import "TagLabels.h"
#import "Line.h"
#import "Button.h"
#import "BalanceAccountViewController.h"
#import "MyBillViewController.h"
#import "EvaluationViewController.h"
#import "BusinessStatusViewController.h"
#import "ShopsManagementViewController.h"
#import "SaleManagementViewController.h"
#import "PriceGuideViewController.h"
#import "AddPrinterViewController.h"
#import "RequestTool.h"
#import "ShopsSecAndThirdClassParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"

@interface ShopStoreViewController ()
/** 今日营业额数字 */
@property (nonatomic, strong) TagLabels* todayTurnoverNum;
/** 今日订单数数字 */
@property (nonatomic, strong) TagLabels* todayOrderNum;
/** 今日营业额标签 */
@property (nonatomic, strong) TagLabels* todayTurnoverTag;
/** 今日订单数标签 */
@property (nonatomic, strong) TagLabels* todayOrderTag;

@end

@implementation ShopStoreViewController
{
    UIImageView *navBarHairlineImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(68, 192, 88)];
    /** 设置去掉导航条下面的线*/
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self setUpContentView];
}
/** 设置去掉导航条下面的线 */
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews)
    {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}
- (void)setUpContentView
{
    // 今日营业额数字
    self.todayTurnoverNum = [TagLabels initTaglabel];
    [self.todayTurnoverNum createLabelText:@"2399" andLabelX:self.view.width * 0.18 andLabelY:self.view.height * 0.14 andLabelHeight:self.view.height * 0.05 andLabelWidth:self.view.width * 0.14 andLabelTextStytle:@"DINCondensed-Bold" andLabelFontsize:25 andtextColor:[UIColor whiteColor]];
    [self.view addSubview:self.todayTurnoverNum];
    
    // 今日营业额数字
    self.todayOrderNum = [TagLabels initTaglabel];
    [self.todayOrderNum createLabelText:@"93" andLabelX:self.view.width * 0.72 andLabelY:self.todayTurnoverNum.y andLabelHeight:self.todayTurnoverNum.height andLabelWidth:self.todayTurnoverNum.width andLabelTextStytle:@"DINCondensed-Bold" andLabelFontsize:25 andtextColor:[UIColor whiteColor]];
    [self.view addSubview:self.todayOrderNum];
    
    // 今日营业额标签
    self.todayTurnoverTag = [TagLabels initTaglabel];
    [self.todayTurnoverTag createLabelText:@"今日营业额" andLabelX:self.view.width * 0.13 andLabelY:self.view.height * 0.18 andLabelHeight:self.view.height * 0.03 andLabelWidth:self.view.width * 0.25 andLabelTextStytle:@"PingFangSC-Regular" andLabelFontsize:15     andtextColor:HDCColor(240, 240, 240)];
    [self.view addSubview:self.todayTurnoverTag];
    
    // 今日订单数标签
    self.todayOrderTag = [TagLabels initTaglabel];
    [self.todayOrderTag createLabelText:@"今日成交量" andLabelX:self.view.width * 0.66 andLabelY:self.todayTurnoverTag.y andLabelHeight:self.todayTurnoverTag.height andLabelWidth:self.todayTurnoverTag.width andLabelTextStytle:@"PingFangSC-Regular" andLabelFontsize:15     andtextColor:HDCColor(240, 240, 240)];
    [self.view addSubview:self.todayOrderTag];
    
    
    /** 账户余额&&我的账单 View*/
    UIView* balanceAndBillView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.25, self.view.width, self.view.height * 0.08)];
    [balanceAndBillView setBackgroundColor:HDCColor(29, 172, 53)];
    [self.view addSubview:balanceAndBillView];
    
    // 分割线
    Line* line = [Line initLine];
    [line createLineX:self.view.width * 0.49 andLineY:5 andLineHeight:balanceAndBillView.height - 10 andLineWidth:1 andBackgroundColor:HDCColor(35, 193, 60)];
    [balanceAndBillView addSubview:line];
    
    // 设置 账户余额 我的账单两个按钮
    Button* balanceButton = [Button initButton];
    [balanceButton setButtonTitle:@"账户余额" andButtonX:10 andButtonY:10 andButtonHeight:balanceAndBillView.height - 2 * 10 andButtonWidth:balanceAndBillView.width * 0.5 - 2 * 10 andButtonNormalImage:nil andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:WhiteColor];
    [balanceButton addTarget:self action:@selector(balanceButton:) forControlEvents:UIControlEventTouchUpInside];
    [balanceAndBillView addSubview:balanceButton];
    
    Button* billButton = [Button initButton];
    [billButton setButtonTitle:@"我的账单" andButtonX:balanceAndBillView.width * 0.5 + 10 andButtonY:balanceButton.y andButtonHeight:balanceButton.height andButtonWidth:balanceButton.width andButtonNormalImage:nil andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:WhiteColor];
    [billButton addTarget:self action:@selector(billButton:) forControlEvents:UIControlEventTouchUpInside];
    [balanceAndBillView addSubview:billButton];
    
    UIView* otherView = [[UIView alloc] initWithFrame:CGRectMake(0, balanceAndBillView.y + balanceAndBillView.height, self.view.width, self.view.height - self.view.height * 0.25 - balanceAndBillView.height)];
    [otherView setBackgroundColor:HDCColor(239, 240, 241)];
    [self.view addSubview:otherView];
    
    /** 设置 六个按钮 的View */
    UIView* sixView = [[UIView alloc] init];
    [sixView setBackgroundColor:[UIColor whiteColor]];
    sixView.x = 0;
    sixView.y = 20;
    sixView.width = otherView.width;
    sixView.height = self.view.height * 0.38;
    [otherView addSubview:sixView];
    // 设置分割线
    Line* line1 = [Line initLine];
    [line1 createLineX:5 andLineY:sixView.height * 0.49 andLineHeight:1 andLineWidth:sixView.width - 2 * 5 andBackgroundColor:HDCColor(230, 230, 230)];
    [sixView addSubview:line1];
    
    Line* line2 = [Line initLine];
    [line2 createLineX:sixView.width / 3 andLineY:5 andLineHeight:sixView.height - 2 * 5 andLineWidth:1 andBackgroundColor:HDCColor(230, 230, 230)];
    [sixView addSubview:line2];
    
    Line* line3 = [Line initLine];
    [line3 createLineX:sixView.width - sixView.width / 3 andLineY:line2.y andLineHeight:line2.height andLineWidth:line2.width andBackgroundColor:HDCColor(230, 230, 230)];
    [sixView addSubview:line3];
    
    /** 设置六个button
        1.打印机按钮
        2.留言评价按钮
        3.营业状态按钮
        4.商品管理按钮
        5.促销管理按钮
        6.定价指导按钮
     */
    // 1.打印机按钮
    Button* printerButton = [Button initButton];
    [printerButton setButtonTitle:nil andButtonX:sixView.width * 0.1 andButtonY:sixView.height * 0.08 andButtonHeight:self.view.height* 0.07 andButtonWidth:self.view.width* 0.13 andButtonNormalImage:[UIImage imageNamed:@"dayinji"] andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:nil];
    [printerButton addTarget:self action:@selector(printerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sixView addSubview:printerButton];
    // 2.留言评价按钮
    Button* messageEvaluationButton = [Button initButton];
    [messageEvaluationButton setButtonTitle:nil andButtonX:sixView.width * 0.43 andButtonY:printerButton.y andButtonHeight:printerButton.height andButtonWidth:printerButton.width andButtonNormalImage:[UIImage imageNamed:@"icon_shopstore_message"] andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:nil];
    [messageEvaluationButton addTarget:self action:@selector(messageEvaluationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sixView addSubview:messageEvaluationButton];
    // 3.营业状态按钮
    Button* shopSatesButton = [Button initButton];
    [shopSatesButton setButtonTitle:nil andButtonX:sixView.width * 0.78 andButtonY:printerButton.y andButtonHeight:printerButton.height andButtonWidth:printerButton.width andButtonNormalImage:[UIImage imageNamed:@"icon_shopstore_shopstate"] andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:nil];
    [shopSatesButton addTarget:self action:@selector(shopSatesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sixView addSubview:shopSatesButton];
    // 4.商店铺信息按钮
    Button* shopsInfoButton = [Button initButton];
    [shopsInfoButton setButtonTitle:nil andButtonX:printerButton.x andButtonY:sixView.height * 0.57 andButtonHeight:printerButton.height andButtonWidth:printerButton.width andButtonNormalImage:[UIImage imageNamed:@"icon_shopstore_shopsmanage"] andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:nil];
    [shopsInfoButton addTarget:self action:@selector(shopsInfoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sixView addSubview:shopsInfoButton];
    // 5.商品管理按钮
    Button* shopsManageButton = [Button initButton];
    [shopsManageButton setButtonTitle:nil andButtonX:messageEvaluationButton.x  andButtonY:shopsInfoButton.y andButtonHeight:shopsInfoButton.height andButtonWidth:shopsInfoButton.width andButtonNormalImage:[UIImage imageNamed:@"icon_shopstore_shopsale"] andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:nil];
    [shopsManageButton addTarget:self action:@selector(shopsManageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sixView addSubview:shopsManageButton];
    // 6.促销管理按钮
    Button* shopSaleButton = [Button initButton];
    [shopSaleButton setButtonTitle:nil andButtonX:shopSatesButton.x  andButtonY:shopsInfoButton.y andButtonHeight:shopsInfoButton.height andButtonWidth:shopsInfoButton.width andButtonNormalImage:[UIImage imageNamed:@"dingjiazhidao"] andSelectedImage:nil andButtonbackGroundImage:nil andButtonTitleTextColor:nil];
    [shopSaleButton addTarget:self action:@selector(shopSaleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sixView addSubview:shopSaleButton];
    
    /** 六个按钮下面的label*/
    TagLabels* printerLabel = [TagLabels initTaglabel];
    [printerLabel createLabelText:@"打印机" andLabelX:printerButton.x - 5 andLabelY:printerButton.y + printerButton.height + 10 andLabelHeight:self.view.height * 0.03 andLabelWidth:self.view.width * 0.15 andLabelTextStytle:nil andLabelFontsize:15 andtextColor:HDCColor(102, 102, 102)];
    [sixView addSubview:printerLabel];
    TagLabels* messageEvaluationLabel = [TagLabels initTaglabel];
    [messageEvaluationLabel createLabelText:@"留言评价" andLabelX:messageEvaluationButton.x - 10 andLabelY:printerLabel.y andLabelHeight:printerLabel.height andLabelWidth:printerLabel.width + 20 andLabelTextStytle:nil andLabelFontsize:15 andtextColor:HDCColor(102, 102, 102)];
    [sixView addSubview:messageEvaluationLabel];
    TagLabels* shopSatesLabel = [TagLabels initTaglabel];
    [shopSatesLabel createLabelText:@"营业状态" andLabelX:shopSatesButton.x - 10 andLabelY:printerLabel.y andLabelHeight:printerLabel.height andLabelWidth:printerLabel.width + 20 andLabelTextStytle:nil andLabelFontsize:15 andtextColor:HDCColor(102, 102, 102)];
    [sixView addSubview:shopSatesLabel];
    
    TagLabels* shopsInfoLabel = [TagLabels initTaglabel];
    [shopsInfoLabel createLabelText:@"商品管理" andLabelX:printerLabel.x - 10 andLabelY:shopsInfoButton.y + shopsInfoButton.height + 10 andLabelHeight:printerLabel.height andLabelWidth:printerLabel.width + 20 andLabelTextStytle:nil andLabelFontsize:15 andtextColor:HDCColor(102, 102, 102)];
    [sixView addSubview:shopsInfoLabel];
    TagLabels* shopsManageLabel = [TagLabels initTaglabel];
    [shopsManageLabel createLabelText:@"活动管理" andLabelX:shopsManageButton.x - 10 andLabelY:shopsInfoButton.y + shopsInfoButton.height + 10 andLabelHeight:printerLabel.height andLabelWidth:printerLabel.width + 20 andLabelTextStytle:nil andLabelFontsize:15 andtextColor:HDCColor(102, 102, 102)];
    [sixView addSubview:shopsManageLabel];
    
    TagLabels* shopSaleLabel = [TagLabels initTaglabel];
    [shopSaleLabel createLabelText:@"定价指导" andLabelX:shopSaleButton.x - 10 andLabelY:shopsInfoButton.y + shopsInfoButton.height + 10 andLabelHeight:printerLabel.height andLabelWidth:printerLabel.width + 20 andLabelTextStytle:nil andLabelFontsize:15 andtextColor:HDCColor(102, 102, 102)];
    [sixView addSubview:shopSaleLabel];
}
/** 账户余额按钮点击 */
- (void)balanceButton:(UIButton* )sender
{
    HDCLog(@"账户余额按钮点击");
    [self.navigationController pushViewController:[[BalanceAccountViewController alloc] init] animated:YES];
}
/** 我的账单按钮点击 */
- (void)billButton:(UIButton* )sender
{
    HDCLog(@"我的账单按钮点击");
    [self.navigationController pushViewController:[[MyBillViewController alloc] init] animated:YES];
}

/** 打印机按钮点击 */
- (void)printerButtonClick:(UIButton* )sender
{
    HDCLog(@"打印机按钮点击");
    [self.navigationController pushViewController:[[AddPrinterViewController alloc] init] animated:YES];
}
/** 留言评价按钮点击 */
- (void)messageEvaluationButtonClick:(UIButton* )sender
{
    HDCLog(@"留言评价按钮点击");
    [self.navigationController pushViewController:[[EvaluationViewController alloc] init] animated:YES];
}
/** 营业状态按钮点击 */
- (void)shopSatesButtonClick:(UIButton* )sender
{
    HDCLog(@"营业状态按钮点击");
    [self.navigationController pushViewController:[[BusinessStatusViewController alloc] init] animated:YES];
}
/** 商品管理按钮点击 */
- (void)shopsInfoButtonClick:(UIButton* )sender
{
    HDCLog(@"商品管理按钮点击");
    [self.navigationController pushViewController:[[ShopsManagementViewController alloc] init] animated:YES];
}
/** 促销按钮点击 */
- (void)shopsManageButtonClick:(UIButton* )sender
{
    HDCLog(@"促销按钮点击");
    [self.navigationController pushViewController:[[SaleManagementViewController alloc] init] animated:YES];
}
/** 定价指导按钮点击 */
- (void)shopSaleButtonClick:(UIButton* )sender
{
    HDCLog(@"定价指导按钮点击");
    [self.navigationController pushViewController:[[PriceGuideViewController alloc] init] animated:YES];
}

/**
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    HDCLog(@"...");
    ShopsSecAndThirdClassParams* params = [[ShopsSecAndThirdClassParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.categoryid = shopsInfo.categoryid;
    [RequestTool shopsSecAndThirdClass:params success:^(ResultsModel *result) {
        HDCLog(@"%@", result.ModelList);
    } failure:^(NSError *error) {
        ;
    }];
}
*/
@end
