//
//  CardCell.h
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setUpBackGroundImageName:(NSString* )backGroundImage andBankName:(NSString* )bankName andCardType:(NSString* )cardType andCardNumber:(NSString* )cardNumber;

@end
