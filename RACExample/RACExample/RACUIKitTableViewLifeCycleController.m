//
//  RACUIKitTableViewLifeCycleController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/7.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACUIKitTableViewLifeCycleController.h"
#import "RACUIKitTableViewLifeCycleCell.h"

@interface RACUIKitTableViewLifeCycleController ()

@end

@implementation RACUIKitTableViewLifeCycleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[RACUIKitTableViewLifeCycleCell class] forCellReuseIdentifier:ReuseCell];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen hx_screenHeight] / 10.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    UITableView，再说一下UITableViewCell，RAC给UITableViewCell提供了一个方法：rac_prepareForReuseSignal，它的作用是当Cell即将要被重用时，但是每次重用过程中创建的信号确实无法被disposable,告诉Cell。想象Cell上有多个button，Cell在初始化时给每个button都addTarget:action:forControlEvents，被重用时需要先移除这些target，下面这段代码就可以很方便地解决这个问题：
     
     */
    
    RACUIKitTableViewLifeCycleCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCell];
    
    cell = [[RACUIKitTableViewLifeCycleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell buttonTitle:@"RAC Life Cycle"];

    @weakify(self);
    [[[cell.buttonOne rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    return cell;
}

@end
