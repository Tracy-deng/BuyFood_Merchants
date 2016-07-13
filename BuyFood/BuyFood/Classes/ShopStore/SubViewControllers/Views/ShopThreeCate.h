//
//  ShopThreeCate.h
//  BuyFood
//
//  Created by dave-n1 on 16/7/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModlistModel.h"
@interface ShopThreeCate : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *nameLabel; // 二级分区名称

@property(nonatomic, strong) ModlistModel *model;
@end
