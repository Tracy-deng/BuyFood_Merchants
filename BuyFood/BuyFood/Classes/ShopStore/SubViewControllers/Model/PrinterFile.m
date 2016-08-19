//
//  PrinterFile.m
//  BuyFood
//
//  Created by dave-n1 on 16/7/6.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PrinterFile.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
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
    NSString * total = @" 菜品        数量        金额\n ";
    NSString * actually = @"总金额:\n";
    NSString * address = @"配送地址:\n";
    NSString * acountNum = @"客户及电话:\n";

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
    
    if (dic[@"orderno"] != nil) {
        // 订单号
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[orderNum dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",dic[@"orderno"] ]  dataUsingEncoding:gbk]];
    }
    
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    if ( shopsInfo.marketname != nil) {
        // 商户
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[shopCount  dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",shopsInfo.marketname]  dataUsingEncoding:gbk]];
    }
    
    
    if (shopsInfo.telephone != nil) {
        // 联系方式
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[contactNum dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",shopsInfo.telephone] dataUsingEncoding:gbk]];
    }
    
    if ( dic[@"ordertime"] != nil ) {
        // 下单时间
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[billTime dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",dic[@"ordertime"]] dataUsingEncoding:gbk]];
        
        [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    }
    
    
    // 菜品
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[total dataUsingEncoding:gbk]];
    
    NSArray *shopArray = dic[@"OrderDetailList"];
    
    if (shopArray.count > 0) {
        for (int i = 0; i < shopArray.count; i++) {
            NSString *a = [shopArray[i] objectForKey:@"productname"];
            NSString *c = [shopArray[i] objectForKey:@"productcount"];
            NSString *d = [shopArray[i] objectForKey:@"productprice"];
            
            [commands appendData:[[NSString stringWithFormat:@"%@         %@         %@\n",a,c,d] dataUsingEncoding:gbk]];
            
            [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
        }
    }

    
    
    // 实收金额
    
    if( dic[@"markettotalmoney"] != nil)
    {
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[actually dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",dic[@"markettotalmoney"]]  dataUsingEncoding:gbk]];
        
        [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    }


    
    if (  dic[@"marketuseraddress"]  != nil) {
        // 地址
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[address dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",dic[@"marketuseraddress"]] dataUsingEncoding:gbk]];
    }
   
    
    
    // 客户及电话
    if(dic[@"telephone"] != nil){
        [commands appendBytes:"\x1B\x61\x0" length:3];     // left
        
        [commands appendData:[acountNum dataUsingEncoding:gbk]];
        
        [commands appendBytes:"\x1B\x61\x2" length:3];  // right
        
        [commands appendData:[[NSString stringWithFormat:@"%@\n",dic[@"telephone"]]   dataUsingEncoding:gbk]];
        
        [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    }
    


    // 客服
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[service dataUsingEncoding:gbk]];
    
    [commands appendBytes:"\x1B\x61\x2" length:3];  // right
    
    [commands appendData:[@"025-66070775\n" dataUsingEncoding:gbk]];

    [commands appendData:[@"--------------------------------\r\n" dataUsingEncoding:gbk]];
    
    //欢迎光临
    [commands appendBytes:"\x1B\x61\x0" length:3];     // left
    
    [commands appendData:[welcome dataUsingEncoding:gbk]];
    
    // 网站
    [commands appendData:[web dataUsingEncoding:gbk]];
    
    
    
    
    
    return commands;

}
@end
