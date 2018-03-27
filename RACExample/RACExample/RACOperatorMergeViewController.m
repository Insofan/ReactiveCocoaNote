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
@property(strong, nonatomic) UILabel     *labelOne;

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
    self.view.backgroundColor  = [UIColor hx_randomColor];
    
    [self setupUI];
    [self merge];
}

- (void)merge {
    
    //把多个信号合并为一个信号，任何一个信号有新值的时候就会调用最新信号，与信号的发送顺序有关,会调用最新的新号,且并不需要sendComplted

    RACSignal *mergeSignal = [self.textFieldOne.rac_textSignal merge:self.textFieldTwo.rac_textSignal];

    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator merge: %@",x);
    }];
    RAC(self.labelOne, text) = mergeSignal;

}

@end
