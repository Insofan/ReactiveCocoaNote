//
//  RACMacroTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACMacroTableViewController.h"
#import "RACMacroRACViewController.h"
#import "RACMacroRACObserveViewController.h"
#import "RACMacroRACTuplePackViewController.h"

@interface RACMacroTableViewController ()
@property (strong, nonatomic) NSArray *vcArray;
@end

@implementation RACMacroTableViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[
                     @{@"key":@"1 RAC", @"value": [RACMacroRACViewController class]},
                     @{@"key":@"2 RACObserve", @"value": [RACMacroRACObserveViewController class]},
                     @{@"key":@"3 RACTuplePack and RACTupleUnpack", @"value": [RACMacroRACTuplePackViewController class]},
                     ];
    }
    return _vcArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseId"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen screenHeight] / 10.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"macroReuseId"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"macroReuseId"];
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
