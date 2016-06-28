//
//  ManagementCell.h
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagementCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 UIImageView* shopsImage;
 UILabel* shopsName;
 UILabel* shopsWeight;
 UILabel* shopsSpecifications;
 UILabel* shopsOriginalPriceTitle;
 UILabel* shopsOriginalPrice;
 UILabel* shopsPromotionPriceTitle;
 UILabel* shopsPromotionPrice;
 */
- (void)setShopsImageName:(NSString* )shopsImageName andShopsNameLabel:(NSString* )shopsName andShopsWeight:(NSString* )shopsWeight andShopsSpecifications:(NSString* )shopsSpecifications andShopsOriginalPriceTitle:(NSString* )shopsOriginalPriceTitle andShopsOriginalPrice:(NSString* )shopsOriginalPrice andShopsPromotionPriceTitle:(NSString* )shopsPromotionPriceTitle andShopsPromotionPrice:(NSString* )shopsPromotionPrice;

@end
