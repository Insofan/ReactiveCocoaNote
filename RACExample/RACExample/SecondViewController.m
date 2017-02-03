//
//  SecondViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/3.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton    *button;
@end

@implementation SecondViewController
#pragma mark: setupUI
- (void)setupUI {
    self.textField = ({
        _textField = [UITextField new];
        [self.view addSubview:_textField];
        self.textField.placeholder = @"Enter something";
        _textField.backgroundColor = [UIColor whiteColor];
        _textField;
    });
    
    self.button = ({
        _button = [UIButton new];
        [self.view addSubview:_button];
        _button.backgroundColor = [UIColor blueColor];
        [_button setTitle:@"Send Back" forState:UIControlStateNormal];
        _button.titleLabel.textColor = [UIColor blackColor];
        [_button addTarget:self action:@selector(sendBack) forControlEvents:UIControlEventTouchUpInside];
        _button;
    });
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(50);
    }];
}

- (void)sendBack {
    //1.subject send value
    [self.subject sendNext:self.textField.text];
    [self.navigationController popViewControllerAnimated:true];
}



- (void)viewDidLoad {
    [self setupUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
}


@end
