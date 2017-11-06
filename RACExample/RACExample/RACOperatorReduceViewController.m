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
    
    [self.textFieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen screenWidth] / 2.0, [UIScreen screenHeight] / 10.0));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset([UIScreen screenHeight] / 5.0);
    }];
    
    
    [self.textFieldTwo mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [self reduce];
}

- (void)reduce {
    //用于信号发出的内容是元组，把信号发出元组的值聚合成一个值,
    RACSignal *reduceZipWithSignal = [RACSignal zip:@[self.textFieldOne.rac_textSignal, [self.textFieldTwo.rac_textSignal distinctUntilChanged]] reduce:^id (NSString *textOne, NSString *textTwo){
        return [NSString stringWithFormat:@"%@ %@", textOne, textTwo];
    }];
    
    [reduceZipWithSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator zip reduce: %@", x);
    }];
    
    RACSignal *reduceCombineLatestSignal = [RACSignal combineLatest:@[self.textFieldOne.rac_textSignal, self.textFieldTwo.rac_textSignal] reduce:^id (NSString *textOne, NSString *textTwo){
        return [NSString stringWithFormat:@"%@ %@", textOne, textTwo];
    }];
    
    [reduceCombineLatestSignal subscribeNext:^(id x) {
        NSLog(@"RACOperator combineLatest reduce: %@", x);
    }];
   

}


@end
