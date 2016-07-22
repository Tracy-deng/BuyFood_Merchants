//
//  SalesProductParams.h
//  BuyFood
//
//  Created by dave-n1 on 16/7/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesProductParams : NSObject
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

@property (nonatomic, strong) NSString *page;

@end
