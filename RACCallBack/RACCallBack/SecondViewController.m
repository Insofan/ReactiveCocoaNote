//
//  SecondViewController.m
//  RACCallBack
//
//  Created by 海啸 on 2017/1/31.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>
@interface SecondViewController ()
@property (strong, nonatomic) UIButton    * button;
@property (strong, nonatomic) UITextField *textField;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    [self setupUI];
}

- (void)setupUI {
    self.button = ({
        _button = [UIButton new];
        [self.view addSubview:_button];
        _button.backgroundColor = [UIColor greenColor];
        [_button setTitle:@"Pop" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        _button;
    });
    self.textField = ({
        _textField = [UITextField new];
        [self.view addSubview:_textField];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField;
    });
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.button);
        make.bottom.mas_equalTo(self.button.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
}

- (void)buttonAction {
    [self.subject sendNext:self.textField.text];
    [self.navigationController popViewControllerAnimated:true];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
