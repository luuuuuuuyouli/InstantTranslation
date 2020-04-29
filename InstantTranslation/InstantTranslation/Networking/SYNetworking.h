//
//  SYNetworking.h
//  DriftBooks
//
//  Created by syong on 2019/4/4.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYNetworking : NSObject


// get请求
+(void)httpGet:(NSDictionary *)params  method:(NSString *)method success:(void(^)(id responseObject, NSString *json))success fail:(void(^)(NSError *error))fail;

// post请求
+ (void)httpPost:(NSDictionary *)params method:(NSString *)method success:(void(^)(id responseObject,NSString *json))success fail:(void (^) (NSError *error))fail;

// PUT请求
+ (void)httpPut:(NSDictionary *)params method:(NSString *)method success:(void(^)(id responseObject,NSString *json))success fail:(void (^) (NSError *error))fail;

// delete请求
+ (void)httpDelete:(NSDictionary *)params method:(NSString *)method success:(void(^)(id responseObject,NSString *json))success fail:(void (^) (NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
