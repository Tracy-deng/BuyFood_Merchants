//
//  DispatchCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/18.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DispatchCell : UITableViewCell

/** 查看详情按钮 */
@property (nonatomic, strong) UIButton* searchListBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setOrderNumLabelText:(NSString* )orderNumLabelText andOrderNumberLabelText:(NSString* )orderNumberLabelText andGetTimeBtnText:(NSString* )getTimeBtnText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText;

@end
