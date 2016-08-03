//
//  ownSlovedTableViewCell.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderMarketModel.h"
@interface ownSlovedTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UILabel * addOrderLabel; // 接单按钮
@property (nonatomic ,strong) UIButton * pushAddTimeBtn; // 送达时间
@property (nonatomic, strong) OrderMarketModel * model;
@end
