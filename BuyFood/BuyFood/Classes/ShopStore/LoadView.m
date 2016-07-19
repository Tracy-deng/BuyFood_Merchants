//
//  LoadView.m
//  BuyFood
//
//  Created by dave-n1 on 16/7/19.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "LoadView.h"
@interface LoadView()
@property UIActivityIndicatorView *activityIndicator;
@end
@implementation LoadView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.5;
        self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        self.activityIndicator.hidesWhenStopped = YES;
        self.activityIndicator.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height *0.5);
        [self addSubview:self.activityIndicator];
    }
    return self;
}


- (void)startAnimation
{
    [[[[UIApplication sharedApplication]windows]firstObject]addSubview:self];
    [self.activityIndicator startAnimating];
    
}

- (void)stopAnimation
{
    [self.activityIndicator stopAnimating];
    [self removeFromSuperview];
}

- (void)startAimatingWithView:(UIView *)subView
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    NSArray *windowViews = [window subviews];
    if (windowViews && [windowViews count] > 0) {
        UIView *subView = [windowViews objectAtIndex:[windowViews count] - 1];
        for (UIView * aSubView  in subView.subviews) {
            [aSubView.layer removeAllAnimations];
        }
        
        [subView addSubview:self];
    }else{
        [subView addSubview:self];
    }
    
    [self.activityIndicator startAnimating];
    
}
@end
