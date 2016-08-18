//
//  AddPrinterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddPrinterViewController.h"
#import "PrintSetting.h"
#import "PrinterFile.h"
@interface AddPrinterViewController ()<CCPrinterSettingDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *printerTableView ; // 搜索到的蓝牙设备
@property (nonatomic, strong) NSMutableArray * dataSourceArray; // 搜索蓝牙的数据源
@property (nonatomic, strong) PrintSetting *manager;
@property (nonatomic, strong) CBPeripheral *selectedPeripheral; // 选中的设备
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * searchLabel;

@end

@implementation AddPrinterViewController
- (NSMutableArray *)dataSourceArray{
    if (_dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加打印机";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self creatUI];
    self.manager = [PrintSetting shareManager];
    self.manager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.manager scanPeripherals];
}

- (void)creatUI
{
    UIView * backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.25);
    }];
    
    
    UIImageView * printerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopsImage"]];
    printerView.backgroundColor = greenColor;
    [backGroundView addSubview:printerView];
    [printerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backGroundView.mas_top).offset(15);
        make.width.height.equalTo(@80);
        make.left.equalTo(backGroundView).offset(SCREEN_WIDTH / 2 - 40);
    }];
    
    printerView.layer.masksToBounds = YES;
    printerView.layer.cornerRadius = 40;
    
    _searchLabel = [UILabel new];
    _searchLabel.text = @"正在搜索打印机";
    _searchLabel.font = [UIFont systemFontOfSize:12];
    _searchLabel.textColor = [UIColor colorWithWhite:0.609 alpha:1.000];
    [backGroundView addSubview:_searchLabel];
    [_searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(printerView.mas_bottom).offset(2);
        make.left.equalTo(printerView);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"搜索到的打印机会显示在下面";
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.textColor = greenColor;
    [backGroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchLabel.mas_bottom);
        make.left.equalTo(printerView).offset(-20);
        make.width.equalTo(@200);
        make.height.equalTo(@25);
    }];
    
    UIButton * reSearchBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [reSearchBtn setTitle:@"重新搜索" forState:(UIControlStateNormal)];
    reSearchBtn.frame = CGRectMake(0, 0, 100, 30);
    reSearchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [reSearchBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [reSearchBtn addTarget:self action:@selector(didReSearch:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:reSearchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.printerTableView = [[UITableView alloc]init];
    self.printerTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.printerTableView];
    [self.printerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backGroundView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@300);
    }];
    
    self.printerTableView.delegate = self;
    self.printerTableView.dataSource = self;
}

- (void)didReSearch:(UIButton *)sender
{
    NSLog(@"点击重新搜索蓝牙设备");
    
    [self.dataSourceArray removeAllObjects];
    
    [self.manager scanPeripherals];

}

// 搜到蓝牙设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
{
    if(peripheral.name.length > 0)
    {
        [self.dataSourceArray addObject:peripheral];
    }
    
    [self.printerTableView reloadData];
    
    [self aboutLabelHiddle];
}


#pragma mark -- tabView 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"test";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    CBPeripheral *perioheral = [self.dataSourceArray objectAtIndex:indexPath.row];
    cell.textLabel.text = perioheral.name;
 
    if (self.selectedPeripheral.state == 2)
    {
        [self  showSucceseeLink:[NSString stringWithFormat:@"%@%@",self.selectedPeripheral.name,@"连接成功"]];
    }
    return cell;
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPeripheral = [self.dataSourceArray objectAtIndex:indexPath.row];
    
    [self.manager connectPeripheral:self.selectedPeripheral];
    
    
    NSTimer * connecttimer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(connect:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop]addTimer:connecttimer forMode:NSDefaultRunLoopMode];
    
    
    NSLog(@"%@   %ld",self.selectedPeripheral.name,  self.selectedPeripheral.state);
  
    if (self.selectedPeripheral.state == 2)
    {
       [self  showSucceseeLink:[NSString stringWithFormat:@"%@%@",self.selectedPeripheral.name,@"连接成功"]];
    }else if(self.selectedPeripheral.state == 0)
    {
       [self  showSucceseeLink:[NSString stringWithFormat:@"%@%@",self.selectedPeripheral.name,@"连接失败"]];
    }
    
}

- (void)connect:(NSTimer *)timer{
    
    [self.manager connectPeripheral:self.selectedPeripheral];
    
    [self.printerTableView reloadData];
}


- (void)aboutLabelHiddle
{
    
    NSTimer * timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timerField:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];

}

- (void)timerField:(NSTimer *)timer
{
     _searchLabel.hidden = YES;
}

- (void)showSucceseeLink:(NSString *)string
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"温馨提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:okAction];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
