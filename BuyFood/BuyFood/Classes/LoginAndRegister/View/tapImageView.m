//
//  tapImageView.m
//  证件上传
//
//  Created by dave-n1 on 16/6/30.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import "tapImageView.h"

@implementation tapImageView
+(instancetype)imageViewWithimage:(NSString *)imageName width:(NSInteger)x height:(NSInteger)y
{
    return [[tapImageView alloc]initImageViewWithimage:imageName width:x height:y];
}


-(instancetype)initImageViewWithimage:(NSString *)imageName width:(NSInteger)x  height:(NSInteger)y
{
    if (self = [super init]) {
        
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];
        
        self.frame = CGRectMake(x, y, SCREEN_WIDTH / 3 -5, SCREEN_WIDTH / 3 - 35);
        
        self.backgroundColor = [UIColor  redColor];
    }
    
    [self layoutSubviews];
    
    return self;
}


@end
