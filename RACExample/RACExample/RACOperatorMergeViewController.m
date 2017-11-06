//
//  RACOperatorMergeViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorMergeViewController.h"

@interface RACOperatorMergeViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UITextField *textFieldTwo;
@end

@implementation RACOperatorMergeViewController


- (void)setupUI {

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
     make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 2.0, [UIScreen screenHeight] / 10.0));
     make.centerX.mas_equalTo(self.view);
     make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight] / 5.0);
     }];
    
    
     [self.textFieldTwo mas_makeConstraints:^(MASConstraintMaker *make) {
     make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 2.0, [UIScreen screenHeight] / 10.0));
     make.centerX.mas_equalTo(self.view);
     make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight]  * 2 / 5.0);
     }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor randomColor];
    
    [self setupUI];
    [self merge];
}

- (void)merge {
    
    //把多个信号合并为一个信号，任何一个信号有新值的时候就会调用，并不需要sendComplted
    RACSignal *signalOne = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signal one"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalTwo = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signal two"];
        return nil;
    }];
    
   
    RACSignal *mergeSignal = [[[signalOne merge:signalTwo] merge:self.textFieldOne.rac_textSignal] merge:self.textFieldTwo.rac_textSignal];
    
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator merge: %@",x);
    }];

}

@end
