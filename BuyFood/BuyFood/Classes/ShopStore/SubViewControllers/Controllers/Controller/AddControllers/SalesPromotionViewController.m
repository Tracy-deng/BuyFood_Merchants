//
//  SalesPromotionViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/24.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SalesPromotionViewController.h"
#import "SalesPromotionCell.h"
#import "PromotionTextFieldViewCell.h"
#import "MHActionSheet.h"
#import "LoadView.h"
#import "ModlistModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "RequestTool.h"
#import "ShopsSecAndThirdClassParams.h"
#import "ThreeCatego.h"
#import "ResultsModel.h"
#import "MJExtension.h"
@interface SalesPromotionViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    LoadView *loadView;
    UIButton *bottomBtn;
}
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
/** 商品名称 */
@property (nonatomic, strong) NSString* productname;
/** 商品库存（即重量、份、数量等）*/
@property (nonatomic, strong) NSString* productstock;
/** 商品原售价格 */
@property (nonatomic, strong) NSString* productoutprice;
/** 商品现价 */
@property (nonatomic, strong) NSString* productoutprice2;

/** 商品描述 */
@property (nonatomic, strong) NSString* productremark;
@property (nonatomic, strong) UIImagePickerController *imagePickController;
@property (nonatomic, strong) NSMutableArray * threeArray;
@property (nonatomic, strong) NSMutableArray *twoArray;
@property (nonatomic, strong) ModlistModel *modlst;
@end

@implementation SalesPromotionViewController
{
    NSMutableDictionary<NSString *, NSMutableArray<ModlistModel *> *> *billData;
}

- (NSMutableArray *)twoArray
{
    if (_twoArray == nil) {
        self.twoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _twoArray;
}
- (NSMutableArray *)threeArray
{
    if (_threeArray == nil) {
        self.threeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _threeArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加促销商品";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self configureData];
    [self addShopsImage];
    [self createTableViewAndBottomBtn];
    [self.tableView registerClass:[PromotionTextFieldViewCell class] forCellReuseIdentifier:@"PromotionTextFieldViewCell"];
}
// 数据请求 左控制器数据
- (void)configureData
{
    ShopsSecAndThirdClassParams* params = [[ShopsSecAndThirdClassParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.categoryid = shopsInfo.categoryid;
    [RequestTool shopsSecAndThirdClass:params success:^(ResultsModel *result) {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        dataArray  = [ThreeCatego mj_objectArrayWithKeyValuesArray:result.ModelList];
        for (ThreeCatego *modle in dataArray) {
            
            for (NSDictionary *dic in modle.ModelList) {
                NSString *subCate = dic[@"subcategoryid"];
                HDCLog(@"subcategoryid == %@",subCate);
                if (![billData.allKeys containsObject:subCate]){
                    [billData setObject:[NSMutableArray new] forKey:subCate];
                }
                self.modlst = [[ModlistModel alloc]init];
                self.modlst.subcategoryid  = subCate;
                self.modlst.subcategoryname = dic[@"subcategoryname"];
                HDCLog(@"subcategoryname == %@",self.modlst.subcategoryname);
                self.modlst.threecategoryid = dic[@"threecategoryid"];
                HDCLog(@"threecategoryid == %@",self.modlst.threecategoryid);
                self.modlst.threecategoryname = dic[@"threecategoryname"];
                HDCLog(@"threecategoryname == %@",self.modlst.threecategoryname);
                NSMutableArray<ModlistModel *> *date = [billData objectForKey:subCate];
                [date addObject:self.modlst];
            }
            
            
        }
    } failure:^(NSError *error) {
        ;
    }];
}

- (void)addDataSales
{
    NSArray *sortKeys = [self getSortedKeys:billData];
    
    
    if (sortKeys.count != 0) {
        for(int i = 0; i < sortKeys.count; i ++)
        {
            NSString *catego = [sortKeys objectAtIndex:i];
            ModlistModel *model =  [[billData objectForKey:catego] firstObject];
            [self.twoArray addObject :model.subcategoryname ];
            
        }
    }
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
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
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
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7)
    {
        PromotionTextFieldViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PromotionTextFieldViewCell" forIndexPath:indexPath];
//        PromotionTextFieldViewCell *cell = [PromotionTextFieldViewCell cellWithTableView:tableView andIndexPath:indexPath];
        
        cell.contentTextField.tag = indexPath.row;
        cell.contentTextField.delegate = self;
        [cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
        switch (cell.contentTextField.tag)
        {
            case 0:
                [cell setTitleLabel:@"商品名称:" andContentTextFieldPlaceholder:@"请输入商品名称"];
                break;
            case 3:
                [cell setTitleLabel:@"商品原价:" andContentTextFieldPlaceholder:@"请输入商品原价格"];
                break;
            case 4:
                [cell setTitleLabel:@"商品现价:" andContentTextFieldPlaceholder:@"请输入商品现价格"];
                break;
            case 6:
                [cell setTitleLabel:@"重量:" andContentTextFieldPlaceholder:@"请输入商品重量"];
                break;
            case 7:
                [cell setTitleLabel:@"描述:" andContentTextFieldPlaceholder:@"二十字以内"];
                break;
            default:
                break;
        }
        return cell;
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
            case 5:
                [cell setTitleLabel:@"单位:" andContentLabel:self.unitStr];
                break;
            default:
                break;
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 7)
    {
        [self.view endEditing:YES];
    }
}

#pragma textField输入
- (void)changeValue:(UITextField *)textField
{
    HDCLog(@"%@", textField.text);
    switch (textField.tag)
    {
        case 0:
            self.productname = textField.text;
            break;
        case 3:
            self.productoutprice= textField.text;
            break;
        case 4:
            self.productoutprice2 = textField.text;
            break;
        case 6:
            self.productstock = textField.text;
            break;
        case 7:
            self.productremark = textField.text;
            break;
        default:
            break;
    }
}

#pragma mark -- 点击键盘上的return按钮  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
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

-(NSArray *)getSortedKeys:(NSMutableDictionary *)dictionary
{
    NSArray *keys = [dictionary.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *first = obj1;
        NSString *second = obj2;
        int firstValue = [first intValue];
        int secondValue = [second intValue];
        if (firstValue < secondValue) {
            return NSOrderedAscending;
        }else if(firstValue > secondValue){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    return keys;
}

@end
