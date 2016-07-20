//
//  ShopTableViewCell.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModlistModel.h"
@interface ShopTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * foodImageView;
@property (nonatomic, strong) UIImageView * hotImageview; // 食品状态
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * priceLabel;

@property (nonatomic, strong) ModlistModel * productModel;
@end
