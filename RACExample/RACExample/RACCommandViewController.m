//
// Created by Insomnia on 2018/3/26.
// Copyright (c) 2018 海啸. All rights reserved.
//

#import "RACCommandViewController.h"


@implementation RACCommandViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self withExecute];
    /*RACCommand 是一个热信号不关心历史值*/
    @weakify(self);
    [[RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault] afterDelay:3 schedule:^{
        @strongify(self);
        LOG_DIVIDES;
        [self withExecutionSignals];
    }];

    [[RACScheduler mainThreadScheduler] afterDelay:6 schedule:^{
        LOG_DIVIDES;
        [self withSwitchToLatest];
    }];
}

- (void)withExecute {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input is %@", input);
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"text"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    /*
     * command 的execute后面跟参数 在input中接收, 再用sendNext传出
     * execute 其实用的是replaySubject 可以先发送参数再订阅
     * 实际上是热信号转冷信号
     */
    RACSignal  *signal  = [command execute:@"input params"];
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)withExecutionSignals {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input is %@", input);
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"test command"];
            [subscriber sendCompleted];
            return nil;
        }];
        return signal;
    }];
    /*这里必须先订阅才能发送, 因为executionSignals：信号源，信号中信号，signalofsignals:信号，发送数据就是信号*/
    [command.executionSignals subscribeNext:^(RACSignal *firstX) {
        NSLog(@"%@", firstX);
        [firstX subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
    }];

    [command execute:@(2)];
}

- (void)withSwitchToLatest {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input %@", input);
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:@"发送信号"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];

//    [command execute:@(3)];
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

    [command execute:@(3)];
}

@end