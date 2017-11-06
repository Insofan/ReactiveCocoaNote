//
//  RACMacroRACTuplePackViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/6.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACMacroRACTuplePackViewController.h"

@interface RACMacroRACTuplePackViewController ()

@property (strong, nonatomic) UITextField *textFieldOne;
@property (strong, nonatomic) UITextField *textFieldTwo;
@property (strong, nonatomic) UILabel *labelOne;

@end

@implementation RACMacroRACTuplePackViewController
- (void)setupUI {
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    
    [self setupUI];
    [self racTuplePack];
}

- (void)racTuplePack {
    
    RACTuple *tuple = RACTuplePack(@"1", @"2");

    NSLog(@"RACTuplePack: %@", tuple);
    
    RACTupleUnpack(NSString *text1, NSString *text2) = tuple;

    NSLog(@"RACTupleUnpack: %@ %@", text1, text2);
    
    //RACChannelTo并未理解
}

@end
