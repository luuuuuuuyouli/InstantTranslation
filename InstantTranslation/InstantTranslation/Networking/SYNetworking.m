//
//  SYNetworking.m
//  DriftBooks
//
//  Created by syong on 2019/4/4.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYNetworking.h"

@implementation SYNetworking


+(void)httpGet:(NSDictionary *)params  method:(NSString *)host success:(void(^)(id responseObject, NSString *json))success fail:(void(^)(NSError *error))fail
{
    NSLog(@"请求地址%@",host);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
   // [manager.requestSerializer setValue:Apikey forHTTPHeaderField:@"x-apikey"];
    // 超过时间
    manager.requestSerializer.timeoutInterval = 20;
    
//    // 声明上传的是json格式的参数 ， 需要和你后台约定好，不然会出现无法获取到你上传的参数问题
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    NSLog(@"--------请求参数 GET------%@",params);
    [manager GET:host parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *jsonStr;
        if (responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
            jsonStr = [[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        }
        if (success) {
            NSLog(@"------请求结果------%@",responseObject);
            success(responseObject,jsonStr);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            NSLog(@"************错误信息************%@",error);
//            showError(@"网络异常，请稍后再试")
            fail(error);
        }
    }];
}

// post请求
+ (void)httpPost:(NSDictionary *)params method:(NSString *)host success:(void(^)(id responseObject, NSString *strjson))success fail:(void (^) (NSError *error))fail
{
    NSLog(@"请求地址%@",host);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //  超过时间
    manager.requestSerializer.timeoutInterval = 20;
    
   // [manager.requestSerializer setValue:Apikey forHTTPHeaderField:@"x-apikey"];
    
    // 接受类型
  //  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSLog(@"--------请求参数 POST------%@",params);
    [manager POST:host parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr ;
        if (responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil]
            ;
            jsonStr = [[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        }
        
        if (success) {
            NSLog(@"------请求结果------%@",responseObject);
            success(responseObject,jsonStr);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            NSLog(@"************错误信息************%@",error);
          //  showError(@"网络异常，请稍后再试")
            fail(error);
        }
        
    }];
    
}

+ (void)httpPut:(NSDictionary *)params method:(NSString *)host success:(void(^)(id responseObject,NSString *json))success fail:(void (^) (NSError *error))fail{
    
    NSLog(@"请求地址%@",host);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //  超过时间
    manager.requestSerializer.timeoutInterval = 20;
    
   // [manager.requestSerializer setValue:Apikey forHTTPHeaderField:@"x-apikey"];
    
    // 接受类型
    //  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSLog(@"--------请求参数 POST------%@",params);

    [manager PUT:host parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr ;
        if (responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil]
            ;
            jsonStr = [[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        }
        
        if (success) {
            NSLog(@"------请求结果------%@",responseObject);
            success(responseObject,jsonStr);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            NSLog(@"************错误信息************%@",error);
            //  showError(@"网络异常，请稍后再试")
            fail(error);
        }

    }];
    
}


+ (void)httpDelete:(NSDictionary *)params method:(NSString *)host success:(void(^)(id responseObject,NSString *json))success fail:(void (^) (NSError *error))fail{
    
    NSLog(@"请求地址%@",host);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //  超过时间
    manager.requestSerializer.timeoutInterval = 20;
    
 //   [manager.requestSerializer setValue:Apikey forHTTPHeaderField:@"x-apikey"];
    
    // 接受类型
    //  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSLog(@"--------请求参数 POST------%@",params);
    
    [manager DELETE:host parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr ;
        if (responseObject) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil]
            ;
            jsonStr = [[NSString alloc]initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        }
        
        if (success) {
            NSLog(@"------请求结果------%@",responseObject);
            success(responseObject,jsonStr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail) {
            NSLog(@"************错误信息************%@",error);
            //  showError(@"网络异常，请稍后再试")
            fail(error);
        }

    }];
    
}



@end
