//
//  FirstTableViewController.m
//  RACToDo-OC
//
//  Created by 海啸 on 2017/1/31.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "FirstTableViewController.h"
#import "SecondViewController.h"
@interface FirstTableViewController ()
@property (strong, nonatomic) SecondViewController *secVc;
@end

@implementation FirstTableViewController

#pragma mark: setupUI
- (void)setupUI {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:nil];;
    addButton.rac_command = [[RACCommand alloc] initWithEnabled: nil signalBlock:^RACSignal *(id input) {
        [self.navigationController pushViewController:self.secVc animated:true];
        [self.tableView reloadData];
        return [RACSignal empty];
    }];
    self.navigationItem.rightBarButtonItem = addButton;
    
}

#pragma mark: Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        SecondViewController *secVc = [SecondViewController new];
        self.secVc = secVc;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCell];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
   // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated {
    self.secVc.name = [RACSubject subject];
    [self.secVc.name subscribeNext:^(NSString* name) {
        self.navigationItem.title = name;
          }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ReuseCell];
    [self.secVc.name subscribeNext:^(NSString* name) {
        cell.textLabel.text = name;
    }];
    return cell;
}




@end
