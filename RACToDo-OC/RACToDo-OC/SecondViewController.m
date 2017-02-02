//
//  SecondViewController.m
//  RACToDo-OC
//
//  Created by 海啸 on 2017/1/31.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstTableViewController.h"
@interface SecondViewController ()
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *saveButton;
@end

@implementation SecondViewController

#pragma mark: setupUI

- (void)setupUI {
    self.textField = ({
        _textField = [UITextField new];
        [self.view addSubview:_textField];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField;
    });
    
    self.saveButton = ({
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_saveButton];
        _saveButton.backgroundColor = [UIColor blueColor];
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        _saveButton;
    });
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(200);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).offset(20);
        make.size.mas_equalTo(self.textField);
        make.left.mas_equalTo(self.textField.mas_left);
    }];
    
}

- (void)initBind {
    [self.textField.rac_textSignal subscribeNext:^(NSString *text) {
        NSLog(@"reactive %@", text);
        [self textField:text];
    }];
    @weakify(self);
    [[_saveButton rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.name sendNext:self.textField.text] ;
        NSLog(@"touch");
    }];
}

- (void)textField:(NSString *)text{
    NSLog(@"%@", text);
}
- (void)viewDidLoad {
    [self setupUI];
    [self initBind];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

@end
