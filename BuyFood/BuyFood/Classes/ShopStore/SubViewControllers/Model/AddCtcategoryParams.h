//
//  AddCtcategoryParams.h
//  BuyFood
//
//  Created by 黄栋春 on 16/8/3.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCtcategoryParams : NSObject


/** 三级分类名称 */
@property (nonatomic, strong) NSString *threecategoryname;

/** 一级分类id  社区店传  0  
    品牌馆传注册时选择的一级分类id */
@property (nonatomic, strong) NSString *categoryid;

/**二级分类id   传0 */
@property (nonatomic, strong) NSString *subcategoryid;

/** 注册类别 2 社区店 3品牌馆 */
@property (nonatomic, strong) NSString *markettypeid;

/** userid  商户注册id */
@property (nonatomic, strong) NSString *userid;

@end
