//
//  ShopsModelList.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/4.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopsModelList : NSObject

/** 商品标签 */
@property (nonatomic, strong) NSString *productlabel;
/** 商品名称 */
@property (nonatomic, strong) NSString *productname;
/** s商品价格 */
@property (nonatomic, strong) NSString *productoutprice;
/** 商品图片 */
@property (nonatomic, strong) NSString *productpic;
/** 商品单位 */
@property (nonatomic, strong) NSString *productunit;
/** 分类id */
@property (nonatomic, strong) NSString *threecategoryid;
/** 商品id */
@property (nonatomic, strong) NSString *productid;
/** 商品重量 */
@property (nonatomic, strong) NSString *productstock;
/** 商品描述 */
@property (nonatomic, strong) NSString *productremark;


@end
