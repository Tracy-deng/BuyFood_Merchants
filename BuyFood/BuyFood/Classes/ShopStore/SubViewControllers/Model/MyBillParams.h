//
//  MyBillParams.h
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/5.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBillParams : NSObject
/** 商户id */
@property (nonatomic, strong) NSString *userid;
/** 分页 */
@property (nonatomic, strong) NSString *pageindex;
/** 每页显示多少条记录 */
@property (nonatomic, strong) NSString *pagesize;
/** 查询状态 不传值，表示查询支出和收入
 1 - 支出，
 2 - 收入*/
@property (nonatomic, strong) NSString *billtype;

@end
