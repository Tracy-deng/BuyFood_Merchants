//
//  GoodsViewController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/29.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "UpLoadImageUtil.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#define kUploadImageMaxByteCount (1024 * 300.0)

typedef void (^UpLoadImageBlock)(id<AFMultipartFormData> formData);

@implementation UpLoadImageUtil



+ (void )uploadImage:(id )image
             success:(void (^)(id response))success
             failure:(void (^)())failure{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *strToken = [userDef objectForKey:@"TokenString"];
    
    NSString *boundary = [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
    NSMutableData *body = [NSMutableData data];
    //token数据
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:strToken forKey:@"token"];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSMutableString *fieldStr = [NSMutableString string];
        [fieldStr appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]];
        [fieldStr appendString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key]];
        [fieldStr appendString:[NSString stringWithFormat:@"%@", obj]];
        [body appendData:[fieldStr dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    NSString *urlStr = @"http://www.goucaichina.com:81/fileUpLoad/fileUpLoad";//接口
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    // 图片数据部分
    NSMutableString *topStr = [NSMutableString string];
    BOOL isSingle =  [image isKindOfClass:[UIImage class]];
    
    [topStr appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]];
    [topStr appendString:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"001.png\"\r\n"];
    [topStr appendString:@"Content-Type:image/png\r\n"];
    [topStr appendString:@"Content-Transfer-Encoding: binary\r\n\r\n"];
    [body appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    if (isSingle)
    {
        NSData *data = UIImageJPEGRepresentation(image, 0.75);
        [body appendData:data];
    }
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 结束部分
    NSString *bottomStr = [NSString stringWithFormat:@"--%@--", boundary];
    [body appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPMethod = @"POST";
    [request setValue:@"96a9daa7-d8cd-c197-2432-91107b2d4b7f" forHTTPHeaderField:@"postman-token"];
    [request setValue:@"cache-control" forHTTPHeaderField:@"cache-control"];
    [request setValue:@"Basic ZG9iZXN0OmRiMTIzNDU2" forHTTPHeaderField:@"authorization"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)body.length] forHTTPHeaderField:@"Content-Length"];
    // 设置头部数据，指定了http post请求的编码方式为multipart/form-data（上传文件必须用这个）。
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30;
    // 设置request的请求体
    request.HTTPBody = body;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            
            NSLog(@"看报下传图片报多少 %ld",httpRes.statusCode);
            if (httpRes.statusCode == 200) {
            
                NSError *jsonError;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&jsonError];
                HDCLog(@"dicmsg ==== %@",dic[@"msg"]);
                HDCLog(@"dic ===== %@",dic);
                success(dic);
                
            }
        }else{
            failure();
        }
    }];
    
    
     [dataTask resume];
    
    

}




+ (void )upLoadImage:(id )parms
             success:(void (^)(id response))success
             failure:(void (^)())failure{
    if (parms == nil) {
        failure();
        return;
    }
    
    if (!([parms isKindOfClass:[UIImage class]] || [parms isKindOfClass:[NSArray class]])) {
        failure();
        return;
    }
    
    if ([parms isKindOfClass:[NSArray class]] && [parms count] == 0) {
        failure();
        return;
    }
    
    [UpLoadImageUtil uploadImage:parms success:success failure:failure];
    
    
}



@end
