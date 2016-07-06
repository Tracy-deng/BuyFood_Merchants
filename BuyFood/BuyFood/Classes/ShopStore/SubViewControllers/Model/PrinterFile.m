//
//  PrinterFile.m
//  BuyFood
//
//  Created by dave-n1 on 16/7/6.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PrinterFile.h"

@implementation PrinterFile

+(NSMutableData *)printerWithGoodTicket:(NSDictionary *)dic
{
    NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    
    
    NSString * buyFood = @"购菜\n";
    NSString * moreFood = @"    更多购菜      更多精彩\n";
    NSString * orderNum = @"订单号:\n";
    NSString * shopCount = @"商户:\n";
    NSString * contactNum = @"联系方式:\n";
    NSString * billTime = @"下单时间:\n";
    NSString * total = @" 菜品    单价   数量    金额\n ";
    NSString * alsoMoney = @"应收金额:\n";
    NSString * favourable = @"优惠金额:\n";
    NSString * actually = @"实收金额:\n";
    NSString * personNum = @"配送员电话:\n";
    NSString * address = @"配送地址:\n";
    NSString * acountNum = @"客户及电话:\n";
    NSString * buyFoodPer = @"购菜管理员:\n";
    NSString * phoneNum = @"联系方式:\n";
    NSString * service = @"客服:\n";
    NSString * welcome = @"     欢迎光临,  谢谢惠顾!\n";
    NSString * web = @"      www.goucaichina.com\n\n\n\n";
    
    NSMutableData *commands = [NSMutableData data];
    
    [commands appendBytes:"\x1b\x40" length:sizeof("\x1b\x40") - 1]; // Alignment (Center)
    
    // 购菜
    
    [commands appendBytes:"\x1B\x61\x1" length:3]; // center
    
    [commands appendBytes:"\x1d\x21\x11" length:3]; // set double
    
    [commands appendData:[buyFood dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1d\x21\x00" length:3]; // cancel double
    
    // 更多购菜  更多精彩
    
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[moreFood dataUsingEncoding:gbk]];
    
     [commands appendData:[@"================================\r\n" dataUsingEncoding:gbk]];
    
    // 订单号
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[orderNum dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"123456789\n"  dataUsingEncoding:gbk]];
    
    // 商户
     [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[shopCount  dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"猪肉容\n"  dataUsingEncoding:gbk]];
    
    // 联系方式
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[contactNum dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"1399123456\n" dataUsingEncoding:gbk]];
    
    // 下单时间
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[billTime dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"2016年10月1号\n" dataUsingEncoding:gbk]];
    
    [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    
    // 菜品
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[total dataUsingEncoding:gbk]];
    
    NSString *a = @"大白菜";
    NSString *b = @"1元";
    NSString *c = @"24";
    NSString *d = @"435";
    
    [commands appendData:[[NSString stringWithFormat:@"%@   %@    %@     %@\n",a,b,c,d] dataUsingEncoding:gbk]];
    
    [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    
    //应收金额
    [commands appendData:[alsoMoney dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"11.8\n" dataUsingEncoding:gbk]];
    
    // 优惠金额
    
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[favourable dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"234\n" dataUsingEncoding:gbk]];
    
    
    // 实收金额
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[actually dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"3556\n"  dataUsingEncoding:gbk]];
    
    [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];

    
    // 陪送员电话
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[personNum dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"124545646\n" dataUsingEncoding:gbk]];
    
    // 地址
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[address dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"白金汉宫\n" dataUsingEncoding:gbk]];
    
    
    // 客户及电话
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[acountNum dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"53453126576\n"  dataUsingEncoding:gbk]];
    
    [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    
    // 购菜管理员
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[buyFoodPer dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"小敏\n" dataUsingEncoding:gbk]];
    
    // 联系方式
    
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[phoneNum dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"1245678899\n" dataUsingEncoding:gbk]];

    // 客服
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[service dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"1245678899\n" dataUsingEncoding:gbk]];

    [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    
    //欢迎光临
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[welcome dataUsingEncoding:gbk]];
    
    // 网站
    [commands appendData:[web dataUsingEncoding:gbk]];
    
    
    
    
    
    return commands;

}
@end
