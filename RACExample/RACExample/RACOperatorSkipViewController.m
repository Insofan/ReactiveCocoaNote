//
//  RACOperatorSkipViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorSkipViewController.h"

@interface RACOperatorSkipViewController ()
@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UILabel *labelOne;
@end

@implementation RACOperatorSkipViewController
- (void)setupUI {
    
    self.textFieldOne = ({
        _textFieldOne = [UITextField new];
        [self.view addSubview:_textFieldOne];
        self.textFieldOne.backgroundColor = [UIColor whiteColor];
        self.textFieldOne.placeholder = @"Skip 2 char";
        _textFieldOne;
    });
    
    self.labelOne = ({
        _labelOne = [UILabel new];
        [self.view addSubview:_labelOne];
        _labelOne.backgroundColor = [UIColor whiteColor];
        _labelOne.textColor = [UIColor blackColor];
        _labelOne.textAlignment = NSTextAlignmentCenter;
        _labelOne.text = @"3 chars change";
        _labelOne.font = [UIFont systemFontOfSize:20];
        _labelOne;
    });
    
    [self.textFieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen hx_screenHeight] / 5.0);
    }];
    
    [self.labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen hx_screenHeight]  * 2 / 5.0);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor hx_randomColor];
    [self setupUI];
    
    [self skip];
}

- (void)skip {
    //跳过几个信号
    RAC(self.labelOne, text) = [[self.textFieldOne.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 0;
    }] skip:2];
}

@end
