//
// Created by Insomnia on 2018/3/28.
// Copyright (c) 2018 海啸. All rights reserved.
//

#import "CircleCountdownViewController.h"
#import "CircleView.h"

@interface CircleCountdownViewController ()
@property (nonatomic, strong) CircleView *circleView;
@end

@implementation CircleCountdownViewController
/* 用到RACScheduler知识,和贝塞尔曲线*/
- (void)viewDidLoad {
    self.circleView = [[CircleView alloc] initWithSeconds:10];
    [self.view addSubview:self.circleView];
    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.mas_equalTo(self.view);
    }];
}

@end
