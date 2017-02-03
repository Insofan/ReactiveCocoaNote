//
//  LoginViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/3.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UIButton *loginButton;
@end

@implementation LoginViewController
#pragma mark: UI
- (void)setupUI  {
    CGFloat height = 20;
    UILabel *userLabel = ({
        userLabel = [UILabel new];
        [self.view addSubview:userLabel];
        userLabel.text      = @"Username";
        userLabel.textColor = [UIColor blackColor];
        userLabel;
    });
    
    self.usernameTextField = ({
        _usernameTextField = [UITextField new];
        [self.view addSubview:_usernameTextField];
        _usernameTextField.backgroundColor = [UIColor whiteColor];
        _usernameTextField;
    });
    
    self.usernameLabel = ({
        _usernameLabel = [UILabel new];
        [self.view addSubview:_usernameLabel];
        _usernameLabel.text = @"At least five characters";
        _usernameLabel.textColor = [UIColor redColor];
        _usernameLabel;
    });
    
    UILabel *passLabel = ({
        passLabel = [UILabel new];
        [self.view addSubview:passLabel];
        passLabel.text      = @"Password";
        passLabel.textColor = [UIColor blackColor];
        passLabel;
    });
    
    self.passwordTextField = ({
        _passwordTextField = [UITextField new];
        [self.view addSubview:_passwordTextField];
        _passwordTextField.backgroundColor = [UIColor  lightGrayColor];
        _passwordTextField;
    });
    
    self.passwordLabel = ({
        _passwordLabel = [UILabel new];
        [self.view addSubview:_passwordLabel];
        _passwordLabel.text = @"At least five characters";
        _passwordLabel.textColor = [UIColor redColor];
        _passwordLabel;
    });
    
    self.loginButton = ({
        _loginButton = [UIButton new];
        [self.view addSubview:_loginButton];
        _loginButton.backgroundColor = [UIColor greenColor];
        [_loginButton setTitle:@"Enter Something" forState:UIControlStateNormal];
        _loginButton.titleLabel.textColor = [UIColor blackColor];
        [_loginButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        _loginButton;
    });
    
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.left.mas_equalTo(userLabel);
        make.top.mas_equalTo(userLabel.mas_bottom).offset(height);
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.mas_equalTo(userLabel);
        make.top.mas_equalTo(self.usernameTextField.mas_bottom).offset(height);
    }];
    
    [passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.self.usernameLabel.mas_bottom).offset(height);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.left.mas_equalTo(userLabel);
        make.top.mas_equalTo(passLabel.mas_bottom).offset(height);
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.left.mas_equalTo(userLabel);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(height);
    }];
   
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).offset(height);
    }];
}

#pragma mark: RAC
- (void)initialRAC {
    @weakify(self)
    //1.map 对每个信号做同样操作: 宏 返回bool值
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString* value) {
        return @([self isValid:value]);
    }];
    
    //2.bool convert nsnumber 根据bool值操作
    //3.subscribe
   
    [[validUsernameSignal map:^id(NSNumber *usernameValid) {
        @strongify(self);
        self.usernameLabel.hidden      = [usernameValid boolValue];
        
        self.passwordTextField.enabled = [usernameValid boolValue];
        
        UIColor *color = [usernameValid boolValue] ? [UIColor whiteColor] : [UIColor lightGrayColor];
        self.passwordTextField.backgroundColor = color;
        
        return [usernameValid boolValue] ? [UIColor yellowColor] : [UIColor whiteColor] ;
    }]  subscribeNext:^(UIColor *color) {
        //@strongify(self)
        //self.usernameTextField.backgroundColor = color;
    }];
    
    //1.创建信号
    RACSignal *validPassword = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
        return @([self isValid:text]);
    }];
    
    //2.订阅信号
    
    [validPassword subscribeNext:^(NSNumber *passwordValid) {
        @strongify(self);
        if ([passwordValid boolValue] ==  true) {
            self.passwordLabel.hidden = true;
            self.loginButton.enabled = true;
            [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        }else if ([passwordValid boolValue] == false) {
            self.loginButton.enabled = false;
            self.passwordLabel.hidden = false;
            [self.loginButton setTitle:@"Enter Something" forState:UIControlStateNormal];
        }
    }];
    
}

- (BOOL)isValid:(NSString *)text {
   NSUInteger minimalLength = 5;
    return text.length > minimalLength;
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:true];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initialRAC];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
}

@end
