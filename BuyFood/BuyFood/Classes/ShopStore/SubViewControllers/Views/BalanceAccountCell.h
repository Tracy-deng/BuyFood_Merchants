//
//  BalanceAccountCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceAccountCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setUpAccountMoneyLabel:(NSString* )accountMoney andAccountTimeLabel:(NSString* )accountTime andAccountCardLabel:(NSString* )accountCard;

@end
