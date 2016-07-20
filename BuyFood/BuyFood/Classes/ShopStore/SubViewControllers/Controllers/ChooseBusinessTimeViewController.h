//
//  ChooseBusinessTimeViewController.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnTextBlock)(NSString *showText);


@interface ChooseBusinessTimeViewController : UIViewController

@property (nonatomic, strong) NSString* startTime;
@property (nonatomic, strong) NSString* stopTime;

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;

@end
