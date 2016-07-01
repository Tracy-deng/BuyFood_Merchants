//
//  CCTextField.m
//  注册
//
//  Created by dave-n1 on 16/6/29.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import "CCTextField.h"

@implementation CCTextField

+(instancetype)textFiledWithName:(NSString *)name UIimageView:(NSString *)imageName
{
    return [[CCTextField alloc]initTextFiledWithName:name UIimageView:imageName ];
}

- (instancetype)initTextFiledWithName:(NSString *)name UIimageView:(NSString *)imageName
{
    if (self = [super init])
    {
        [self setPlaceholder:name];
        
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        self.textColor = [UIColor grayColor];
        
        self.font = [UIFont systemFontOfSize:18];
        
        self.textAlignment = NSTextAlignmentLeft;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *leftViews = [UIView new];
        leftViews.height = 30;
        leftViews.width = 40;
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.x = 8;
        imageView.y = 5;
        imageView.width = 20;
        imageView.height = 20;
        [leftViews addSubview:imageView];
        
        leftViews.contentMode = UIViewContentModeCenter;
        
        self.leftView = leftViews;
        
        
        UIView * linewView = [[UIView alloc]init];
        
        linewView.backgroundColor = [UIColor grayColor];
        
        linewView.alpha = 0.4;
        
//        linewView.frame = CGRectMake(0, 38, SCREEN_WIDTH - 30, 0.3);
        
        [self addSubview:linewView];
        
        [linewView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(@(1));
        }];
        
    }
    [self layoutSubviews];
    
    return self;
}



@end
