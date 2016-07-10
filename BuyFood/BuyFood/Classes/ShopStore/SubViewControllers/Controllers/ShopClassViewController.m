//
//  ShopClassViewController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopClassViewController.h"
#import "RequestTool.h"
@interface ShopClassViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,retain) UITableView *sourceView;
@property (nonatomic,retain) NSArray *tableArray;

@end

@implementation ShopClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加分类";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    
    [self configureData];
    [self creatUI];
    
    
}
- (void)configureData
{
    
}


- (void)creatUI{
    
    
    
    _sourceView = [[UITableView alloc]init];
    _sourceView.delegate = self;
    _sourceView.dataSource = self;
    [self.view addSubview:_sourceView];
    [_sourceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 171));
    }];

    

    
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



}

- (void)showAlertView:(NSString *)string
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"你选定了");
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObject:nil forKey:@"userInfo"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"text" object:nil userInfo:dictionary];
        
    }];
   
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"你新添加了%@",string] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}






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
