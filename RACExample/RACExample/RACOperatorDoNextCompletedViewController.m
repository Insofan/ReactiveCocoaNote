//
//  RACOperatorDoNextCompletedViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorDoNextCompletedViewController.h"

@interface RACOperatorDoNextCompletedViewController ()

@end

@implementation RACOperatorDoNextCompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor randomColor];
    [self doNextAndDoCompleted];
}

- (void)doNextAndDoCompleted {
    //doNext 在next之前运行block， doCompleted 在completed之前运行block
    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"RAC operator sendNext"];
        [subscriber sendCompleted];
        return nil;
    }] doNext:^(id  _Nullable x) {
        NSLog(@"doNext");
    }] doCompleted:^{
        NSLog(@"doCompleted");
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
