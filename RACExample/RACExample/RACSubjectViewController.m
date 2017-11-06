//
//  RACSubjectViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACSubjectViewController.h"

@interface RACSubjectViewController ()

@end

@implementation RACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    
    [self createBehaviorSubject];
    
    [self createReplaySubject];
}

//RACSubject是RACSignal的子类，注意名字subject就是其动词 提供的意思，所以跟RACSignal不同的是，RACSubject并不需要订阅者subscriber就能发送，可以直接sendNext，sendError(option)，和sendComplete(option)，另外与RACSignal不同的RACSubject默认是一个热信号，常用来代替delegate，block页面间传值，详见CallBack

- (void)createBehaviorSubject {
    //第一种RACSubject：RACBehaviorSubject，当被订阅时，会向订阅者发送它最后接受到的值,并不关心历史状态，重新订阅并不会发送历史消息，错过了就错过了
    RACSubject *subject1 = [RACSubject subject];
    //订阅者1会受到下面两个sendNext
    [subject1 subscribeNext:^(id x) {
        NSLog(@"RACSubject subject1 subscriber1 :%@", x);
    }];
    
    [subject1 sendNext:@"subject1 1"];
    
    //订阅者2因为在第一个sendNext后声明，所以只会收到一个sendNext
    [subject1 subscribeNext:^(id x) {
        NSLog(@"RACSubject subject1 subscriber2 :%@", x);
    }];
    
    [subject1 sendNext:@"subject1 2"];
    
    //感受冷信号的不同
    RACSubject *subject2 = [RACSubject subject];
    
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [subject2 sendNext:@"1"];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
        [subject2 sendNext:@"2"];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
        [subject2 sendNext:@"3"];
    }];
 
    //注意下面和RACSignal subscribeNext的不同
    
    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
        [subject2 subscribeNext:^(id x) {
            //因为在1.1秒所以只能收到2，3
            NSLog(@"RACSubject subject2 subscriber1 :%@", x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
        [subject2 subscribeNext:^(id x) {
            //因为在2.1秒所以只能收到3
            NSLog(@"RACSubject subject2 subscriber2 :%@", x);
        }];
    }];
}

- (void)createReplaySubject {
    //使RACSubject变为类似于RACSignal的冷信号
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    //因为是RACReplaySubject，所以订阅者会收到所有的历史消息
    [subject subscribeNext:^(id x) {
        NSLog(@"RACReplaySubject subscriber1: %@", x);
    }];
    
    [subject sendNext:@"1"];

    //因为是RACReplaySubject，所以订阅者会收到所有的历史消息
    [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
        [subject subscribeNext:^(id x) {
            NSLog(@"RACReplaySubject subscriber2: %@", x);
        }];
    }];

    [subject sendNext:@"2"];
    
    //并未理解RACGroupedSignal
}

@end
