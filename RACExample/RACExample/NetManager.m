//
//  NetManager.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "NetManager.h"

static AFHTTPSessionManager *_sharedNetManager = nil;

@implementation NetManager

- (instancetype)init
{
    [NSException raise:@"SingletonPattern"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    [NSException raise:@"SingletonPattern"
                format:@"Cannot copy singleton using copy method, sharedInstance must be used."];
    return nil;
}

+ (AFHTTPSessionManager *)sharedNetManager {
    if (self != [NetManager class]) {
        [NSException raise:@"SingletonPattern" format:@"Cannot use sharedInstance method from subclass."];
    }
    
    static dispatch_once_t onceTokken;
    
    dispatch_once(&onceTokken, ^{
        _sharedNetManager = [AFHTTPSessionManager new];
    });

    return _sharedNetManager;
}

@end
