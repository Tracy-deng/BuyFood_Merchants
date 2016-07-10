//
//  RequestTool.h
//  BuyFood_Shops
//
//  Created by 黄栋春 on 16/7/3.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  RegisterParams,
        ResultsModel,
        realNameParams,
        inviteOrderListParams,
        DistributionParams,
        OwnOrderListParams,
        PushOrderListParams,
        SolvedOrderListParams,
        BalanceAccountParams,
        MyBillParams,
        EvaluationParams,
        BusinessStatusParams,
        ShopsManagementParams;


@interface RequestTool : NSObject

#pragma mark - login 
/** 获取验证码 */
+ (void)getSMSCode:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 注册 */
+ (void)registe:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 实名认证 */
+ (void)realname:(realNameParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 登录 */
+ (void)login:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 忘记密码 */
+ (void)forgetPwd:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;

#pragma mark - UntreatedOrder <未处理订单>
/** 自提订单 */
+ (void)untreatedInviteOrderList:(inviteOrderListParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 配送订单 */
+ (void)untreatedDistributionOrderList:(DistributionParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;

#pragma mark - AlreadyOrder <已处理订单>
/** 自提订单 */
+ (void)alreadyInviteOrderList:(OwnOrderListParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 配送订单 */
+ (void)alreadyDistributionOrderList:(PushOrderListParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 失效订单 */
+ (void)alreadySolvedOrderList:(SolvedOrderListParams *)param success :(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;

#pragma mark - ShopStore <门店管理>
/** 账户余额 */
+ (void)balanceAccount:(BalanceAccountParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 我的账单 */
+ (void)myBill:(MyBillParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 留言评价 */
+ (void)evaluation:(EvaluationParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 营业状态 */
+ (void)businessStatus:(BusinessStatusParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 商品管理 */
+ (void)shopsManagement:(ShopsManagementParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;
/** 获取所有商品一级分类 */
+ (void)shopsListAll:(ShopsManagementParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure;

@end
