//
//  SetPriceAdviceCell.h
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/26.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PricingGuidanceModel.h"

@interface SetPriceAdviceCell : UITableViewCell

@property (nonatomic, strong) PricingGuidanceModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setTitleLabel:(NSString* )title andBuyMoneyLabel:(NSString* )buyMoneyLabel andAveragePrice:(NSString* )averagePrice andDownOrImageName:(NSString* )imageName;

@end
