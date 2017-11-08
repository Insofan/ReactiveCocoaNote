//
//  MainTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/2.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "MainTableViewController.h"
#import "RACBaseTableViewController.h"
#import "AddNumberViewController.h"
#import "LoginViewController.h"
#import "FirstViewController.h"
#import "SearchTableViewController.h"
#import "FmdbRacViewController.h"
#import "MVVMMovieViewController.h"

@interface MainTableViewController ()
@property (strong, nonatomic) NSArray *vcArray;
@end

@implementation MainTableViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
       
        _vcArray = @[
                     @{@"key":@"1 RAC 基础知识", @"value":[RACBaseTableViewController class]},
                     @{@"key":@"2 加法计数器", @"value":[AddNumberViewController class]},
                     @{@"key":@"3 登录界面", @"value":[LoginViewController class]},
                     @{@"key":@"4 Callback", @"value":[FirstViewController class]},
                     @{@"key":@"5 搜索界面", @"value":[SearchTableViewController class]},
                     @{@"key":@"6 FMDB应用", @"value":[FmdbRacViewController class]},
                     @{@"key":@"7 MVVM应用一", @"value":[MVVMMovieViewController class]}
                        ];
        
    }
    return _vcArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCell];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor randomColor];
    self.navigationItem.title = @"RAC Example";

}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen screenHeight] / 10.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell];
    cell.textLabel.text = self.vcArray[indexPath.row][@"key"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [tableView deselectRowAtIndexPath:indexPath animated:true];

    UIViewController *vcArray = [[self.vcArray[indexPath.row][@"value"] alloc] init];
    vcArray.title = self.vcArray[indexPath.row][@"key"];
    [self.navigationController pushViewController:vcArray animated:true];
}
@end
