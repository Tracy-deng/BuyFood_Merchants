//
//  ShopsUserInfo.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/11.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopsUserInfo : NSObject

/** 商家ID */
@property (nonatomic, strong) NSString* marketuserid;
/** 商家登录名 */
@property (nonatomic, strong) NSString* loginname;
/** pswd */
@property (nonatomic, strong) NSString* pswd;
/** 店铺名称 */
@property (nonatomic, strong) NSString* marketname;
/** 店铺经理 */
@property (nonatomic, strong) NSString* realname;
/** 联系电话 */
@property (nonatomic, strong) NSString* telephone;
/** 固定电话 */
@property (nonatomic, strong) NSString* telephone2;
/** 店铺描述 */
@property (nonatomic, strong) NSString* remark;
/** 店铺信誉 */
@property (nonatomic, strong) NSString* score;
/** 店铺图片 */
@property (nonatomic, strong) NSString* pic;
/** 省 */
@property (nonatomic, strong) NSString* province;
/** 市 */
@property (nonatomic, strong) NSString* city;
/** 区县 */
@property (nonatomic, strong) NSString* country;
/** 街道 */
@property (nonatomic, strong) NSString* street;
/** 详细地址 */
@property (nonatomic, strong) NSString* detailaddress;
/** 营业状态。1-正常营业；2-暂停营业；3-停业整改 */
@property (nonatomic, strong) NSString* status;
/** 营业开始时间 */
@property (nonatomic, strong) NSString* openstart;
/** 营业截止时间 */
@property (nonatomic, strong) NSString* openend;
/** 经度 */
@property (nonatomic, strong) NSString* lon;
/** 纬度 */
@property (nonatomic, strong) NSString* lat;
/** 注册日期 */
@property (nonatomic, strong) NSString* registertime;
/** 实名认证审核状态。0-注册，1-审核通过；2-审核不通过 */
@property (nonatomic, strong) NSString* checkstatus;
/** 审核描述 */
@property (nonatomic, strong) NSString* checkremark;
/** 验证码 */
@property (nonatomic, strong) NSString* verifycode;
/** 接收时间 */
@property (nonatomic, strong) NSString* verifytime;
/** 最新一次修改时间 */
@property (nonatomic, strong) NSString* modifytime;
/** 店铺类别ID */
@property (nonatomic, strong) NSString* markettypeid;
/** 店铺类别名称(如菜场、社区、品牌) */
@property (nonatomic, strong) NSString* markettypename;
/** 是否为实际商户.1-是菜场商户、社区店商户、品牌商户等，2-是菜场查询附近区域时，自动过滤2 */
@property (nonatomic, strong) NSString* ismarket;
/** 属于哪个菜场ID */
@property (nonatomic, strong) NSString* marketsubid;
/** 属于哪个菜场（名字）*/
@property (nonatomic, strong) NSString* marketsubname;
/** 商品类别ID,标志该店家卖啥 */
@property (nonatomic, strong) NSString* categoryid;
/** 店铺距离用户距离（km）*/
@property (nonatomic, strong) NSString* distance;
/** 店铺图片 */
@property (nonatomic, strong) NSMutableArray* MarketPictureList;

@end
