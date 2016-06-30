//
//  CCLickButton.h
//  注册
//
//  Created by dave-n1 on 16/6/30.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCLickButton;
typedef void(^TlouchBlock)(CCLickButton *sender);
@interface CCLickButton : UIButton

+(instancetype)ButtonWithName:(NSString *)name imageView:(NSString *)imageName;
- (void)addTouchBlock:(TlouchBlock )touchBlock;

- (void)setSelected:(BOOL)selected imageView:(NSString *)imageName;

@end
