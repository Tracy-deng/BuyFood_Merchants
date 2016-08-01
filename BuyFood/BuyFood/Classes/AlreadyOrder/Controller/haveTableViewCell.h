//
//  haveTableViewCell.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "OrderMarketModel.h"
@interface haveTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel * addOrderBtn; // 接单按钮
@property (nonatomic, strong) OrderMarketModel * model;

@end
