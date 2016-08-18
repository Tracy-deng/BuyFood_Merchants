//
//  UIDevice+iPhoneMod.h
//  鹿鹿快递
//
//  Created by 黄栋春 on 16/4/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(char, iPhoneMod){//0~3
    iPhone4,//320*480
    iPhone5,//320*568
    iPhone6,//375*667
    iPhone6Plus,//414*736
    UnKnown
};
@interface UIDevice (iPhoneMod)


/**
 12  *  return current running iPhone model
 13  *
 14  *  @return iPhone model
 15  */
+ (iPhoneMod)iPhonesModel;
@end
