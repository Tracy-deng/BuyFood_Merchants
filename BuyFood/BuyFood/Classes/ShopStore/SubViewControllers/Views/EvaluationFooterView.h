//
//  EvaluationFooterView.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationFooterView : UIView


@property (nonatomic, strong) UIImageView* headerImage;
@property (nonatomic, strong) UILabel* userName;
@property (nonatomic, strong) UILabel* evaluate;
@property (nonatomic, strong) UILabel* evaluateContent;
@property (nonatomic, strong) UILabel* evaluateTime;
@property (nonatomic, strong) UIButton* replyBtn;


+ (instancetype)initFootView;

- (void)setUpContentView;

- (void)setFooterViewContentWithHeaderImage:(NSString* )imageName andUserName:(NSString* )userName andEvaluate:(NSString* )evaluate andEvaluateContent:(NSString* )evaluateContent andEvaluateTime:(NSString* )evaluateTime;

@end
