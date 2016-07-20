//
//  MJRefreshAutoStateFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoStateFooter.h"

static NSString *MJRefreshHeaderIdleText ;
static NSString *MJRefreshHeaderPullingText;
static NSString *MJRefreshHeaderRefreshingText;

static NSString *MJRefreshAutoFooterIdleText ;
static NSString *MJRefreshAutoFooterRefreshingText;
static NSString *MJRefreshAutoFooterNoMoreDataText ;

static NSString *MJRefreshBackFooterIdleText ;
static NSString *MJRefreshBackFooterPullingText ;
static NSString *MJRefreshBackFooterRefreshingText;
static NSString *MJRefreshBackFooterNoMoreDataText ;

@interface MJRefreshAutoStateFooter()
{
    /** 显示刷新状态的label */
    __weak UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MJRefreshAutoStateFooter
+(void)load{
    MJRefreshHeaderIdleText = NSLocalizedString(@"MJRefreshHeaderIdleText",nil);
    MJRefreshHeaderPullingText = NSLocalizedString(@"MJRefreshHeaderPullingText",nil);
    MJRefreshHeaderRefreshingText = NSLocalizedString(@"MJRefreshHeaderRefreshingText",nil);
    
    MJRefreshAutoFooterIdleText = NSLocalizedString(@"MJRefreshAutoFooterIdleText",nil);
    MJRefreshAutoFooterRefreshingText = NSLocalizedString(@"MJRefreshAutoFooterRefreshingText",nil);
    MJRefreshAutoFooterNoMoreDataText = NSLocalizedString(@"MJRefreshAutoFooterNoMoreDataText",nil);
    
    MJRefreshBackFooterIdleText = NSLocalizedString(@"MJRefreshBackFooterIdleText",nil);
    MJRefreshBackFooterPullingText = NSLocalizedString(@"MJRefreshBackFooterPullingText",nil);
    MJRefreshBackFooterRefreshingText = NSLocalizedString(@"MJRefreshBackFooterRefreshingText",nil);
    MJRefreshBackFooterNoMoreDataText = NSLocalizedString(@"MJRefreshBackFooterNoMoreDataText",nil);
    
}

#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 私有方法
- (void)stateLabelClick
{
    if (self.state == MJRefreshStateIdle) {
        [self beginRefreshing];
    }
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:MJRefreshAutoFooterIdleText forState:MJRefreshStateIdle];
    [self setTitle:MJRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
    [self setTitle:MJRefreshAutoFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
    
    // 监听label
    self.stateLabel.userInteractionEnabled = YES;
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick)]];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (self.isRefreshingTitleHidden && state == MJRefreshStateRefreshing) {
        self.stateLabel.text = nil;
    } else {
        self.stateLabel.text = self.stateTitles[@(state)];
    }
}
@end