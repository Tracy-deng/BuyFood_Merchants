//
//  pushTableViewCell.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface pushTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UIButton * addOrderBtn; // 接单按钮
@property (nonatomic ,strong) UILabel * pushAddTimeLabel; // 送达时间
@end
