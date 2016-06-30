//
//  CCLickButton.m
//  注册
//
//  Created by dave-n1 on 16/6/30.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import "CCLickButton.h"

@interface CCLickButton ();
@property (nonatomic, copy)TlouchBlock touchBlock;
@end
@implementation CCLickButton

+(instancetype)ButtonWithName:(NSString *)name imageView:(NSString *)imageName
{
    return [[CCLickButton alloc]initWithButtonWithName:name imageView:imageName];
}

- (instancetype)initWithButtonWithName:(NSString *)name imageView:(NSString *)imageName
{
    if (self = [super init]) {
        
        if (self.selected == NO) {
            
            UIImage *imageView =[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];

            
            [self setImage:imageView forState:(UIControlStateNormal)];
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH - 50);
        }
        
        
        
        UILabel * titleLabel = [UILabel new];
        
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        titleLabel.text = [NSString stringWithFormat:@"%@",name];
        
        titleLabel.textColor = [UIColor grayColor];
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(60));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.equalTo(@(100));
            make.height.equalTo(@(30));
        }];
        
        
        UIView * linewView = [[UIView alloc]init];
        
        linewView.backgroundColor = [UIColor grayColor];
        
        linewView.alpha = 0.4;
        
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

- (void)addTouchBlock:(TlouchBlock)touchBlock
{
    __weak typeof(self) weakSelf = self;
    weakSelf.touchBlock = [touchBlock copy];
    
    [self addTarget:self action:@selector(didTouch:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)didTouch:(CCLickButton *)sender 
{
    if (self.touchBlock) {
        self.touchBlock(sender);
    }    
    
}

- (void)setSelected:(BOOL)selected imageView:(NSString *)imageName
{
    [super setSelected:selected];
    
    if (selected) {
        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] forState:(UIControlStateNormal)];
    }else{
        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] forState:(UIControlStateNormal)];
    }
}
@end
