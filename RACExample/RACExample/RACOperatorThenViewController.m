//
//  RACOperatorThenViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorThenViewController.h"

@interface RACOperatorThenViewController ()

@end

@implementation RACOperatorThenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    [self then];
}

- (void)then {
    
    //then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号,而第一个信号则会被忽略
    RACSignal *signalOne = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signal one"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalTwo = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signal two"];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    [[signalOne then:^RACSignal *{
        return signalTwo;
    }] subscribeNext:^(id x) {
        NSLog(@"RACOperator concat: %@", x);
    }];
    
    
}

@end
