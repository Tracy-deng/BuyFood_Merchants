//
//  ShopsManagementCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/4.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopsModelList.h"

@interface ShopsManagementCell : UITableViewCell

@property (nonatomic, strong) UIImageView * foodImageView;
@property (nonatomic, strong) UIImageView * hotImageview; // 食品状态
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * priceLabel;

@property (nonatomic, strong) ShopsModelList *modelList;

@end
