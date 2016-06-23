//
//  CCTitleView.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CCTitleView.h"

@implementation CCTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)titleViewWithName:(NSString *)name
{
    return [[CCTitleView alloc]initWithName:name];
}


- (instancetype)initWithName:(NSString *)name
{
    if (self = [super init]){
        
        self.textColor = [UIColor whiteColor];
        
        self.text = name;
        
        self.font = [UIFont systemFontOfSize:18];
        
        [self sizeToFit];
        
    }
    
    [self layoutSubviews];
    
    return self;
}
@end
