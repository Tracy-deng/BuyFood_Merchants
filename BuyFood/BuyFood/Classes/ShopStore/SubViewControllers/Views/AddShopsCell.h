//
//  AddShopsCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/26.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddShopsCell : UITableViewCell

@property (nonatomic, strong) UITextField* contentTextField;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UILabel* chooseLabel;
@property (nonatomic, strong) UILabel* chooseContentLabel;

- (void)setTitleLabel:(NSString* )title andContentTextFieldPlaceholder:(NSString* )contentTextFieldPlaceholder;

- (void)setChooseTitleLabel:(NSString* )title andContentLabel:(NSString* )contentText;

- (instancetype)initWithChooseCellStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (instancetype)initWithInputCellStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
