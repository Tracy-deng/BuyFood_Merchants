//
//  RequestTool.h
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/3.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  RegisterParams,
        LoginParams,
        ResultsModel,
        GetMsgCodeParams,
        ImproveinformationParams,
        ShopsUserInfo,
        realNameParams,
        OrderParams,
        DistributionParams,
        OwnOrderListParams,
        PushOrderListParams,
        SolvedOrderListParams,
        BalanceAccountParams,
        MyBillParams,
        EvaluationParams,
        BusinessStatusParams,
        ShopsManagementParams,
        NearbyMarketsParams,
        ShopsSecondClassParams,
        ShopsThirdClassParams,
        ShopsSecAndThirdClassParams,
        GetProductParams,
        AddProductParams,
        ChangeTimeParams,
        UpdateProductParams,
        DeleteProductParams,
        SalesProductParams,
        MarketOrderModelList,
        GetOrderParams,
        OrderDetailsParams,
        ReplyEvaluationParams,
        FeedBackParams,
        ChangePwdParams,
        ChangeHeaderImageParams,
        GetCityAndCountryParams,
        TodayBalanceAndVolumeModel,
        AddCtcategoryParams,
        GetBrandsAndCommunityClassifyParams;

@interface RequestTool : NSObject

#pragma mark - login 
/** 获取验证码 */
+ (void)getSMSCode:(GetMsgCodeParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 注册 */
+ (void)registe:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 实名认证 */
+ (void)realname:(realNameParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 登录 */
+ (void)login:(LoginParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 完善商户资料 */
+ (void)improveInformation:(ImproveinformationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 忘记密码 */
+ (void)forgetPwd:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
#pragma mark - UntreatedOrder <未处理订单>
/** 自提订单 */
+ (void)untreatedInviteOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 配送订单 */
+ (void)untreatedDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 接单 */
+ (void)getOrder:(GetOrderParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;

#pragma mark - AlreadyOrder <已处理订单>
/** 自提订单 */
+ (void)alreadyInviteOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 配送订单 --配送中 */
+ (void)alreadyDistributionOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 配送订单 --已完成--历史订单 */
+ (void)alreadyDistributionOverOrderList:(OrderParams *)param success:(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 失效订单 */
+ (void)alreadySolvedOrderList:(OrderParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 投诉订单 */
+ (void)ComplaintOrderList:(OrderParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;
/** 订单详情 */
+ (void)orderDetails:(OrderDetailsParams *)param success :(void(^)(MarketOrderModelList *result))success failure:(void (^)(NSError *error))failure;

#pragma mark - ShopStore <门店管理>
/** 今日营业额和今日成交量 */
+ (void)todayBalanceAndVolume:(EvaluationParams *)params :(void(^)(TodayBalanceAndVolumeModel *result))success failure:(void (^)(NSError *error))failure;
/** 账户余额 */
+ (void)balanceAccount:(BalanceAccountParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 我的账单 */
+ (void)myBill:(MyBillParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 留言评价 */
+ (void)evaluation:(EvaluationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 回复评论 */
+ (void)replyEvaluation:(ReplyEvaluationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 营业状态 */
+ (void)businessStatus:(BusinessStatusParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 修改营业时间*/
+ (void)chnageBusinessStatus:(ChangeTimeParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 定价指导 */
+ (void)pricingGuidanceSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取所有商品一级分类 */
+ (void)shopsListAll:(ShopsManagementParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 根据经纬度获取附近的菜场 */
+ (void)nearbyMarketsListAll:(NearbyMarketsParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 根据城市获取区域的菜市场 */
+ (void)getMarketsListAll:(NearbyMarketsParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取根据商家注册的一级分类下边的二三级分类 */
/** 获取所有商品二三级分类 */
+ (void)shopsSecAndThirdClass:(ShopsSecAndThirdClassParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 添加普通商品 */
+ (void)addProducts:(AddProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 查询商品 */
+ (void)getProduct:(GetProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 修改商品 */
+ (void)updateProduct:(UpdateProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 删除商品 */
+ (void)deleteProduct:(DeleteProductParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/**
 *  促销管理
 */
+ (void)getSalesProduce:(SalesProductParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取秒杀时间表 */
+ (void)getSecKillTimeSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;

/** 意见反馈 */
+ (void)feedBack:(FeedBackParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 修改密码 */
+ (void)changePwd:(ChangePwdParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 自动接单 */
+ (void)autoGetOrder:(BusinessStatusParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 修改头像 */
+ (void)changeHeaderImage:(ChangeHeaderImageParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取省 */
+ (void)getProvinceListSuccess:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取市 */
+ (void)getCityList:(GetCityAndCountryParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取县 */
+ (void)getCountryList:(GetCityAndCountryParams *)parm success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 社区店跟品牌馆新增分类 */
+ (void)addCtcategory:(AddCtcategoryParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 社区店跟品牌馆查询分类 */
+ (void)searchCtcategory:(GetBrandsAndCommunityClassifyParams *)params success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
@end
