//
//  ShopManager.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShopManager : NSObject


@property (nonatomic, strong) NSMutableArray * dataArray;

+(instancetype)shareInstance;

- (void)addArrayWithString:(NSString *)string;

- (void)deleteArrayWithString:(NSString *)string;

- (NSMutableArray *)dataArraySupperInit;

@end
