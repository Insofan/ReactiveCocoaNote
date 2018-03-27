//
//  RACOperatorReduceViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorReduceViewController.h"

@interface RACOperatorReduceViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UITextField *textFieldTwo;
@property(strong, nonatomic) UILabel     *labelOne;
@property(strong, nonatomic) UILabel     *labelTwo;


@end

@implementation RACOperatorReduceViewController

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
    
    self.labelTwo = ({
        _labelTwo = [UILabel new];
        [self.view addSubview:_labelTwo];
        _labelTwo.backgroundColor = [UIColor whiteColor];
        _labelTwo;
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
    
    [self.labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen hx_screenWidth] / 2.0, [UIScreen hx_screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.labelOne.mas_bottom).mas_offset([UIScreen hx_screenHeight] / 20.0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor hx_randomColor];
    [self setupUI];
    
    [self reduce];
}

- (void)reduce {
    //用于信号发出的内容是元组，把信号发出元组的值聚合成一个值,
    RACSignal *reduceZipWithSignal = [RACSignal zip:@[self.textFieldOne.rac_textSignal, [self.textFieldTwo.rac_textSignal distinctUntilChanged]] reduce:^id (NSString *textOne, NSString *textTwo){
        return [NSString stringWithFormat:@"zip %@ %@", textOne, textTwo];
    }];
    RAC(self.labelOne, text) = reduceZipWithSignal;
    
    [reduceZipWithSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator zip reduce: %@", x);
    }];
    
    RACSignal *reduceCombineLatestSignal = [RACSignal combineLatest:@[self.textFieldOne.rac_textSignal, self.textFieldTwo.rac_textSignal] reduce:^id (NSString *textOne, NSString *textTwo){
        return [NSString stringWithFormat:@"combine %@ %@", textOne, textTwo];
    }];
    
    [reduceCombineLatestSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator combineLatest reduce: %@", x);
    }];
    
    RAC(self.labelTwo, text) = reduceCombineLatestSignal;
   

}


@end
