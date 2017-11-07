//
//  RACUIKitButtonViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/7.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACUIKitButtonViewController.h"

@interface RACUIKitButtonViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UIButton *buttonOne;
@property (strong, nonatomic) UILabel *labelOne;
@end

@implementation RACUIKitButtonViewController

- (void)setupUI {
    
    self.textFieldOne = ({
        _textFieldOne = [UITextField new];
        [self.view addSubview:_textFieldOne];
        self.textFieldOne.backgroundColor = [UIColor whiteColor];
        self.textFieldOne.placeholder = @"RAC textField";
        _textFieldOne;
    });
    
    self.buttonOne = ({
        _buttonOne = [UIButton buttonWithTitle:@"RAC button" fontSize:20 normalColor:[UIColor blackColor] selectedColor:[UIColor redColor]] ;
        [self.view addSubview:_buttonOne];
        _buttonOne.backgroundColor = [UIColor whiteColor];
        _buttonOne;
    });
    
    self.labelOne = ({
        _labelOne = [UILabel new];
        [self.view addSubview:_labelOne];
        _labelOne.backgroundColor = [UIColor whiteColor];
        _labelOne.textColor = [UIColor blueColor];
        _labelOne.textAlignment = NSTextAlignmentCenter;
        _labelOne.font = [UIFont systemFontOfSize:20];
        
        _labelOne;
    });
    
    [self.textFieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 2.0, [UIScreen screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight] / 10.0);
    }];
    
    
    [self.buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 4.0, [UIScreen screenHeight] / 20.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight] * 3/ 10.0);
    }];
    
    [self.labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 2.0, [UIScreen screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight]  * 4 / 10.0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self racButton];
}

- (void)racButton {
    [[self.buttonOne rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.labelOne.text = @"Button clicked";
    }];

    RAC(self, labelOne.text) = self.textFieldOne.rac_textSignal;
    
    //RAC Gesture
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [self.view addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        self.labelOne.text = @"Tap gesutre";
    }];

}

@end
