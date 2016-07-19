//
//  GetProductParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/13.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetProductParams : NSObject

/** 
    获取普通商品：t_product/GetModelList门店获取普通商品明细 门店marketuserid（商户ID）不能为空值；pagesize=0查询所有。categoryid（商品一级分类ID）、subcategoryid（商品二级分类ID）、threecategoryid（三级类别ID）。用户可根据需要自行传参。
 */

/** 商户id */
@property (nonatomic, strong) NSString* marketuserid;
/** 获取页数 */
@property (nonatomic, strong) NSString* pagesize;
/** 商品一级分类ID */
@property (nonatomic, strong) NSString* categoryid;
/** 商品二级分类ID */
@property (nonatomic, strong) NSString* subcategoryid;
/** 商品的三级分类ID */
@property (nonatomic, strong) NSString* threecategoryid;
/** 商品的标签 */
@property (nonatomic, strong) NSString* Productlabel;

@property (nonatomic, strong) NSString *page;

@end
