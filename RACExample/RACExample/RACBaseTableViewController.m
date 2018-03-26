//
//  RACBaseTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/5.
//  Copyright © 2017年 海啸. All rights reserved.
//


#import "RACBaseTableViewController.h"
#import "RACSignalViewController.h"
#import "RACSubjectViewController.h"
#import "RACOperatorTableViewController.h"
#import "RACSequenceViewController.h"
#import "RACMacroTableViewController.h"
#import "RACUIKitTableViewController.h"


@interface RACBaseTableViewController ()
@property (strong, nonatomic) NSArray *vcArray;

@end

@implementation RACBaseTableViewController
#pragma mark Variables

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key":@"1 RACSignal", @"value":[RACSignalViewController class]},
                     @{@"key":@"2 RACSubject", @"value":[RACSubjectViewController class]},
                     @{@"key":@"3 RACOperator", @"value":[RACOperatorTableViewController class]},
                     @{@"key":@"4 RACSequence", @"value":
                           [RACSequenceViewController class]},
                     @{@"key":@"5 RACMacro", @"value":[RACMacroTableViewController class]},
                     @{@"key":@"6 RACUIKit", @"value":[RACUIKitTableViewController class]},
                     ];
    }
    return _vcArray;
}

#pragma mark Life Cycle
- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.delegate = self;
//    self.tableView.dataSource =
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"baseReuse"];
    
    NSLog(@"rac log :%ld", self.vcArray.count);
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen hx_screenHeight]/10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baseReuse"];

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"baseReuse"];
    cell.textLabel.text = _vcArray[indexPath.row][@"key"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    UIViewController *vc = [[_vcArray[indexPath.row][@"value"] class] new];
    vc.title = self.vcArray[indexPath.row][@"key"];
    
    [self.navigationController pushViewController:vc animated:true];

}

@end
