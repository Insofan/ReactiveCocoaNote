//
//  RACOperatorTakeViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorTakeViewController.h"

@interface RACOperatorTakeViewController ()

@end

@implementation RACOperatorTakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    
    [self take];
}

- (void)take {
    //take 从开始取N次信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"signal 1"];
        [subscriber sendNext:@"signal 2"];
        [subscriber sendNext:@"signal 3"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[signal take:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC operator take: %@", x);
    }];
    
    RACSubject *subject = [RACSubject subject];
    
    [subject sendNext:@"subject 0"];
    [[subject take:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC operator take: %@", x);
    }];
    
    [subject sendNext:@"subject 1"];
    [subject sendNext:@"subject 2"];
    [subject sendNext:@"subject 3"];
    
}

@end
