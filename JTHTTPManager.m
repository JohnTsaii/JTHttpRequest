//
//  JTHTTPManager.m
//  JTHTTPManager
//
//  Created by John Tsai on 15/4/2.
//  Copyright (c) 2015年 John TSai. All rights reserved.
//

#import "JTHTTPManager.h"

#if DEBUG
static NSString *BASEURL = @"you debug mode base url";
#else
static NSString *BASEURL = @"you release mode base url";
#endif

@implementation JTHTTPManager

// share the global manager
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static JTHTTPManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.completionQueue = create_queue();
    });
    return manager;
}

// crate unique queue
dispatch_queue_t create_queue() {
    static dispatch_queue_t queue = nil;
    if (!queue) {
        queue = dispatch_queue_create("com.myapp.newWorkingQueue", NULL);
    }
    return queue;
}

// get the global unique queue
- (dispatch_queue_t)getNetWotkingQueue {
    return create_queue();
}

@end
