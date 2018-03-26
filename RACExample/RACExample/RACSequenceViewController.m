//
//  RACSequenceViewController.m
//  RACExample
//
//  Created by Insomnia on 2018/3/26.
//  Copyright © 2018年 海啸. All rights reserved.
//

#import "RACSequenceViewController.h"

@interface RACSequenceViewController ()

@end

@implementation RACSequenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self enumElement];
    @weakify(self);
    [[RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault] afterDelay:3 schedule:^{
        @strongify(self);
        [self withKeyAndValue];
    }];

    [[RACScheduler mainThreadScheduler] afterDelay:7 schedule:^{
        @strongify(self);
        [self withRACTuple];
    }];
}

- (void)enumElement {
    NSString *path   = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray  *dicArr = [NSArray arrayWithContentsOfFile:path];
    [[[dicArr rac_sequence] signal] subscribeNext:^(NSDictionary *dic) {
        NSLog(@"dic icon is %@", [dic valueForKey:@"icon"]);
        NSLog(@"dic name is %@", [dic valueForKey:@"name"]);
    }                                       error:^(NSError *_Nullable error) {
        NSLog(@"error");
    }                                   completed:^{
        NSLog(@"completed");
    }];
}

- (void)withKeyAndValue {
    LOG_DIVIDES;
    NSDictionary *dic = @{@"key1": @(1), @"key2": @"sequence"};
    [[[dic rac_valueSequence] signal] subscribeNext:^(id x) {
        NSLog(@"value is %@", x);
    }];

    [[[dic rac_keySequence] signal] subscribeNext:^(id x) {
        NSLog(@"key is %@", x);
    }];
}

- (void)withRACTuple {
    LOG_DIVIDES;
    NSDictionary *dic = @{@"one": @"one", @"two": @"two"};
    [[[dic rac_sequence] signal] subscribeNext:^(RACTwoTuple *x) {
       /*
        * RACTupleUnpack 用来分解一个字典,元组
        */
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"key %@ value %@", key, value);
    }                                    error:^(NSError *error) {
        NSLog(@"error");
    }                                completed:^{
        NSLog(@"With RACTuple complete");
    }];
}

@end
