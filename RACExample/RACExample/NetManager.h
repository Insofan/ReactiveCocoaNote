//
//  NetManager.h
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <AFNetworking.h>
#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+ (AFHTTPSessionManager *)sharedNetManager;
@end
