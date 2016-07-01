//
//  TakeMoneyCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeMoneyCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setUpTitleText:(NSString* )titleLabel andInputTextPlaceholder:(NSString* )placeholder andInputText:(NSString* )inputText;

@end
