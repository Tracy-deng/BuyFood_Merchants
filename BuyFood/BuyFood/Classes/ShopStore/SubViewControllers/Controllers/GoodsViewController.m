//
//  GoodsViewController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "GoodsViewController.h"
#import "SalesPromotionCell.h"
#import "MHActionSheet.h"
#import "PromotionTextFieldViewCell.h"
#import "RequestTool.h"
#import "AddProductParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"

@interface GoodsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* imageView;
/** 单位*/
@property (nonatomic, strong) NSString* unitStr;
/** 标签 */
@property (nonatomic, strong) NSString* shopsTag;
/** 二级分类 */
@property (nonatomic, strong) NSString* secClass;
/** 三级分类 */
@property (nonatomic, strong) NSString* thirdClass;
@property (nonatomic, strong) NSArray* secClassArray;
/** 二级分类id*/
@property (nonatomic, assign) NSInteger selectSecClassIndex;
/** 三级分类id */
@property (nonatomic, assign) NSInteger selectThirdClassIndex;
/** 商品名称 */
@property (nonatomic, strong) NSString* productname;
/** 商品库存（即重量、份、数量等）*/
@property (nonatomic, strong) NSString* productstock;
/** 商品原售价格 */
@property (nonatomic, strong) NSString* productoutprice;
/** 商品描述 */
@property (nonatomic, strong) NSString* productremark;
@property (nonatomic, strong) PromotionTextFieldViewCell* cell;

//@property (nonatomic, strong) ShopsUserInfo* shopsInfo;
//@property (nonatomic, strong) ShopsUserInfoTool* shopsInfoTool;


@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加商品";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self addShopsImage];
    [self createTableViewAndBottomBtn];
    
    [self setNavRightBtn];
}

/** 设置导航栏右边按钮 */
- (void)setNavRightBtn
{

    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [backBtn setTitle:@"完成" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
/** 撤销键盘 */
- (void)backBtnClick:(UIButton* )sender
{
#warning 点击右上角的完成按钮无法撤销键盘
    [self.cell.contentTextField resignFirstResponder];
}
- (void)addShopsImage
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addShopsImage"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
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
    
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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

- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    NSLog(@"点击添加图片");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning 当输入的时候有重影的问题....
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7)
    {
        self.cell = [PromotionTextFieldViewCell cellWithTableView:tableView];
        self.cell.contentTextField.tag = indexPath.row;
        [self.cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
        switch (indexPath.row)
        {
            case 0:
                [self.cell setTitleLabel:@"商品名称:" andContentTextFieldPlaceholder:@"请输入商品名称"];
                break;
            case 3:
                [self.cell setTitleLabel:@"价格:" andContentTextFieldPlaceholder:@"请输入商品价格"];
                break;
            case 5:
                [self.cell setTitleLabel:@"重量:" andContentTextFieldPlaceholder:@"请输入商品重量"];
                break;
            case 7:
                [self.cell setTitleLabel:@"描述:" andContentTextFieldPlaceholder:@"二十字以内"];
                break;
            default:
                break;
        }
        return self.cell;
    }
    else
    {
        SalesPromotionCell* cell = [SalesPromotionCell cellWithTableView:tableView];
        switch (indexPath.row)
        {
            case 1:
                [cell setTitleLabel:@"二级分类:" andContentLabel:self.secClass];
                break;
            case 2:
                [cell setTitleLabel:@"三级分类:" andContentLabel:self.thirdClass];
                break;
            case 4:
                [cell setTitleLabel:@"单位:" andContentLabel:self.unitStr];
                break;
            case 6:
                [cell setTitleLabel:@"标签" andContentLabel:self.shopsTag];
                break;
                
            default:
                break;
        }
        return cell;
    }
}

- (void)changeValue:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 0:
            self.productname = textField.text;
            break;
        case 3:
            self.productstock = textField.text;
            break;
        case 5:
            self.productoutprice = textField.text;
            break;
        case 7:
            self.productremark = textField.text;
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning 数值没有传过来，所以，这边的二级分类名称和二级分类id 还有 三级分类和三级分类id都是写死了.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1)
    {
        self.secClassArray = @[@"净菜",
                               @"熟食"];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品二级分类" style:MHSheetStyleWeiChat itemTitles:self.secClassArray];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             
             if ([title isEqualToString:@"净菜"])
             {
                 index = 5;
             }
             else
             {
                 index = 6;
             }
             self.selectSecClassIndex = index;
             HDCLog(@"%ld", self.selectSecClassIndex);
             self.secClass = title;
             [self.tableView reloadData];
         }];
    }
    if (indexPath.row == 2)
    {
        if ([self.secClassArray.firstObject isEqualToString:@"净菜"])
        {
            NSArray * array = @[@"方便菜",
                                @"丸糕类"
                                ];
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品二级分类" style:MHSheetStyleWeiChat itemTitles:array];
            actionSheet.cancleTitle = @"取消选择";
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
             {
                 if ([array.firstObject isEqualToString:@"方便菜"])
                 {
                     index = 22;
                 }
                 else
                 {
                     index = 23;
                 }
                 self.selectThirdClassIndex = index;
                 self.thirdClass = title;
                 [self.tableView reloadData];
                 HDCLog(@"%ld",self.selectThirdClassIndex);
             }];
        }
        else
        {
            NSArray * array = @[@"畜肉类",
                                @"禽肉类",
                                @"凉拌菜"];
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品三级分类" style:MHSheetStyleWeiChat itemTitles:array];
            actionSheet.cancleTitle = @"取消选择";
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
             {
                 if ([array.firstObject isEqualToString:@"畜肉类"])
                 {
                     index = 24;
                 }
                 else if ([array.lastObject isEqualToString:@"凉拌菜"])
                 {
                     index = 26;
                 }
                 else
                 {
                     index = 25;
                 }
                 self.selectThirdClassIndex = index;
                 HDCLog(@"%ld",self.selectThirdClassIndex);
                 self.thirdClass = title;
                 [self.tableView reloadData];
             }];
        }
    }
    if (indexPath.row == 4)
    {
        NSArray * array = @[@"份",
                                @"克"];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择单位" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.unitStr = title;
             [self.tableView reloadData];
         }];
    }
    if (indexPath.row == 6)
    {
        NSArray * array = @[@"普通",
                            @"促销",
                            @"热销"];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品标签" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.shopsTag = title;
             [self.tableView reloadData];
         }];
    }
}
/** 保存按钮 */
- (void)saveBtnClick:(UIButton* )sender
{
#warning 图片没上传,所以导致商品添加不成功。明天你试一下图片上传
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    AddProductParams* params = [[AddProductParams alloc] init];
    params.marketuserid = shopsInfo.marketuserid;
    params.subcategoryid = [NSString stringWithFormat:@"%ld", self.selectSecClassIndex];
    params.threecategoryid = [NSString stringWithFormat:@"%ld", self.selectThirdClassIndex];
    params.productname = self.productname;
    params.productstock = self.productstock;
    params.productoutprice = self.productoutprice;
    params.productremark = self.productremark;
    params.Productlabel = self.shopsTag;
    params.productunit = self.unitStr;
    params.promotion = @"1";
    params.productpic = @"";
    [RequestTool addProducts:params success:^(ResultsModel *result) {
        HDCLog(@"%@",result);
        if ([result.ErrorCode isEqualToString:@"1"])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        ;
    }];
}

@end
