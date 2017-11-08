//
//  MVVMMovieCollectionViewCell.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "MVVMMovieCollectionViewCell.h"


@implementation MVVMMovieCollectionViewCell


- (void)setupUI {
    CGFloat cellWidth = self.frame.size.width;
    CGFloat cellHeight = self.frame.size.height;

    self.imageView = ({
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        _imageView.backgroundColor = [UIColor randomColor];
        _imageView;
    });
    
    self.moviewTitleLabel = ({
        _moviewTitleLabel = [UILabel new];
        [self addSubview:_moviewTitleLabel];
        _moviewTitleLabel.backgroundColor = [UIColor randomColor];
        _moviewTitleLabel;
        
    });
    
    
    [self.moviewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellWidth, 50));
        make.left.bottom.mas_equalTo(self);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-50);
    }];

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.backgroundColor = [UIColor randomColor];
    }
    return self;
}


@end
