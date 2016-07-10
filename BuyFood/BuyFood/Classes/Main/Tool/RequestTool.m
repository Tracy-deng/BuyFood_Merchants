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
#import "AccountTool.h"

@implementation RequestTool

#pragma mark - login
/** 获取验证码 */
+(void)getSMSCode:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetRegisterSMSCode"];
    [HttpRequestTool GET:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
           
            failure(error);
        } else {
            NSLog(@"%@",model);
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}

/** 登录 */
+ (void)login:(RegisterParams *)param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"t_marketuser/GetLoginByModel"];
    [HttpRequestTool POST:url parameters:param.mj_keyValues progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            
            failure(error);
        } else {
            NSLog(@"%@",model);
            
            // 将返回的账号字典数据 --> 模型，存进沙盒
            Account *account = [Account accountWithDict:model];
            // 存储账号信息
            [AccountTool saveAccount:account];
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
}


/** 获取所有商品一级分类 */
+ (void)shopsListAll:(ShopsManagementParams* )param success:(void(^)(ResultsModel *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"/t_productcategory/GetModelListAll"];
    [HttpRequestTool GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if (error) {
            failure(error);
        } else {
            NSLog(@"%@",model);
            ResultsModel *result = [ResultsModel  mj_objectWithKeyValues:model];
            success(result);
        }
    }];
    
    
    
    
}
@end
