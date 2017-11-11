//
//  FmbdRacEditViewController.m
//  HXDemos
//
//  Created by 海啸 on 2017/11/4.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "FmdbRacEditViewController.h"

@interface FmdbRacEditViewController ()

@property (strong, readwrite, nonatomic ) UITextView *textView;
@property (strong, readwrite, nonatomic ) UIButton   *button;

@end

@implementation FmdbRacEditViewController

#pragma mark UI

#pragma mark Database

- (void)setDatabase {
    
    //2.尝试打开数据库，如果不存在创建并打开
    if (![_database open]) {
        NSLog(@"第二页数据库打开失败");
    } else {
        NSLog(@"第二页数据库打开成功");
        
        NSString *selectString = @"SELECT * FROM rac_test1 WHERE id = ?";
        FMResultSet *result = [self.database executeQuery:selectString, @(self.itemId)];
        if ([result next]) {
            
            //查询列的String
            NSString * item = [result stringForColumn:@"item"];
            NSLog(@"第二页的数据 id = %ld, item = %@", self.itemId, item);
            
            NSString *text = [[NSString alloc] initWithFormat:@"%ld %@", self.itemId, item];
            
            self.textView.text = text;
        }
    }
}

#pragma mark Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [self setDatabase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor hx_randomColor];
    [self setupUI];
    [self racBlock];

}

- (void)setupUI {
    self.textView = ({
        _textView = [UITextView new];
        [self.view addSubview:_textView];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView;
    });
    
    self.button = ({
         _button = [UIButton hx_buttonWithTitle:@"修改完成" fontSize:14 normalColor:[UIColor blueColor] selectedColor:[UIColor redColor]];
        _button.backgroundColor = [UIColor whiteColor];

        [self.view addSubview:_button];
        _button;
    });
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo([UIScreen hx_screenWidth]/2);
        make.center.mas_equalTo(self.view);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 50));
        make.centerX.mas_equalTo(self.textView);
        make.bottom.mas_equalTo(self.textView.mas_top).offset(-20);
    }];
}

- (void)racBlock {
    @weakify(self);
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        @strongify(self);
        NSString *updateString=@" UPDATE rac_test1 SET item = ? WHERE id = ?";
        //剔除了前两位
        NSString *subString = [self.textView.text substringFromIndex:2];
        [self.database executeUpdate:updateString , subString, @(self.itemId)];
        
        NSLog(@"Rac退出时的 text %@", subString);
        
        //pop后要在willAppear里面reloadData
        [self.navigationController popViewControllerAnimated:true];
        
        
    }];
        
    ;
}

@end
