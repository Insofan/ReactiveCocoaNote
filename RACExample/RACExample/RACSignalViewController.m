//
//  RACSignalViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACSignalViewController.h"

@interface RACSignalViewController ()

@end

@implementation RACSignalViewController


/**
 RACSignal是最基本的概念， 当信号本身发生变化，就会改变数据，但本身默认是一个冷信号，当有订阅者才会发出信号，用subscribNext就能订阅
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    [self createSignal];
}

- (void)createSignal {
    
    //RACDynamicSignal:动态信号，使用一个 block - 来实现订阅行为，我们在使用 RACSignal 的 +createSignal: 方法时创建的就是该类的实例；
    
    NSError *error;
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //        if (condition) {
        //            [subscriber sendError:error];
        //        } else{
        
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendCompleted];
        
        //        }
        return [RACDisposable disposableWithBlock:^{
            //析构
        }];
    }];
    
    //有了订阅者才发出信号
    [signal subscribeError:^(NSError *error) {
        
        NSLog(@"Create signal error: %@", error);
    }];
    
    //因为signal是冷信号，所以每当有新订阅以后需要重新发送，会按顺序出现两组1，2，3
    
    [signal subscribeNext:^(id x) {
        NSLog(@"Create signal first: %@", x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"Create signal second: %@", x);
    }];
    
    [signal subscribeCompleted:^{
        NSLog(@"Create signal complete");
    }];
    
    //空信号，只是用来实现RACSignal，所以并不会有输出
    RACSignal *emptySignal = [RACSignal empty];
    
    [emptySignal subscribeNext:^(id x) {
        NSLog(@"Create empty signal: %@",x);
    }];
    
    //一元信号,用来返回任意一种值，其中return：常用返回 Block中的参数
    RACSignal *returnSignal = [RACSignal return:@"It's a return signal"];
    [returnSignal subscribeNext:^(id x) {
        NSLog(@"Create return signal: %@", x);
    }];
    
    //错误信号，并未发生错误所以不会有输出
    RACSignal *errorSignal = [RACSignal error:error];
    [errorSignal subscribeNext:^(id x) {
        NSLog(@"Create error signal: %@", x);
    }];
    
    //RACChannelTerminal:通道终端，代表 RACChannel 的一个终端，用来实现双向绑定。本人还未理解
    
}

@end
