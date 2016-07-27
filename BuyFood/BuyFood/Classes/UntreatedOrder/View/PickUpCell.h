//
//  PickUpCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickUpCell : UITableViewCell
/** 接单按钮 */
@property (nonatomic, strong) UIButton* getOrderBtn;
/** 查看详情按钮 */
@property (nonatomic, strong) UIButton* searchListBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setOrderNumberLabelText:(NSString* )orderNumberLabelText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText;

@end
