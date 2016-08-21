//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

#import "FightGroupsManagementViewController.h"
#import "Masonry.h"
#import "ManagementCell.h"
#import "FightGroupsViewController.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FightGroupsManagementViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tabelView;

@end

@implementation FightGroupsManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"拼团管理";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createTabeleViewAndBottomBtn];
}

- (void)createTabeleViewAndBottomBtn
{
    self.tabelView = [[UITableView alloc] init];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.75);
    }];
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [bottomBtn setTitle:@"添加" forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 3.0;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(21);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(@(SCREEN_WIDTH - 2 * 21));
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
}

- (void)bottomBtnClick:(UIButton* )sender
{
    [self.navigationController pushViewController:[[FightGroupsViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementCell *cell = [ManagementCell cellWithOtherTableView:tableView];
    [cell setOtherShopsImage:@"rectangle9" andShopsNameLabel:@"大百草" andShopsWeight:@"222.0" andShopsSpecifications:@"/千克" andShopsOriginalPriceTitle:@"原价" andShopsOriginalPrice:@"18" andShopsPromotionPriceTitle:@"秒杀价" andShopsPromotionPrice:@"¥14" andTime:@"12:00开拼"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height * 0.15;
}



@end
