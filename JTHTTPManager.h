//
//  JTHTTPManager.h
//  JTHTTPManager
//
//  Created by John TSai on 15/4/2.
//  Copyright (c) 2015年 John TSai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

@interface JTHTTPManager : AFHTTPRequestOperationManager

@property (nonatomic, assign, readonly, getter=getNetWotkingQueue) dispatch_queue_t netWorkingQueue;

+ (instancetype)sharedManager;

@end
