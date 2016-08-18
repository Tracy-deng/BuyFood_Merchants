//
//  realNameParams.h
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/3.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface realNameParams : NSObject

/** 身份证正面照 */
@property (nonatomic, strong) NSString *sfz1;
/** 身份证反面照 */
@property (nonatomic, strong) NSString *sfz2;
/** 手持身份证照片 */
@property (nonatomic, strong) NSString *scsfzpic;
/** 用户id */
@property (nonatomic, strong) NSString *userid;
/** 用户类别（1-普通用户，2-商家用户，3-骑士用户）*/
@property (nonatomic, strong) NSString *usertype;
/** 真实姓名 */
@property (nonatomic, strong) NSString *realname;
/** 身份证 */
@property (nonatomic, strong) NSString *IDCard;
/** 用户注册时的手机号 */
@property (nonatomic, strong) NSString *telephone;
/** 营业执照照片 */
@property (nonatomic, strong) NSString *businesss;
/** 其他照片1 */
@property (nonatomic, strong) NSString *pic1;
/** 其他照片2 */
@property (nonatomic, strong) NSString *pic2;


@end
