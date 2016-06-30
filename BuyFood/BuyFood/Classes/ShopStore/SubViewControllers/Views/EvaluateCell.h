//
//  EvaluateCell.h
//  评价
//
//  Created by 黄栋春 on 16/6/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluateCell : UITableViewCell
@property (nonatomic, strong) UITextView* textView;



+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
