//
//  ManagementCell.h
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutDoorModelList.h"


@interface ManagementCell : UITableViewCell

/** 商品重量 */
@property (nonatomic, strong) UILabel* shopsWeight;
/** 商品单位 */
@property (nonatomic, strong) UILabel* shopsSpecifications;

@property (nonatomic, strong) OutDoorModelList *modelList;


/** 促销管理自定义cell */
+ (instancetype)cellWithSalesPromotionTableView:(UITableView *)tableView;
/** 促销管理contentView内容 */
- (void)setShopsImage:(NSString * )shopsImage andShopsNameLabel:(NSString* )shopsName andShopsWeight:(NSString* )shopsWeight andShopsSpecifications:(NSString* )shopsSpecifications andShopsOriginalPriceTitle:(NSString* )shopsOriginalPriceTitle andShopsOriginalPrice:(NSString* )shopsOriginalPrice andShopsPromotionPriceTitle:(NSString* )shopsPromotionPriceTitle andShopsPromotionPrice:(NSString* )shopsPromotionPrice;
/** 其他活动自定义cell */
+ (instancetype)cellWithOtherTableView:(UITableView *)tableView;
/** 其他活动自定义contentView内容 */
- (void)setOtherShopsImage:(NSString * )shopsImage andShopsNameLabel:(NSString* )shopsName andShopsWeight:(NSString* )shopsWeight andShopsSpecifications:(NSString* )shopsSpecifications andShopsOriginalPriceTitle:(NSString* )shopsOriginalPriceTitle andShopsOriginalPrice:(NSString* )shopsOriginalPrice andShopsPromotionPriceTitle:(NSString* )shopsPromotionPriceTitle andShopsPromotionPrice:(NSString* )shopsPromotionPrice andTime:(NSString *)time;

@end
