//
//  RACUIKitTableViewLifeCycleCell.h
//  RACExample
//
//  Created by 海啸 on 2017/11/7.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RACUIKitTableViewLifeCycleCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier buttonTitle:(NSString *)buttonTitle ;
@property (strong, nonatomic) NSString *buttonTitle;
@property (strong, nonatomic) UIButton *buttonOne;
@end
