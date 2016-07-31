//
//  JADEMethods.h
//  JadeMicro_chat
//
//  Created by bwfstu on 16/5/20.
//  Copyright © 2016年 bwfstu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JadeModel.h"

@interface JADEMethods : NSObject

/**自动适应label的高度
 */
+(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

@end

