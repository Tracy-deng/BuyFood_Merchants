//
//  InputTextField.h
//  云洗盟
//
//  Created by 黄栋春 on 16/6/7.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTextField : UITextField

/** 初始化输入框 */
+ (instancetype)inputTextField;
/** 设置输入框内容 */
- (void)createTextFieldPlaceholder:(NSString *)placeholder andinputIcon:(NSString *)inputIconImageName;

@end
