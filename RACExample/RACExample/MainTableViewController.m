//
//  MainTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/2.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "MainTableViewController.h"
#import "AddNumberViewController.h"
#import "LoginViewController.h"
#import "FirstViewController.h"
#import "SearchTableViewController.h"

@interface MainTableViewController ()
@property (copy, nonatomic) NSArray *vcArray;
@end

@implementation MainTableViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.vcArray = @[@"Add Numbers", @"Simple validation", @"Call Back", @"Search GitHub"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCell];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld %@",indexPath.row+1, self.vcArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        AddNumberViewController *vc = [AddNumberViewController new];
        vc.title = self.vcArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    } else if (indexPath.row == 1) {
        LoginViewController *vc = [LoginViewController new];
        vc.title = self.vcArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    } else if (indexPath.row == 2) {
        FirstViewController *vc = [FirstViewController new];
        vc.title = self.vcArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
    } else if (indexPath.row == 3) {
        SearchTableViewController *vc = [SearchTableViewController new];
        [self.navigationController pushViewController:vc animated:true];
    }
}
@end
