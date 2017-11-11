//
//  RACOperatorFlattenMapViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorFlattenMapViewController.h"

@interface RACOperatorFlattenMapViewController ()

@property (strong, nonatomic) UITextField *textField;
@end

@implementation RACOperatorFlattenMapViewController

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
    self.view.backgroundColor = [UIColor hx_randomColor];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self flattenMap];
}

- (void)flattenMap {
    //用于把源信号内容映射成新的信号，并降堆，注意使用了一个distinctUntilChanged，而且返回值是一个RACStream，也就是RACSignal的父类
    [[[self.textField.rac_textSignal distinctUntilChanged] flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        return [RACSignal return:value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACOperator flattenMap: %@", x);
    }];

    
}

@end
