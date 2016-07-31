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
#import "ChangeTimeParams.h"
#import "DeleteProductParams.h"
#import "UpdateProductParams.h"
#import "EvaluationParams.h"
#import "SalesProductParams.h"
#import "OrderParams.h"
#import "MarketOrderModelList.h"
#import "GetOrderParams.h"
#import "OrderDetailsParams.h"
#import "BalanceAccountParams.h"
#import "ReplyEvaluationParams.h"

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

#pragma mark - UntreatedOrder <未处理订单>
/** 自提订单 */
+ (void)untreatedInviteOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketZT"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 配送订单 */
+ (void)untreatedDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketPost"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 接单 */
+ (void)getOrder:(GetOrderParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/UpdateOrderForMarketGet"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

#pragma mark - AlreadyOrder <已处理订单>
/** 自提订单 */
+ (void)alreadyInviteOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketZTFinished"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 配送订单 */
+ (void)alreadyDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketPostFinished"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 失效订单 */
+ (void)alreadySolvedOrderList:(OrderParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetCusOrderListError"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 投诉订单 */
+ (void)ComplaintOrderList:(OrderParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketOrderComplaint"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 订单详情 */
+ (void)orderDetails:(OrderDetailsParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketOrderByOrderNo"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
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
/** 账户余额 */
+ (void)balanceAccount:(BalanceAccountParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_wallet/GetModelList"];
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

/** 留言评价 */
+ (void)evaluation:(EvaluationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuserblog/GetComments"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 回复评论 */
+ (void)replyEvaluation:(ReplyEvaluationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuserblog/UpdateReplay"];
    NSLog(@"%@",param.mj_keyValues);
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
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

/** 修改商品 */
+ (void)updateProduct:(UpdateProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_product/Update"];
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
/** 删除商品 */
+ (void)deleteProduct:(DeleteProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_product/Delete"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
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

/** 修改营业时间*/
+ (void)chnageBusinessStatus:(ChangeTimeParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/UpdateMarketOpenTime"];
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

/**
 *  促销管理
 */

+(void)getSalesProduce:(SalesProductParams *)parm success:(void (^)(ResultsModel *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_product/GetModelList_Promotion"];
    [HttpRequestTool POST:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
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
/** 获取秒杀时间表 */
+ (void)getSecKillTimeSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_seckilltime/GetModelList"];
    [HttpRequestTool GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}


@end
