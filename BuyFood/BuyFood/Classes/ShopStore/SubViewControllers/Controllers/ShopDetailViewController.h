//
//  ShopDetailViewController.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModlistModel.h"
@interface ShopDetailViewController : UIViewController
@property (nonatomic, strong) ModlistModel * detailModel;
@property (nonatomic, strong) NSMutableDictionary * goodsDic; // 传过来的商品信息
@end
