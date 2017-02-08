//
//  SearchTableViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/2/3.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "SearchTableViewController.h"
#import <AFNetworking.h>
#import "UserModel.h"
#import <YYModel.h>
@interface SearchTableViewController ()
@property (strong, nonatomic) UIView      *titleView;
@property (strong, nonatomic) UITextField *searchTextField;

@property (strong, nonatomic) NSMutableArray <UserModel*> *dataArray;
@property (strong, nonatomic) UserModel *userModel;

@end

@implementation SearchTableViewController
#pragma mark: UI
- (void)setupUI {
    self.titleView = ({
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(100, 10, ScreenWidth-200, 30)];
        
        _titleView.backgroundColor = [UIColor redColor];
        _titleView;
    });
    
    self.searchTextField = ({
        _searchTextField = [UITextField new];
        [self.titleView addSubview:_searchTextField];
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.placeholder = @"Enter Username";
        _searchTextField;
    });
    
    self.navigationItem.titleView = self.titleView;
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleView.mas_left);
        make.centerY.mas_equalTo(self.titleView.mas_centerY);
        make.width.mas_equalTo(self.titleView.mas_width);
        make.height.mas_equalTo(self.titleView.mas_height);
    }];
}

#pragma mark: Initial RAC
//https://api.github.com/search/users?q= %@ &page= %ld
- (void)initialRAC {
    //绑定背景颜色
    RAC(self.searchTextField, backgroundColor) = [self.searchTextField.rac_textSignal map:^id(NSString *text) {
        return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
    
   //
    @weakify(self)
    RACSignal *backgroundColorSignal = [self.searchTextField.rac_textSignal map:^id(NSString *text) {
        return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
    }];
    
    RACDisposable *disposable = [backgroundColorSignal subscribeNext:^(UIColor *color) {
       @strongify(self)
        self.searchTextField.backgroundColor = color;
    }];
    
    [disposable dispose];
    
    //搜索
    [[[self.searchTextField.rac_textSignal filter:^BOOL(NSString *text) {
        @strongify(self)
        return [self isValidSearchText:text];
    }] throttle:0.5] subscribeNext:^(NSString *text) {
        @strongify(self)
        [self searchUserNameWith:text];
    }];
    
}

- (BOOL)isValidSearchText:(NSString *)text{
    return text.length > 2 ;
}

- (void)searchUserNameWith:(NSString *)name{
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    
    NSString *url = [[NSString  alloc] initWithFormat: @"https://api.github.com/search/users?q=%@&page=1", name];
    NSString *searchString = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", searchString);
   
    [manager GET:searchString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *items = responseObject[@"items"];
        for (NSDictionary *item in items) {
            self.userModel = [UserModel yy_modelWithDictionary:item];
            [self.dataArray addObject:self.userModel];
        }
        NSLog(@"%@", self.dataArray);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"no more data");
    }];
  
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseCell];
        
        self.userModel = [UserModel new];
        self.dataArray = [NSMutableArray new];
    }
    return self;
}


- (void)viewDidLoad {
    [self setupUI];
    [self initialRAC];
    [super viewDidLoad];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCell];
    cell.textLabel.text = self.dataArray[indexPath.row].login;
    return cell;
}

@end
