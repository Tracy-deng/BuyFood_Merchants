//
//  PrintSetting.m
//  PrinterSetting
//
//  Created by dave-n1 on 16/7/4.
//  Copyright © 2016年 tracy. All rights reserved.
//

#import "PrintSetting.h"

#define Printer169ServiceUUID @"49535343-FE7D-4AE5-8FA9-9FAFD205E455"
#define Printer200ServiceUUID @"E7810A71-73AE-499D-8C15-FAA9AEF0C3F2"

@interface PrintSetting() <CBCentralManagerDelegate, CBPeripheralDelegate>
/**
 *  蓝牙中央管理
 */
@property (nonatomic, strong) CBCentralManager *centraManager;

/**
 *  已连接的周边对象
 */
@property (nonatomic, strong) CBPeripheral *connectedPeripheral;

/**
 *  已连接的服务
 */

@property (nonatomic, strong) CBService *connectedService;

/**
 *  已连接的特征值
 */

@property (nonatomic, strong) CBCharacteristic *connectedCharacteristic;

/**
 *  蓝牙连接的状态
 */

@property (nonatomic,assign,readwrite) CBCentralManagerState centraState;


@end


@implementation PrintSetting
+(instancetype)shareManager
{
    static PrintSetting * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PrintSetting alloc]init];
    });
    return manager;
}



- (instancetype)init{
    if (self = [super init]) {
        self.centraManager  = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    return self;
}

#pragma mark -- CCPrinterSettingDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"<<<<<<<<<<<<<CBCentralManagerDelegate>>>>>>>>>>>>>");
    self.centraState = central.state;
    if ([self.delegate respondsToSelector:@selector(centralManagerDidUpdateState:)]) {
        [self.delegate cnetralManagerDidUpdateState:central];
    }
    

    switch (central.state) {
        case 0:{
            NSLog(@"CBCentralManagerStateUnknown");
        }
            break;
            
        case 1:{
            NSLog(@"CBCentralManagerStateResetting");
        }
            break;
            
        case 2:{
            NSLog(@"CBCentralManagerStateUnsupported");
        }
            break;
        case 3:{
            NSLog(@"CBCentralManagerStateUnauthorized");
        }
            break;
        case 4:{
            NSLog(@"CBCentralManagerStatePoweredOff");
        }
            break;
        case 5:{
            NSLog(@"CBCentralManagerStatePoweredOn");
        }
        default:
            break;
    }
    
}


/**
 *  扫描到新的外设
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if ([self.delegate respondsToSelector:@selector(centralManager:didDiscoverPeripheral:)]) {
        [self.delegate centralManager:central didDiscoverPeripheral:peripheral];
    }
}

/**
 *  失去和外围设备连接后重连
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(centralManager:didDisconnectPeripheral:)]) {
        [self.delegate centralManager:self.centraManager didDisconnectPeripheral:peripheral];
    }
}

/**
 *   连接到新的蓝牙设备
 *   @param central    中心管理
 *   @param peripheral 蓝牙设备
 */

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self clearConnectData];
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    
}
- (void)clearConnectData {
    [self.centraManager stopScan];
    self.connectedPeripheral = nil;
    self.connectedService = nil;
}

/**
 *  连接蓝牙设备失败
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(centralManager:didFailToConnectPeripheral:error:)]) {
        [self.delegate centralManager:central didFailToConnectPeripheral:peripheral error:error];
    };
    
    [self clearConnectData];
}

#pragma mark - CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"didDicoverService");
    if (error) {
        NSLog(@"连接服务:%@ 发生错误:%@",peripheral.name,[error localizedDescription]);
        return;
    }
    
    for (CBService* service in  peripheral.services) {
        NSLog(@"扫描到的serviceUUID:%@",service.UUID);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:Printer200ServiceUUID]]) {
            //扫描特征
            self.connectedService = service;
            [peripheral discoverCharacteristics:nil forService:service];
            break;
        }
    }
}


//扫描出特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{

    if (error) {
        NSLog(@"扫描特征:%@错误描述:%@",service.UUID,[error localizedDescription]);
        return;
    }
    for (CBCharacteristic * characteristic in service.characteristics)
    {
        if (characteristic.properties & CBCharacteristicPropertyWrite ) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            self.connectedPeripheral = peripheral;
            self.connectedService = service;
            self.connectedCharacteristic = characteristic;
            [self.centraManager stopScan];
            
        }
    }
}


#pragma mark - 本类所持有的方法
// 扫描蓝牙设备
- (void)scanPeripherals{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerOptionShowPowerAlertKey,nil];
    [self.centraManager scanForPeripheralsWithServices:nil options:options];
    
}


// 取消扫描
- (void)cancelScan
{
    [self.centraManager stopScan];
}


// 连接蓝牙设备
- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    [self clearConnectData];
    [self.centraManager connectPeripheral:peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
}
    
// 断开蓝牙设备
- (void)disConnectPeripheral:(CBPeripheral *)peripheral
{
    [self.centraManager cancelPeripheralConnection:peripheral];
}

/**
 *  写数据
 *
 *  @param peripheral
 *  @param valData
 *  @param characteristic
 *  @param type
 */
- (void)startPrint:(CBPeripheral *)peripheral writeValue:(NSData *)valData forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type
{
    [peripheral writeValue:valData forCharacteristic:characteristic type:type];
}

// 打印数据
- (void)printData:(NSData *)writeData
{
    if (self.connectedPeripheral && self.connectedCharacteristic) {
        [self startPrint:self.connectedPeripheral writeValue:writeData forCharacteristic:self.connectedCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}




@end

