//
//  RACOperatorZipWithViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorZipWithViewController.h"

@interface RACOperatorZipWithViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UITextField *textFieldTwo;

@end

@implementation RACOperatorZipWithViewController

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
    
    [self zipWith];
}

- (void)zipWith {
    //zipWith操作符总是接受两个参数，第一个参数是一个Observable或者一个Iterable。
    //其中每一个textFieldOne的字母对应textFieldTwo的一个字母，
    //如第一个输入框先输入ttt，并不会有输出
    //第二个输入框输入r，则只会输出t，r，当输入第二个r的时候，则会输出tt，rr，输入第三个r时会ttt，rrr
    [[[self.textFieldOne.rac_textSignal distinctUntilChanged] zipWith:[self.textFieldTwo.rac_textSignal distinctUntilChanged]] subscribeNext:^(id x) {
        NSLog(@"RACOperator zipWith: %@", x);
    }];

}

@end
