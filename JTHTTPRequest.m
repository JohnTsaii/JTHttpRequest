//
//  JTHTTPRequest.m
//  a simple httprequest manager base on AFNetWorking
//
//  Created by John Tsai on 14/12/15.
//  Copyright (c) 2014年 John Tsai. All rights reserved.
//

#import "JTHTTPRequest.h"

static JTHTTPRequest *request = nil;

// http://h1.autoepp.com 正式环境接口
#if DebugMode
NSString const*const JTRequestBASEURL = @"the base url for you appliction debugmode";
#else
NSString const*const JTRequestBASEURL = @"the base url for you appliction releasemode";

#endif

@implementation JTHTTPRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpManager = [self createOperationManager];
        
        if (request == nil) {
            request = self;
        }
    }
    return self;
}

+ (instancetype)sharedManager
{
    return request;
}

+ (void)setSharedManager:(JTHTTPRequest *)newRequest
{
    request = newRequest;
}

#pragma mark -
#pragma mark SetHTTPClient
/**
 *  shareHTTPClient
 *
 *  @return 共享一个client
 */
- (AFHTTPRequestOperationManager *)createOperationManager
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:JTRequestBASEURL]];
    // 设置url数据请求报头
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

- (void)setDefaultHeader:(NSString *)header
                   value:(NSString *)value
{
    [_httpManager.requestSerializer setValue:value forHTTPHeaderField:header];
}

#pragma mark -
#pragma mark ParseData
+ (void)parseDataToResponseDictionaryWithData:(id)data complete:(void (^) (NSDictionary *response, NSNumber *status))block;
{
    if (data) {
        NSDictionary *dict = [data objectFromJSONData];
        NSNumber *status  = [dict objectForKey:@"status"];
        NSDictionary *response = [dict objectForKey:@"data"];
        if (block) {
            block(response, status);
        }
    } else {
        NSLog(@"parse data failed because the data is nil");
    }
    
}

+ (void)parseDataToResponseArrayWithData:(id)data complete:(void (^) (NSDictionary *response, NSNumber *status))block;
{
    if (data) {
        NSDictionary *dict = [data objectFromJSONData];
        NSNumber *status  = [dict objectForKey:@"status"];
        NSDictionary *response = dict;
        if (block) {
            block(response, status);
        }
    } else {
        NSLog(@"parse data failed because the data is nil");
    }
}

@end
