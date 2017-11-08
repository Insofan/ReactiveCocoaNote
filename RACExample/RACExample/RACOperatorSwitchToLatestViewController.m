//
//  RACOperatorSwitchToLatestViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorSwitchToLatestViewController.h"

@interface RACOperatorSwitchToLatestViewController ()

@end

@implementation RACOperatorSwitchToLatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor randomColor];

    [self switchLatest];
}

- (void)switchLatest {
    RACSubject *fatherSubject = [RACSubject subject];
    RACSubject *sonSubject = [RACSubject subject];
    
    [fatherSubject.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC operator switchLatest: %@", x);
    }];
    
    [fatherSubject sendNext:sonSubject];
    [sonSubject sendNext:@"subject son"];

}

@end
