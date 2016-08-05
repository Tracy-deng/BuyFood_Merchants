//
//  BrandShopDetailViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/5.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BrandShopDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "MHActionSheet.h"
#import "RequestTool.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "UpdateProductParams.h"
#import "LoadView.h"
#import "UpLoadImageUtil.h"
#import "ResultsModel.h"
#import "DeleteProductParams.h"
#import "AddShopsCell.h"
@interface BrandShopDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    BOOL isValue;
    UIButton *bottomBtn;
}

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* imageView;

/** 商品名称 */
@property (nonatomic, strong) NSString *productname;
/** 商品id */
@property (nonatomic, strong) NSString *productid;
/** 分类id */
@property (nonatomic, strong) NSString *threecategoryid;
/** 商品价格 */
@property (nonatomic, strong) NSString *productoutprice;
/** 商品重量 */
@property (nonatomic, strong) NSString *unitStr;
/** 商品标签 */
@property (nonatomic, strong) NSString *shopsTag;
/** 商品描述 */
@property (nonatomic, strong) NSString *productremark;
@property (nonatomic, strong) NSString *productstock;


@property (nonatomic, strong) UIImagePickerController *imagePickController;
@end

@implementation BrandShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"编辑商品";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self addShopsImage];
    [self createTableViewAndBottomBtn];
    
    self.productname = self.modelList.productname;
    NSInteger priceNum = [self.modelList.productoutprice integerValue];
    NSString *price = [NSString stringWithFormat:@"%ld", priceNum];
    self.productoutprice = price;
    self.unitStr = self.modelList.productunit;
    self.shopsTag = self.modelList.productlabel;
    
    _imagePickController = [[UIImagePickerController alloc]init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing = YES;
    _imagePickController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
}


- (void)addShopsImage
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.modelList.productpic] placeholderImage:nil];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 0.25*SCREEN_HEIGHT - 64 - 100));
    }];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.tableFooterView = view;
    
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 3.0;
    [bottomBtn addTarget:self action:@selector(didBottomBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@40);
        
    }];
    
    UIButton* deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleBtn setBackgroundColor:[UIColor colorWithRed:1.000 green:0.442 blue:0.113 alpha:1.000]];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleBtn.layer.cornerRadius = 3.0;
    [deleBtn addTarget:self action:@selector(diddeleBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:deleBtn];
    [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomBtn.mas_top).offset(-5);
        make.left.right.height.equalTo(bottomBtn);
        
    }];
    
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.cornerRadius = 4;
    deleBtn.layer.masksToBounds = YES;
    deleBtn.layer.cornerRadius = 4;
    
    
}

- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    
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


- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"ID %ld", indexPath.row];
    AddShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5)
        {
            cell = [[AddShopsCell alloc] initWithInputCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.contentTextField.tag = indexPath.row;
            cell.contentTextField.delegate = self;
            [cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
            if (indexPath.row == 0)
            {
                cell.titleLabel.text = @"商品名称:";
                cell.contentTextField.text = self.productname;
            }
            else if (indexPath.row == 1)
            {
                
                cell.titleLabel.text = @"商品价格:";
                cell.contentTextField.text = self.productoutprice;
                cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            }
            else if (indexPath.row == 3)
            {
                cell.titleLabel.text = @"商品重量:";
                NSInteger stockNumber = [self.modelList.productstock integerValue];
                NSString *stock = [NSString stringWithFormat:@"%ld", stockNumber];
                cell.contentTextField.text = stock;
            }
            else if (indexPath.row == 5)
            {
                cell.titleLabel.text = @"商品描述:";
                cell.contentTextField.text = self.productremark;
            }
        }
        else
        {
            cell = [[AddShopsCell alloc]initWithChooseCellStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row)
            {
                case 2:
                    [cell setChooseTitleLabel:@"单位:" andContentLabel:self.unitStr];
                    break;
                case 4:
                    [cell setChooseTitleLabel:@"标签:" andContentLabel:self.shopsTag];
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
        case 1:
            self.productoutprice = textField.text;
            break;
        case 3:
            self.productstock = textField.text;
            break;
        case 5:
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
    isValue = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddShopsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 2)
    {
        NSArray * array = @[@"份",
                            @"克"];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择单位" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.unitStr = title;
             [cell setChooseTitleLabel:@"单位:" andContentLabel:self.unitStr];
             [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         }];
    }
    if (indexPath.row == 4)
    {
        NSArray * array = @[@"普通",
                            @"热销"];
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择商品标签" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.shopsTag = title;
             [cell setChooseTitleLabel:@"标签:" andContentLabel:self.shopsTag];
             [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         }];
    }
}

- (void)didBottomBtn:(UIButton *)sender
{
    bottomBtn.userInteractionEnabled = NO;
    bottomBtn.backgroundColor = [UIColor grayColor];
    LoadView *loadView = [LoadView new];
    [UpLoadImageUtil upLoadImage:self.imageView.image success:^(id response) {
        ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
        UpdateProductParams* params = [[UpdateProductParams alloc] init];
        params.productid = [self.modelList.productid integerValue];
        params.categoryid = shopsInfo.categoryid;
        params.marketuserid = shopsInfo.marketuserid;
        params.threecategoryid = self.modelList.threecategoryid;
        params.productname = self.productname;
        params.productstock = [self.productstock floatValue];
        params.productoutprice = [self.productoutprice floatValue];
        params.productremark = self.productremark;
        params.Productlabel = self.shopsTag;
        params.productunit = self.unitStr;
        params.promotion = @"1";
        params.productpic = response[@"data"][0][@"littlepic"];
        
        [RequestTool updateProduct:params success:^(ResultsModel *result) {
            NSLog(@"保存成功%@",result);
            if ([result.ErrorCode isEqualToString:@"1"]) {
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            [loadView stopAnimation];
            bottomBtn.userInteractionEnabled = YES;
            bottomBtn.backgroundColor = greenColor;
        } failure:^(NSError *error) {
            NSLog(@"保存失败 %@",error);
            [loadView stopAnimation];
            bottomBtn.userInteractionEnabled = YES;
            bottomBtn.backgroundColor = greenColor;
        }];
    } failure:^{
        NSLog(@"上传失败");
        [loadView stopAnimation];
        bottomBtn.userInteractionEnabled = YES;
        bottomBtn.backgroundColor = greenColor;
    }];
    
}
- (void)diddeleBtn:(UIButton *)sender
{
    NSLog(@"点击删除");
    LoadView *loadView = [LoadView new];
    
    DeleteProductParams* params = [[DeleteProductParams alloc] init];
    params.proid = self.modelList.productid;
    [RequestTool deleteProduct:params success:^(ResultsModel *result) {
        NSLog(@"删除成功");
        
        if([result.ErrorCode isEqualToString:@"1"])
        {
            [loadView stopAnimation];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }failure:^(NSError *error) {
        NSLog(@"删除失败 %@",error);
        [loadView stopAnimation];
    }];
    
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



@end
