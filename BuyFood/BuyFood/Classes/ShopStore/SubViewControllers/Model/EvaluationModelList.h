//
//  EvaluationModelList.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationModelList : NSObject

/** 评价内容 */
@property (nonatomic, strong) NSString* charcontent;
/** 用户id */
@property (nonatomic, strong) NSString* userid;
/** 商家评论或投诉 ID*/
@property (nonatomic, strong) NSString* chartid;
/** 显示的评论用户名称。评论显示名称。如爱**帅哥 */
@property (nonatomic, strong) NSString* showname;
/** 用户对商家的评价（评分。1-好评，2-中评，3-差评） */
@property (nonatomic, strong) NSString* score;
/** 订单ID */
@property (nonatomic, strong) NSString* orderid;
/** 商品ID */
@property (nonatomic, strong) NSString* productid;
/** 类别（1-评论，2-投诉）*/
@property (nonatomic, strong) NSString* charttype;
/** 评论人的头像 */
@property (nonatomic, strong) NSString* pic;
/** 评价时间 */
@property (nonatomic, strong) NSString* modifytime;

@end