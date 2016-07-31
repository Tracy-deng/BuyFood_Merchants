//
//  jadeModel.m
//  评价列表
//
//  Created by Jade on 16/7/29.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "jadeModel.h"
@implementation jadeModel
-(instancetype)initWithDic:(NSDictionary *)rootDic
{
    if (self = [super init]) {
        self.showname = [rootDic objectForKey:@"showname"];
        self.charcontent = [rootDic objectForKey:@"charcontent"];
        self.charcontent2 = [rootDic objectForKey:@"charcontent2"];
        self.chartid = [rootDic objectForKey:@"chartid"];
        self.pic = [rootDic objectForKey:@"pic"];
        self.score = [rootDic objectForKey:@"score"];
    }
    return self;
}
@end
