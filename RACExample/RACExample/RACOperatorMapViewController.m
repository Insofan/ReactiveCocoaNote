//
//  RACOperatorMapViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorMapViewController.h"

@interface RACOperatorMapViewController ()

@property (strong, nonatomic) UITextField *textField;

@end

@implementation RACOperatorMapViewController

- (void)setupUI {
    
    self.textField = ({
        _textField = [UITextField new];
        [self.view addSubview:_textField];
        self.textField.backgroundColor = [UIColor whiteColor];
        _textField;
    });
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen hx_screenHeight] / 5.0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    
    [self setupUI];
    
    [self map];
}

- (void)map {
    //用于把源信号内容映射成新的内容,注意其中value是id
    [[self.textField.rac_textSignal map:^id(id value) {
        return value;
    }] subscribeNext:^(id x) {
        NSLog(@"RACOperator map: %@", x);
    }];
}

- (void)flattenMap {
    
}

@end
