//
//  RACOperatorConcatViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorConcatViewController.h"

@interface RACOperatorConcatViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UITextField *textFieldTwo;
@end

@implementation RACOperatorConcatViewController

- (void)setupUI {
    
    /*
    self.textFieldOne = ({
        _textFieldOne = [UITextField new];
        [self.view addSubview:_textFieldOne];
        self.textFieldOne.backgroundColor = [UIColor whiteColor];
        _textFieldOne;
    });
    
    self.textFieldTwo = ({
        _textFieldTwo = [UITextField new];
        [self.view addSubview:_textFieldTwo];
        self.textFieldTwo.backgroundColor = [UIColor whiteColor];
        _textFieldTwo;
    });
    
    [self.textFieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen hx_screenHeight] / 5.0);
    }];
    
    [self.textFieldTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen hx_screenHeight]  * 2 / 5.0);
    }];
    */
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    //
    [self setupUI];
    [self concat];
}

- (void)concat {
    
    //concat有顺序的拼接信号，必须要等到第一个signal complete后第二个signal才会被订阅，注意第一个signal中的sendCompleted, 但在fmdb中使用then和concat会造成死锁, 说明信号并没有全部完成, 需要flattenMap让信号真正完成,fmdb才不会形成 inDatabase 套 inDatabase的死锁情况
    RACSignal *signalOne = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signal one"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalTwo = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signal two"];
        return nil;
    }];
    
    RACSignal *concatSignal = [signalOne concat:signalTwo];
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator concat: %@", x);
    }];
}

@end
