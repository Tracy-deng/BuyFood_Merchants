//
//  ComplaintOrderCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMarketModel.h"

@interface ComplaintOrderCell : UITableViewCell

@property (nonatomic, strong) OrderMarketModel *model;

/** 查看详情按钮 */
@property (nonatomic, strong) UIButton* searchListBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
