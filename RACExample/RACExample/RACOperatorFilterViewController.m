//
//  RACOperatorFilterViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorFilterViewController.h"

@interface RACOperatorFilterViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UILabel *labelOne;

@end

@implementation RACOperatorFilterViewController

- (void)setupUI {
    
    self.textFieldOne = ({
        _textFieldOne = [UITextField new];
        [self.view addSubview:_textFieldOne];
        self.textFieldOne.backgroundColor = [UIColor whiteColor];
        self.textFieldOne.placeholder = @"Filter chars < 4";
        _textFieldOne;
    });
    
    self.labelOne = ({
        _labelOne = [UILabel new];
        [self.view addSubview:_labelOne];
        _labelOne.backgroundColor = [UIColor whiteColor];
        _labelOne.textColor = [UIColor blackColor];
        _labelOne.textAlignment = NSTextAlignmentCenter;
        _labelOne.text = @"4 chars change";
        _labelOne.font = [UIFont systemFontOfSize:20];
        _labelOne;
    });

    [self.textFieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 2.0, [UIScreen screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight] / 5.0);
    }];
    
    [self.labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [self filter];
    
}

- (void)filter {
    //过滤信号，使用它可以获取满足条件的信号.是一个Bool值
    //当输入四个字符改变Label
    @weakify(self);
    [[self.textFieldOne.rac_textSignal filter:^BOOL(id value) {
        return [value length] > 3;
    }] subscribeNext:^(NSString *text) {
        @strongify(self);
        self.labelOne.text = text;
    }];

}

@end
