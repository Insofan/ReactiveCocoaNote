//
// Created by Insomnia on 2018/3/28.
// Copyright (c) 2018 海啸. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CircleView : UIView
- (instancetype)initWithSeconds:(NSInteger )seconds;
@property(strong, nonatomic) RACSignal *timerSignal;
@end
