//
//  RequestTool.m
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/3.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "RequestTool.h"
#import "HttpRequestTool.h"
#import "MJExtension.h"
#import "RegisterParams.h"
#import "ResultsModel.h"
#import "NearbyMarketsParams.h"
#import "ShopsSecondClassParams.h"
#import "ShopsThirdClassParams.h"
#import "LoginParams.h"
#import "GetMsgCodeParams.h"
#import "ImproveinformationParams.h"
#import "ShopsUserInfo.h"
#import "ShopsSecAndThirdClassParams.h"
#import "AddProductParams.h"
#import "GetProductParams.h"

@implementation RequestTool

#pragma mark - login
/** 获取验证码 */
+(void)getSMSCode:(GetMsgCodeParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetRegisterSMSCode"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
           
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 注册 */
+ (void)registe:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/Add"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 完善商户资料 */
+ (void)improveInformation:(ImproveinformationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/UpdateMarketInfo"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 登录 */
+ (void)login:(LoginParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetLoginByModel"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 获取所有商品一级分类 */
+ (void)shopsListAll:(ShopsManagementParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_productcategory/GetModelListAll"];
    [HttpRequestTool GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 获取附近的菜场 */
+ (void)nearbyMarketsListAll:(NearbyMarketsParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetNearestMarketForRegister"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}


/** 获取根据商家注册的一级分类下边的二级分类 */
/** 获取所有商品二三级分类 */
+ (void)shopsSecAndThirdClass:(ShopsSecAndThirdClassParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_productcategorythree/GetModelListForSuperQuery"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 添加普通商品 */
+ (void)addProducts:(AddProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_product/Add"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 查询商品 */
+ (void)getProduct:(GetProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_product/GetModelList"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

@end
