//
//  RACUIKitTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/7.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACUIKitTableViewController.h"
#import "RACUIKitButtonViewController.h"
#import "RACUIKitTableViewLifeCycleController.h"

@interface RACUIKitTableViewController ()

@property (strong, nonatomic) NSArray *vcArray;
@end

@implementation RACUIKitTableViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key": @"1 UIButton UITextField and UIGestureRecognizer", @"value": [RACUIKitButtonViewController class]},
                     @{@"key": @"2 UITableViewCell Life Cycle", @"value": [RACUIKitTableViewLifeCycleController class]},
                     ];
    }
    return _vcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCell];
    
}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen hx_screenHeight] / 10.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCell];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell];
    cell.textLabel.text = _vcArray[indexPath.row][@"key"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UIViewController *vc = [[self.vcArray[indexPath.row][@"value"] class] new];
    vc.title = self.vcArray[indexPath.row][@"key"];
    [self.navigationController pushViewController:vc animated:true];
    
}

@end
