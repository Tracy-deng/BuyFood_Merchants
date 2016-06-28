//
//  ShopClassViewController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopClassViewController.h"

@interface ShopClassViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,retain) UITableView *sourceView;
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UITextField *textField;
@end

@implementation ShopClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加分类";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    
    [self creatUI];
    
}


- (void)creatUI{
    
    
    UILabel * textLabel  = [[UILabel alloc]init];
    textLabel.text = @"分类名";
    textLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:textLabel];
    textLabel.textColor = [UIColor grayColor];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.equalTo(self.view).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    

    
    _textField = [[UITextField alloc]init];
    _textField.placeholder = @"请输入分类名称";
    _textField.delegate = self;
    [self.view addSubview:_textField];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.textAlignment = NSTextAlignmentCenter;
    [_textField addTarget:self action:@selector(dropDown) forControlEvents:(UIControlEventAllTouchEvents)];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel.mas_bottom).offset(3);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    _sourceView = [[UITableView alloc]init];
    _sourceView.delegate = self;
    _sourceView.dataSource = self;
    [self.view addSubview:_sourceView];
    [_sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textField.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 171));
    }];
    _sourceView.hidden = YES;
    _tableArray = [NSMutableArray arrayWithObjects:@"蔬菜",@"水果",@"肉类",@"蛋类", nil];

    
}

- (void)dropDown
{
    [self showTableView:NO];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"test";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier
                ];
    }
    cell.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    [tableView setSeparatorColor:[UIColor whiteColor]];
    // cell 选中的颜色
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = _tableArray[indexPath.row];
    cell.textAlignment = NSTextAlignmentCenter;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _textField.text = _tableArray[indexPath.row];
    
    [self showAlertView:_textField.text];
    
    [self showTableView:YES];
}

- (void)showAlertView:(NSString *)string
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"你选定了");
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObject:_textField.text forKey:@"userInfo"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"text" object:nil userInfo:dictionary];
        
    }];
   
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你新添加了%@",string] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showTableView:(BOOL)isShow
{
    if (isShow == YES) {
        // 如果下拉列表框已经显示  就什么都不做
        [UIView animateWithDuration:0.5 animations:^{

            _sourceView.hidden = YES;
        }];
        return;
        
    }else{
        
        
        [UIView animateWithDuration:0.5 animations:^{
        
            _sourceView.hidden = NO;
            
        }];
        
        isShow = YES;
        
        // 如果下拉列表框没显示  那么显示
        
    }

}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField;
//{
//    NSUserDefaults * text = [NSUserDefaults standardUserDefaults];
//    
//    [text setObject:textField.text forKey:@"textField"];
//    
//    [text synchronize];
//    
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:textField.text forKey:@"userInfo"];
//    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"text" object:nil userInfo:dictionary];
//    
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
