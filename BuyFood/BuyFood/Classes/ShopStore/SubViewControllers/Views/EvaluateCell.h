//
//  EvaluateCell.h
//  评价
//
//  Created by 黄栋春 on 16/6/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jadeModel.h"
@interface EvaluateCell : UITableViewCell

@property (nonatomic, strong) UIImageView* headerImage;
@property (nonatomic, strong) UILabel* userName;
@property (nonatomic, strong) UILabel* evaluate;
@property (nonatomic, strong) UILabel* evaluateContent;
@property (nonatomic, strong) UILabel* evaluateTime;
@property (nonatomic, strong) UIButton* replyBtn;
@property (nonatomic, strong) jadeModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
