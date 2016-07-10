//
//  CCLocationManager.h
//  获取当前经纬度
//
//  Created by 黄栋春 on 16/7/6.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define  CCLastLongitude @"CCLastLongitude"
#define  CCLastLatitude  @"CCLastLatitude"
#define  CCLastCity      @"CCLastCity"
#define  CCLastAddress   @"CCLastAddress"

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void(^NSStringBlock)(NSString *cityString);
typedef void(^NSStringBlock)(NSString *addressString);


@interface CCLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D lastCoordinate;
@property(nonatomic,strong)NSString *lastCity;
@property (nonatomic,strong) NSString *lastAddress;

@property(nonatomic,assign)float latitude;
@property(nonatomic,assign)float longitude;

+ (CCLocationManager *)shareLocation;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock ;

/**
 *  获取坐标和详细地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;

/**
 *  获取详细地址
 *
 *  @param addressBlock addressBlock description
 */
- (void) getAddress:(NSStringBlock)addressBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void) getCity:(NSStringBlock)cityBlock;


@end