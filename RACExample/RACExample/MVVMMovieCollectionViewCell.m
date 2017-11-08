//
//  MVVMMovieCollectionViewCell.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "MVVMMovieCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MVVMMovieCollectionViewCell()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *movieTitleLabel;
@end


@implementation MVVMMovieCollectionViewCell


- (void)setupUI {
    CGFloat cellWidth = self.frame.size.width;
    //CGFloat cellHeight = self.frame.size.height;

    self.imageView = ({
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        _imageView.backgroundColor = [UIColor randomColor];
        
        //_imageView.contentMode = UIViewContentModeScaleToFill;
        
        _imageView;
    });
    
    self.movieTitleLabel = ({
        _movieTitleLabel = [UILabel new];
        [self addSubview:_movieTitleLabel];
        _movieTitleLabel.backgroundColor = [UIColor randomColor];
        _movieTitleLabel.textAlignment = NSTextAlignmentCenter;
        _movieTitleLabel;
        
    });
    
    
    [self.movieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(cellWidth, 50));
        make.left.bottom.mas_equalTo(self);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-50);
    }];
    

}

- (void)initWithModel:(MVVMMovieModel *)model {
    self.movieTitleLabel.text = model.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.images[@"large"]?:nil]];
    
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
