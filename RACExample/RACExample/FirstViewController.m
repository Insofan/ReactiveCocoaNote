//
//  FirstViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/3.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()
@property(strong, nonatomic) UILabel *label;
@end

@implementation FirstViewController

#pragma mark: setupUI

- (void)setupUI {
    UIBarButtonItem *rightBarButtonItem = ({
        rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Second" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAction)];
        rightBarButtonItem;
    });
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    self.label = ({
        _label = [UILabel new];
        [self.view addSubview:_label];
        _label.backgroundColor = [UIColor whiteColor];
        _label.textAlignment   = NSTextAlignmentCenter;
        _label.text            = @"Call Back Label";
        [_label setTextColor:[UIColor blackColor]];
        _label;
    });

    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(240, 60));
    }];


}


- (void)barButtonAction {
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:true];
    //2. alloc init subject
    vc.subject = [RACSubject subject];
    //3. subscribeNext 订阅
    [vc.subject subscribeNext:^(NSString *text) {
        self.label.text = text;
    }];

}

- (void)viewDidLoad {
    [self setupUI];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
}

@end
