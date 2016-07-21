//
//  UpdateProductParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateProductParams : NSObject

/** 商家商品ID */
@property (nonatomic, assign) NSInteger productid;
/** 商家ID。表明商品是哪家商铺的 */
@property (nonatomic, strong) NSString* marketuserid;
/** 商品一级分类ID */
@property (nonatomic, strong) NSString* categoryid;
/** 商品名称 */
@property (nonatomic, strong) NSString* productname;
/** 商品图片（存放缩略图）*/
@property (nonatomic, strong) NSString* productpic;
/** 商品描述 */
@property (nonatomic, strong) NSString* productremark;
/** 商品库存 */
@property (nonatomic, assign) double productstock;
/** 商品原售价格 */
@property (nonatomic, assign) double productoutprice;
/** 商品现售价格（促销价格)*/
@property (nonatomic, assign) double productoutprice2;
/** 商品单位（份、克等）*/
@property (nonatomic, strong) NSString* productunit;
/** 标签，如特价/热销 */
@property (nonatomic, strong) NSString* productlabel;
/** 促销商品（1-默认销售价格已原售价为准；2-售价以促销价为准）*/
@property (nonatomic, strong) NSString* promotion;
/** 二级分类的id */
@property (nonatomic, strong) NSString* subcategoryid;
/** 三级分类的id */
@property (nonatomic, strong) NSString* threecategoryid;
/** 商品标签  字符串"普通"、"促销"、"热销"*/
@property (nonatomic, strong) NSString* Productlabel;

@end
