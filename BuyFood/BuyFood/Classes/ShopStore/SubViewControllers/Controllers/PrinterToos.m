//
//  PrinterToos.m
//  BuyFood
//
//  Created by dave-n1 on 16/8/19.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PrinterToos.h"
#import "PrintSetting.h"
#import "PrinterFile.h"

@interface PrinterToos()<CCPrinterSettingDelegate>
@property (nonatomic, strong) PrintSetting *manager;
@property (nonatomic, strong) NSMutableDictionary *printDic;
@end
@implementation PrinterToos

- (NSMutableDictionary *)printDic
{
    if (_printDic == nil) {
        self.printDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _printDic;
}
+(instancetype) sharePrinterToos
{
    
    static PrinterToos *printerToos = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        printerToos = [[PrinterToos alloc]init];
    });
    
    return printerToos;
                  
}

- (void)printerTicket:(NSArray *)array
{
    self.manager = [PrintSetting shareManager];
    
    self.manager.delegate = self;
    
    self.printDic = array[0];
    
    [self.manager printData:[PrinterFile printerWithGoodTicket: self.printDic]];

}
@end
