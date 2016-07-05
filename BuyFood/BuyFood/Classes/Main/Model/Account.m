//
//  Account.m
//  testGetUserIno
//
//  Created by 黄栋春 on 16/4/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    Account *account = [[self alloc] init];
    account.marketuserid = (NSInteger)dict[@"marketuserid"];
    return account;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.marketuserid forKey:@"marketuserid"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.marketuserid = [decoder decodeIntegerForKey:@"marketuserid"];
    }
    return self;
}
@end
