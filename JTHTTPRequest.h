//
//  JTHTTPRequest.h
//  John Tsai
//
//  a simple httprequest manager base on AFNetWorking
//  Created by John Tsai on 14/12/15.
//  Copyright (c) 2014年 John Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <JSONKit/JSONKit.h>

extern NSString const*const HPTRequestBASEURL;

@interface JTHTTPRequest : NSObject

/**
 * httpClient,AFHTTPClient 只读，一个全局的AFHTTPClient
 */
@property (nonatomic, strong ,readonly) AFHTTPRequestOperationManager *httpManager;

/**
 *  初始化函数
 *
 *  @return 返回一个实例对象
 */
- (instancetype)init;

/**
 *  sharedManager
 *
 *  @return 返回一个DZHTTPRequest实例来请求数据
 */
+ (instancetype)sharedManager;

/**
 *  setSharedManager 设置新的全局实例，在需要的时候调用
 *
 *  @param request request新创建的实例的时候可以调用
 */
+ (void)setSharedManager:(JTHTTPRequest *)newRequest;

/**
 *  setDefaultHeader 设置/修改默认的请求头
 *
 *  @param header 头的名称
 *  @param value  对应的值
 */
- (void)setDefaultHeader:(NSString *)header
                   value:(NSString *)value;

///-------------------------------------------------------------------------------
/// @name convert jsondata to a json dictionary it only can affect on AFNetWorking
///-------------------------------------------------------------------------------

/**
 *  parseDataToResponseDictionaryWithData 解析AFNetWorking 返回的数据
 *
 *  @param data  json 字典
 *  @param block 返回解析之后的 response json字典 和meta对象
 */
+ (void)parseDataToResponseDictionaryWithData:(NSDictionary *)data
                                     complete:(void (^) (NSDictionary *response,NSNumber *status))block;

/**
 *  parseDataToResponseDictionaryWithData 解析AFNetWorking 返回的列表数据
 *
 *  @param data json 字典
 *  @param block 返回解析之后的 response json字典 和meta对象
 */
+ (void)parseDataToResponseArrayWithData:(NSDictionary *)data
                                complete:(void (^) (NSDictionary *response, NSNumber *status))block;

@end
