//
//  ViewController.m
//  RACCallBack
//
//  Created by 海啸 on 2017/1/31.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry.h>
@interface ViewController ()
@property(nonatomic, strong)UIButton * button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)setupUI {
    self.button = ({
        _button = [UIButton new];
        [self.view addSubview:_button];
        _button.backgroundColor = [UIColor greenColor];
        [_button setTitle:@"Push" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        _button;
    });
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
}

- (void)buttonAction {
    SecondViewController *secVc = [[SecondViewController alloc] init];
    secVc.subject = [RACSubject subject];
    [secVc.subject subscribeNext:^(NSString * x) {
        [self.button setTitle:x forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:secVc animated:true];
}

@end
