//
//  EvaluationHeaderView.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationHeaderView : UIView

+ (instancetype)initEvaluationHeaderView;

- (void)creatHeaderContentView;

- (void)setOrderNumberLabel:(NSString* )orderNumber andGreatEvaluationLabel:(NSString* )greatEvaluation;

@end
