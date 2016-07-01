//
//  userTextField.m
//  证件上传
//
//  Created by dave-n1 on 16/6/30.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import "userTextField.h"

@implementation userTextField

+(instancetype)textFieldWithheight:(NSInteger)y
{
    return [[userTextField alloc]initWitTtextFieldWithheight:y];
}

- (instancetype)initWitTtextFieldWithheight:(NSInteger)y
{
    if (self = [super init]) {
        
        self.font = [UIFont systemFontOfSize:14];
        
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        
        [self setBorderStyle:UITextBorderStyleRoundedRect];
        
         self.frame = CGRectMake(0.4*SCREEN_WIDTH, y,  0.55*SCREEN_WIDTH, 30);
    }
    
    [self layoutSubviews];
    
    return  self;
}
@end
