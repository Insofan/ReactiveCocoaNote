//
//  FmdbRacViewController.m
//  HXDemos
//
//  Created by 海啸 on 2017/9/22.
//  Copyright © 2017年 海啸. All rights reserved.
//
#import "FmdbRacViewController.h"
#import "FmdbRacEditViewController.h"

@interface FmdbRacViewController ()
@property (strong, nonatomic, readwrite) UIBarButtonItem *rightBarButtonItem;

@property (copy, nonatomic  ) NSString   *dbPath;
@property (strong, nonatomic) FMDatabase *database;

@end

@implementation FmdbRacViewController

#pragma mark Lazy var
- (FMDatabase *)database {
    if (!_database) {
        //1.设置database路径
        NSString *dbPath     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0] stringByAppendingPathComponent:@"test.sqlite"];
        _database = [FMDatabase  databaseWithPath:dbPath];
        NSLog(@"数据库路径：%@", dbPath);
    }
    return _database;
}

- (void)setDatabase {
    
    //2.尝试打开数据库，如果不存在创建并打开
    if (![_database open]) {
        NSLog(@"数据库打开失败");
    } else {
        NSLog(@"RAC数据库打开成功");
        NSString *createTableString = @"CREATE TABLE IF NOT EXISTS rac_test1(id   INTEGER PRIMARY KEY, item VARCHAR)";
        BOOL createSucess = [_database executeUpdate:createTableString];
        
        if (createSucess) {
            NSLog(@"RAC建表成功");
        } else {
            NSLog(@"RAC建表失败");
        }
    }
}

#pragma mark TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen hx_screenHeight]/10.0;
}





#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FMResultSet *result = [_database executeQuery:@"SELECT count(item) FROM rac_test1"];
    NSUInteger total = 0;
    if ([result next]) {
        total = [result intForColumnIndex:0];
        //        NSLog(@"查询一共有%lu条记录",(unsigned long)total);
    }
    return total;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentify"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentify"];
    
    FMResultSet *result = [_database executeQuery:@"SELECT * FROM rac_test1 WHERE id = ?", @(indexPath.row+1)];

    while ([result next]) {
        cell.textLabel.text = [result stringForColumn:@"item"];
        NSUInteger number = indexPath.row + 1;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", number];
    }

    
    // Configure the cell...
    
    return cell;
}

//edit cell

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //删除
    NSString *deleteString = @"DELETE FROM rac_test1 WHERE id = ?";
    //更新id
    NSString *resetId = @"UPDATE rac_test1 SET id = id - 1 WHERE id > ?";

    BOOL deleteSucess = [self.database executeUpdate:deleteString, @(indexPath.row + 1)];
    [self.database executeUpdate:resetId, @(indexPath.row + 1)];

    if (deleteSucess) {
        NSLog(@"RAC删除成功");
        [self.tableView reloadData];
    } else {
        NSLog(@"RAC删除失败");
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FmdbRacEditViewController *vc = [FmdbRacEditViewController new];
    //把id传过去
    vc.itemId = indexPath.row + 1;
    vc.database = self.database;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)viewWillAppear:(BOOL)animated {
    //为了修改后reload
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.懒加载数据库
    [self database];
    //2.设置数据库建表
    [self setDatabase];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentify"];
    
    self.rightBarButtonItem = ({
        _rightBarButtonItem = [[UIBarButtonItem alloc] init];
        _rightBarButtonItem.title = @"Add";
        _rightBarButtonItem.style = UIBarButtonItemStylePlain;
        _rightBarButtonItem;
    });
    
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    [self racBlock];
    
}

- (void)racBlock {
    self.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSString *insertString = @"INSERT INTO rac_test1(item) VALUES (?)";
        BOOL insertSucess = [self.database executeUpdate:insertString, @"RAC FMDB测试"];
        if (insertSucess) {
            NSLog(@"RAC插入数据成功");
            [self.tableView reloadData];
        } else {
            NSLog(@"RAC插入数据失败");
        }
        
        return [RACSignal empty];
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
