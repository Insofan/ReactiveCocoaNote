//
//  RACOperatorTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACOperatorTableViewController.h"
#import "RACOperatorMapViewController.h"
#import "RACOperatorFlattenMapViewController.h"
#import "RACOperatorConcatViewController.h"
#import "RACOperatorThenViewController.h"
#import "RACOperatorMergeViewController.h"
#import "RACOperatorZipWithViewController.h"
#import "RACOperatorCombineLatestViewController.h"
#import "RACOperatorReduceViewController.h"
#import "RACOperatorFilterViewController.h"
#import "RACOperatorIgnoreViewController.h"

@interface RACOperatorTableViewController ()
@property (strong, nonatomic) NSArray *vcArray;

@end

@implementation RACOperatorTableViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key":@"1 map", @"value":[RACOperatorMapViewController class]},
                     @{@"key":@"2 flatenMap and distinctUntilChanged", @"value":[RACOperatorFlattenMapViewController class]},
                     @{@"key":@"3 concat", @"value":[RACOperatorConcatViewController class]},
                     @{@"key":@"4 then", @"value":[RACOperatorThenViewController class]},
                     @{@"key":@"5 merge", @"value":[RACOperatorMergeViewController class]},
                     @{@"key":@"6 zipWith", @"value":[RACOperatorZipWithViewController class]},
                     @{@"key":@"7 combineLatest", @"value":[RACOperatorCombineLatestViewController class]},
                     @{@"key":@"8 reduce", @"value":[RACOperatorReduceViewController class]},
                     @{@"key":@"9 filter", @"value":[RACOperatorFilterViewController class]},
                     @{@"key":@"10 ignore", @"value":[RACOperatorIgnoreViewController class]},
                     ];
    }
    
    return _vcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseId"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen screenHeight] / 10.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseId"];
    cell.textLabel.text = self.vcArray[indexPath.row][@"key"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UIViewController *vc = [[self.vcArray[indexPath.row][@"value"] class] new];
    vc.title = self.vcArray[indexPath.row][@"key"];
    [self.navigationController pushViewController:vc animated:true];
}

@end
