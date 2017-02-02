//
//  AddNumberViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/2.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "AddNumberViewController.h"

@interface AddNumberViewController ()
@property (strong, nonatomic) UITextField *number0TextField;
@property (strong, nonatomic) UITextField *number1TextField;
@property (strong, nonatomic) UITextField *number2TextField;
@property (strong, nonatomic) UILabel     *resultLabel;
@end

@implementation AddNumberViewController

#pragma mark: UI

- (void)setupUI {
    //这种写法不行 没找出来原因
    //[self initTextFields:_number1TextField number:1];
    //[self initTextFields:_number2TextField number:2];
    
    self.number0TextField = ({
        _number0TextField = [UITextField new];
        [self.view addSubview:_number0TextField];
        _number0TextField.backgroundColor = [UIColor whiteColor];
        _number0TextField.placeholder = @"Number 0";
        _number0TextField;
    });
    
    [self.number0TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.number1TextField = ({
        _number1TextField = [UITextField new];
        [self.view addSubview:_number1TextField];
        _number1TextField.backgroundColor = [UIColor whiteColor];
        _number1TextField.placeholder = @"Number 1";
        _number1TextField;
    });
    
    [self.number1TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(200);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.number2TextField = ({
        _number2TextField = [UITextField new];
        [self.view addSubview:_number2TextField];
        _number2TextField.backgroundColor = [UIColor whiteColor];
        _number2TextField.placeholder = @"Number 2";
        _number2TextField;
    });
    
    [self.number2TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(300);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.resultLabel = ({
        _resultLabel = [UILabel new];
        [self.view addSubview:_resultLabel];
        _resultLabel.backgroundColor = [UIColor whiteColor];
        _resultLabel.text = @"Result";
        _resultLabel.textColor = [UIColor blackColor];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel;
    });
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(400);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}


/*
- (void)initTextFields:(UITextField *)textField number:(NSUInteger )number{
    textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = [NSString stringWithFormat:@"Number%ld", number];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset((number + 1) * 100);
    }];
}
*/
#pragma mark: RAC
- (void)initialRac {
    //1创建一个信号
    //2混合最后信号 http://wiki.jikexueyuan.com/project/rx-docs/operators/CombineLatest.html
    //3聚合信号
    //4订阅信号
    [[RACSignal combineLatest:@[self.number0TextField.rac_textSignal, self.number1TextField.rac_textSignal, self.number2TextField.rac_textSignal] reduce:^id(NSString * text0, NSString * text1, NSString *text2){
        return [NSString stringWithFormat:@"%d", [text0 intValue]+ [text1 intValue] + [text2 intValue]];
    }] subscribeNext:^(id x) {
        self.resultLabel.text = x;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any addiional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self setupUI];
   [self initialRac];
}



@end
