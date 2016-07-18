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



static NSString *upLoadImagePath;   //图片地址

/* 图片上传*/
+ (void )uploadImage:(id )image
             success:(void (^)(id response))success
             failure:(void (^)())failure{
    BOOL isSingle =  [image isKindOfClass:[UIImage class]];
    if (isSingle) {
#pragma mark -- 服务器的URL
        NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"fileUpLoad/fileUpLoad"];
        upLoadImagePath = url;
        [self upLoadImageBlock:^(id<AFMultipartFormData> formData) {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            double mul = data.length / kUploadImageMaxByteCount;
            //图片压缩
            if (mul > 1) {
                double compressionQuality= 1 / sqrt(mul);
                data =  UIImageJPEGRepresentation(image, compressionQuality);
            }
            NSString *fileName = [NSString stringWithFormat:@"IMAGE_0.jpg"];
            NSString *formKey = [NSString stringWithFormat:@"file_0"];
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:data name:formKey fileName:fileName mimeType:type];
        } success:^(id response) {
            NSDictionary *dic = (NSDictionary *)response;
            success(dic[@"content"][@"url"]);
        } failure:^{
            failure();
        }];
    }else{
#pragma mark -- 服务器的URL
        NSString *url = [NSString stringWithFormat:@"%@%@",urlPrex,@"fileUpLoad/fileUpLoad"];
        upLoadImagePath = url;
        [self upLoadImageBlock:^(id<AFMultipartFormData> formData) {
            for (NSInteger i = 0; i < [image count]; i++) {
                id obj = image[i];
                if (![obj isKindOfClass:[UIImage class]]) {
                    continue;
                }
                NSData *data = UIImageJPEGRepresentation(obj, 1.0);
                double mul = data.length / kUploadImageMaxByteCount;
                if (mul > 1) {
                    double compressionQuality= 1/sqrt(mul);
                    data =  UIImageJPEGRepresentation(obj, compressionQuality);
                }
                NSString *fileName = [NSString stringWithFormat:@"IMAGE_%@.jpg",@(i)];
                NSString *formKey = [NSString stringWithFormat:@"file_%@",@(i)];
                NSString *type = @"image/jpeg";
                [formData appendPartWithFileData:data name:formKey fileName:fileName mimeType:type];
            }
        } success:^(id response) {
            NSDictionary *dic = (NSDictionary *)response;
            NSArray *arr = dic[@"content"];
            NSMutableArray *urlArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                [urlArr addObject:dic[@"url"]];
            }
            success(urlArr);
        } failure:^{
            failure();
        }];
    }
}

+ (void)upLoadImageBlock:(UpLoadImageBlock ) imageBlock
                  success:(void (^)(id response))success
                  failure:(void (^)())failure{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:upLoadImagePath]];
    
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 30;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            
            NSLog(@"看报下传图片报多少 %ld",httpRes.statusCode);
            if (httpRes.statusCode == 200) {
                
                NSError *jsonError;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:&jsonError];
                
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
