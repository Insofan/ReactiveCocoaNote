//
//  RACUIKitTableViewLifeCycleCell.m
//  RACExample
//
//  Created by 海啸 on 2017/11/7.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "RACUIKitTableViewLifeCycleCell.h"
@interface RACUIKitTableViewLifeCycleCell()
@property (strong, nonatomic) UILabel *labelOne;
@end

@implementation RACUIKitTableViewLifeCycleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier buttonTitle:(NSString *)buttonTitle {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.buttonTitle = buttonTitle;
    if (self) {

        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.buttonOne = ({
        _buttonOne = [UIButton buttonWithTitle:self.buttonTitle fontSize:15 normalColor:[UIColor blackColor] selectedColor:[UIColor redColor]] ;
        [self addSubview:_buttonOne];
        _buttonOne.backgroundColor = [UIColor redColor];
        _buttonOne.titleLabel.text = self.buttonTitle;
        _buttonOne;
    });
    
    [self.buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150.0, 50.0));
        make.center.mas_equalTo(self);
        //make.top.mas_equalTo(self.mas_top);
    }];
}

@end
