//
//  SunNetUtils.m
//  海信山东空调
//
//  Created by Sun on 16/4/11.
//  Copyright © 2016年 kedauis. All rights reserved.
//

#import "SunNetUtils.h"

@implementation SunNetUtils

+ (void)get:(NSString *)url params:(id)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 5; // 设置请求超时
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress)
     {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (success)
         {
             NSDictionary *dic = [SunXMLUtils parserXMLWithData:responseObject];
             success(dic);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (failure)
             failure(error);
     }];
}

@end
