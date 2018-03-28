//
// Created by Insomnia on 2018/3/28.
// Copyright (c) 2018 海啸. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor hx_randomColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
@end