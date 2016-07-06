//
//  PrintSetting.h
//  PrinterSetting
//
//  Created by dave-n1 on 16/7/4.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol CCPrinterSettingDelegate <NSObject>
@optional
/**
 *  扫描到蓝牙设备
 */

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral;

/**
 *  设备连接成功
 */

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;

/**
 * 设备连接失败
 */


- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;;


/**
 *  蓝牙中心管理状态变化
 */

- (void)cnetralManagerDidUpdateState:(CBCentralManager *)central;

/**
 *  失去和外围设备连接后重连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral;
@optional
@end

@interface PrintSetting : NSObject

@property (nonatomic, weak) id<CCPrinterSettingDelegate>delegate;


/**
 *  创建单例类
 */
+(instancetype)shareManager;

/**
 *  扫描蓝牙设备
 */
- (void)scanPeripherals;

/**
 *  取消扫描
 */

- (void)cancelScan;

/**
 *  连接蓝牙设备
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral;

/**
 *  断开蓝牙设备
 */
-(void)disConnectPeripheral:(CBPeripheral *)peripheral;

/**
 *  打印数据
 */

- (void)printData:(NSData *)writeData;


@end
