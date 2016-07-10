//
//  CLLocation+HDCLocation.h
//  获取当前经纬度
//
//  Created by 黄栋春 on 16/7/6.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>


@interface CLLocation (HDCLocation)

//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

@end
