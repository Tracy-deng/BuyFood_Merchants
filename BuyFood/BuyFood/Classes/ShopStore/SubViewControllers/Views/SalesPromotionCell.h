//
//  SalesPromotionCell.h
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/25.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesPromotionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setTitleLabel:(NSString* )title andContentLabel:(NSString* )contentText;

@end