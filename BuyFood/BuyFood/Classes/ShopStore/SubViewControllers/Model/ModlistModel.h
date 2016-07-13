//
//  ModlistModel.h
//  BuyFood
//
//  Created by dave-n1 on 16/7/13.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModlistModel : NSObject
@property (nonatomic, strong) NSString *categoryid;
@property (nonatomic, strong) NSString *categoryname;
@property (nonatomic, strong) NSString *markettypeid;
@property (nonatomic, strong) NSString *modifytime ;
@property (nonatomic, strong) NSString *pageindex;
@property (nonatomic, strong) NSString *pagesize;
@property (nonatomic, strong) NSString *pic;

@property (nonatomic, strong) NSString *subcategoryid ; // 二级id
@property (nonatomic, strong) NSString *subcategoryname; // 二级名称
@property (nonatomic, strong) NSString *threecategoryid; // 三级id
@property (nonatomic, strong) NSString *threecategoryname; // 三级名称

@end
