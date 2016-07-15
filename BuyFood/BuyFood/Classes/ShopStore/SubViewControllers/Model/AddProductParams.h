//
//  AddProductParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/13.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddProductParams : NSObject
/** 商户id */
@property (nonatomic, strong) NSString* marketuserid;
/** 一级分类id */
@property (nonatomic, strong) NSString* categoryid;
/** 二级分类的id */
@property (nonatomic, strong) NSString* subcategoryid;
/** 三级分类的id */
@property (nonatomic, strong) NSString* threecategoryid;
/** 商品名称 */
@property (nonatomic, strong) NSString* productname;
/** 商品库存（即重量、份、数量等）*/
@property (nonatomic, strong) NSString* productstock;
/** 商品原售价格 */
@property (nonatomic, strong) NSString* productoutprice;
/** 商品描述 */
@property (nonatomic, strong) NSString* productremark;
/** 商品单位 商品单位（份、克等）*/
@property (nonatomic, strong) NSString* productunit;
/** 商品标签  字符串"普通"、"促销"、"热销"*/
@property (nonatomic, strong) NSString* Productlabel;
/** 促销商品（1-默认销售价格已原售价为准；2-售价以促销价为准） */
@property (nonatomic, strong) NSString* promotion;
/** 商品现售价格（促销价格）*/
@property (nonatomic, strong) NSString* productoutprice2;
/** 商品图片 */
@property (nonatomic, strong) UIImage * productpic;

@end
