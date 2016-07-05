//
//  ResultsModel.h
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/3.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultsModel : NSObject

@property (nonatomic, strong) NSString* ErrorCode;
@property (nonatomic, strong) NSString* ErrorMsg;
@property (nonatomic, strong) NSString* totalcount;
@property (nonatomic, strong) NSString* CurrentPageIndex;
@property (nonatomic, strong) NSArray* ModelList;

@end
