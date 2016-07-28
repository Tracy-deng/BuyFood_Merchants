//
//  OrderDetailModel.h
//  BuyFood
//
//  Created by dave-n1 on 16/7/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property (nonatomic, strong) NSString * MarketUser ;
@property (nonatomic, assign) NSInteger  detailid;
@property (nonatomic, strong) NSString * detailstatus;
@property (nonatomic, assign) NSInteger  marketuserid;
@property (nonatomic, strong) NSString * modifytime;
@property (nonatomic, strong) NSString * order_marketid;
@property (nonatomic, assign) NSInteger  orderid;
@property (nonatomic, strong) NSString * orderno;
@property (nonatomic, assign) NSInteger  productcount;
@property (nonatomic, assign) NSInteger  productid;
@property (nonatomic, strong) NSString * productname;
@property (nonatomic, strong) NSString * productpicture;
@property (nonatomic, assign) CGFloat    productprice;
@property (nonatomic, assign) CGFloat    productstock;
@property (nonatomic, strong) NSString * productunit;



@end
