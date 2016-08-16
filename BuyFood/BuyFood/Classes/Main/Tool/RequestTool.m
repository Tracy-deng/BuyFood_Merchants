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
#import "BusinessStatusParams.h"
#import "FeedBackParams.h"
#import "ChangePwdParams.h"
#import "MyBillParams.h"
#import "ChangeHeaderImageParams.h"
#import "GetCityAndCountryParams.h"
#import "TodayBalanceAndVolumeModel.h"
#import "AddCtcategoryParams.h"
#import "realNameParams.h"
#import "GetBrandsAndCommunityClassifyParams.h"
#import "TelephoneParams.h"
#import "CashOutParams.h"
#import "AddOutDoorParams.h"
#import "InputPostInfoParams.h"
#import "MarketUserIdParams.h"

@implementation RequestTool

#pragma mark - login
/** 获取注册验证码 */
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

/** 获取忘记密码验证码 */
+ (void)getForgetPwdCode:(GetMsgCodeParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetUpdateSMSCode"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 忘记密码 */
+ (void)forgetPwd:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/SetPassWordByYZM"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
    /**
     修改密码或密码重置(需要给实体类中的telephone、verifycode、pswd赋值)
     t_marketuser/SetPassWordByYZM
     */
}

/** 实名认证 */
+ (void)realname:(realNameParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    /** t_marketuser/SMRZ */
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

/** 获取省 */
+ (void)getProvinceListSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"area/GetProvince"];
    [HttpRequestTool GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 获取市 */
+ (void)getCityList:(GetCityAndCountryParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"area/GetCityByProvinceName"];
    [HttpRequestTool POST:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 获取县 */
+ (void)getCountryList:(GetCityAndCountryParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"area/GetCountryByCityName"];
    [HttpRequestTool POST:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
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

/** 获取普通商家的所有商品一级分类 */
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
/** 品牌馆一级分类 */
+ (void)BrandShopsListAllSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_productcategory/GetModelListForSpecitial"];
    [HttpRequestTool GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            HDCLog(@"%@", model);
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

/** 根据城市获取区域的菜市场 */
+ (void)getMarketsListAll:(NearbyMarketsParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetMarketListByCountry"];
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
/** 普通商家和社区店自提订单 */
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

/** 普通商家和社区店配送订单 */
+ (void)untreatedDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketSender"];
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
/** 品牌馆配送订单 */
+ (void)untreatedBrandDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
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

/** 普通商家和社区店和品牌馆接单 */
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
/** 品牌馆接单填写物流信息 */
+ (void)inputPostInfo:(InputPostInfoParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/UpdatePostInfo"];
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
/** 不接单 */
+ (void)noGetOrder:(GetOrderParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/UpdateOrderForMarketRefuse"];
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
/** 普通商家和社区店自提订单 */
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
/** 普通商家和社区店配送订单 --配送中 */
+ (void)alreadyDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketSenderFinished"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            HDCLog(@"%@", model);
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 品牌馆配送订单 --- 配送中 */
+ (void)alreadyBandDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketPostFinished"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            HDCLog(@"%@", model);
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 普通商家和社区店和品牌馆配送订单 --已完成 */
+ (void)alreadyDistributionOverOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetBuyedHistoryOrderByUserID"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else
        {
            HDCLog(@"%@", model);
            MarketOrderModelList *result = [MarketOrderModelList  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 普通商家和社区店和品牌馆失效订单 */
+ (void)alreadySolvedOrderList:(OrderParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_order/GetMarketOrderListError"];
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
/** 普通商家和社区店和品牌馆投诉订单 */
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
            HDCLog(@"%@",model);
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
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_wallet/GetModelListForMarketUser"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 我的账单 */
+ (void)myBill:(MyBillParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_bill_marketuser/GetModelList"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 营业状态 */
+ (void)businessStatus:(BusinessStatusParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/UpdateMarketStatus"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 今日营业额和今日成交量 */
+ (void)todayBalanceAndVolume:(EvaluationParams *)params :(void(^)(TodayBalanceAndVolumeModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"statistics/GetMarketUserOrderForDay"];
    [HttpRequestTool GET:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            TodayBalanceAndVolumeModel *result = [TodayBalanceAndVolumeModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 定价指导 */
+ (void)pricingGuidanceSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_productguideprice/GetModelListALL"];
    [HttpRequestTool GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
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
            HDCLog(@"%@", model);
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

/** 意见反馈 */
+ (void)feedBack:(FeedBackParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_suggestion/Add"];
    [HttpRequestTool POST:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model[@"ErrorMsg"]);
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 修改密码 */
+ (void)changePwd:(ChangePwdParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/UpdateUserPswdByOldPswd"];
    [HttpRequestTool POST:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 自动接单 */
+ (void)autoGetOrder:(BusinessStatusParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/UpdateMarketStatus"];
    [HttpRequestTool POST:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 修改头像 */
+ (void)changeHeaderImage:(ChangeHeaderImageParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/UpdateUserPicByTelephone"];
    [HttpRequestTool GET:url parameters:parm.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 社区店跟品牌馆新增分类 */
+ (void)addCtcategory:(AddCtcategoryParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_productcategorythree/Add"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@", model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 社区店跟品牌馆查询分类 */
+ (void)searchCtcategory:(GetBrandsAndCommunityClassifyParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_productcategorythree/GetModelList"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 获取提现验证码 */
+ (void)getCashOutMsgCode:(TelephoneParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_cashout/GetSMSCodeForAddToCashout"];
    [HttpRequestTool GET:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 申请提现 */
+ (void)cashOut:(CashOutParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_cashout/Add"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 获取提现状态 */
+ (void)cashoutStatus:(CashOutParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_cashout/GetModelList"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 添加户外活动 */
+ (void)addOutDoor:(AddOutDoorParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_outdoor/Add"];
    HDCLog(@"%@%@",url,params.ProductPictureList);
    for (NSString *str in params.ProductPictureList)
    {
        HDCLog(@"%@", str);
    }
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 获取户外活动列表 */
+ (void)outDoorList:(MarketUserIdParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_outdoor/GetModelListForMarketUser"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"model ===== %@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 添加团购 */
+ (void)addGroupBuy:(AddOutDoorParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_groupbuy/Add"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}
/** 获取团购列表 */
+ (void)groupBuyList:(MarketUserIdParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_groupbuy/GetModelListForMarket"];
    [HttpRequestTool POST:url parameters:params.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error)
        {
            HDCLog(@"%@", error.userInfo);
            failure(error);
        } else {
            HDCLog(@"%@",model);
            ResultsModel *result = [ResultsModel mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

@end
