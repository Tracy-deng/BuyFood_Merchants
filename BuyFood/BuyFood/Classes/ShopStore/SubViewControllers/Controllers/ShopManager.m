//
//  ShopManager.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopManager.h"


@implementation ShopManager


+(instancetype)shareInstance
{
    static ShopManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ShopManager alloc]init];
    });
    
    
    return manager;
}

- (NSMutableArray *)dataArraySupperInit
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    if ([userDefaults objectForKey:@"dataArray"] == nil) {
        
        self.dataArray  = [NSMutableArray arrayWithObjects:@"热销",@"肉类",@"蛋类", nil];
    }else{
        
        self.dataArray = [userDefaults objectForKey:@"dataArray"];
    }
    return self.dataArray ;
    
}
- (void)addArrayWithString:(NSString *)string
{
    [self.dataArray  addObject:string];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.dataArray forKey:@"dataArray"];
    
    [userDefaults synchronize];
}

- (void)deleteArrayWithString:(NSString *)string
{
    [self.dataArray  removeObject:string];
}
@end
