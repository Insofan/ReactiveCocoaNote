//
//  RACOperatorIgnoreViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorIgnoreViewController.h"

@interface RACOperatorIgnoreViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UILabel *labelOne;

@end

@implementation RACOperatorIgnoreViewController

- (void)setupUI {
    
    self.textFieldOne = ({
        _textFieldOne = [UITextField new];
        [self.view addSubview:_textFieldOne];
        self.textFieldOne.backgroundColor = [UIColor whiteColor];
        self.textFieldOne.placeholder = @"Ignore char A";
        _textFieldOne;
    });
    
    self.labelOne = ({
        _labelOne = [UILabel new];
        [self.view addSubview:_labelOne];
        _labelOne.backgroundColor = [UIColor whiteColor];
        _labelOne.textColor = [UIColor blueColor];
        _labelOne.text = @"Ignore char A";
        _labelOne.textAlignment = NSTextAlignmentCenter;
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
    
    [self ignore];
    
}

- (void)ignore {
    //忽略完某些值的信号.
    //忽略A
    @weakify(self);
    [[[self.textFieldOne.rac_textSignal filter:^BOOL(id value) {
        return [value length] > 0;
    }] ignore:@"A"] subscribeNext:^(NSString *text) {
        @strongify(self);
        self.labelOne.text = text;
    }];

}


@end
