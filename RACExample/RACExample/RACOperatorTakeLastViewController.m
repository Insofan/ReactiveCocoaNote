//
//  RACOperatorTakeLastViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorTakeLastViewController.h"

@interface RACOperatorTakeLastViewController ()

@end

@implementation RACOperatorTakeLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self takeLast];
}

- (void)takeLast {
    //takeLast 从最后取N次信号,前提是signal必须sendCompleted
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signal 1"];
        [subscriber sendNext:@"signal 2"];
        [subscriber sendNext:@"signal 3"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[signal takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC operator take: %@", x);
    }];
    
    RACSubject *subject = [RACSubject subject];
    
    [subject sendNext:@"subject 0"];
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC operator take: %@", x);
    }];
    
    [subject sendNext:@"subject 1"];
    [subject sendNext:@"subject 2"];
    [subject sendNext:@"subject 3"];
    [subject sendCompleted];
    //takeUntil:(RACSignal *) 直到某个信号完成后才取值
}

@end
