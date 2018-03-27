//
//  RACOperatorCombineLatestViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorCombineLatestViewController.h"

@interface RACOperatorCombineLatestViewController ()

@property(strong, nonatomic) UITextField *textFieldOne;
@property(strong, nonatomic) UITextField *textFieldTwo;
@property(strong, nonatomic) UILabel     *labelOne;

@end

@implementation RACOperatorCombineLatestViewController
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

    self.labelOne = ({
        _labelOne = [UILabel new];
        [self.view addSubview:_labelOne];
        _labelOne.backgroundColor = [UIColor whiteColor];
        _labelOne;
    });

    [self.textFieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen hx_screenHeight] / 10.0);
    }];


    [self.textFieldTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.textFieldOne.mas_bottom).mas_offset([UIScreen hx_screenHeight] / 20.0);
    }];

    [self.labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.textFieldTwo.mas_bottom).mas_offset([UIScreen hx_screenHeight] / 20.0);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self setupUI];

//    [self combineLatest];
}

- (void)combineLatest {
    //将多个信号合并起来，并且拿到各个信号的最新的值,任意的signal有过一次sendNext，就会触发合并的信号,与zipWith不同的是，combineLatest并不需要一一对应的signal才能输出，只是单纯拿到最新的值, 发送出来的是一个ractuple
    [[[self.textFieldOne.rac_textSignal distinctUntilChanged] combineLatestWith:[self.textFieldTwo.rac_textSignal distinctUntilChanged]] subscribeNext:^(id x) {
        RACTupleUnpack(NSString *one, NSString *two) = x;
        NSLog(@"RACOperator combineLatest: %@", x);
        self.labelOne.text = [NSString stringWithFormat:@"%@  %@", one, two];
    }];
}


@end
