//
// Created by Insomnia on 2018/3/28.
// Copyright (c) 2018 海啸. All rights reserved.
//

#import "CircleView.h"

@interface CircleView ()
@property(strong, nonatomic) UILabel *countdownLabel;
@property(assign, nonatomic) NSInteger leftSeconds;
@property(assign, nonatomic) float totalSeconds;


@end

@implementation CircleView

- (instancetype)initWithSeconds:(NSInteger )seconds {
    self = [super init];
    if (self) {
        @weakify(self);
        self.backgroundColor = [UIColor whiteColor];
        self.totalSeconds = seconds;
        self.leftSeconds = seconds;
        //为了刷UI的数字移到主线程
        [[RACScheduler mainThreadScheduler] schedule:^{
            @strongify(self);
            [self initUI];
            self.layer.cornerRadius = self.frame.size.height/2;
            self.layer.masksToBounds = true;
        }];
            [self racLogic];
    }
    return self;
}



- (void)initUI {
    self.countdownLabel  = ({
        _countdownLabel = [UILabel new];
        [self addSubview:_countdownLabel];
        _countdownLabel.text            = [NSString stringWithFormat:@"%zd", self.leftSeconds];
        _countdownLabel.textColor       = [UIColor blackColor];
        _countdownLabel.textAlignment   = NSTextAlignmentCenter;
        _countdownLabel.font            = [UIFont systemFontOfSize:30];
        _countdownLabel.backgroundColor = [UIColor clearColor];
        //设置label圆角的
        _countdownLabel.layer.cornerRadius = self.frame.size.height/2;
        _countdownLabel.layer.masksToBounds = true;
        _countdownLabel;
    });

    [self.countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width, self.frame.size.height));
        make.center.mas_equalTo(self);
    }];
}

- (void)racLogic {
    self.timerSignal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] takeUntilBlock:^BOOL(NSDate * _Nullable x) {
        return self.leftSeconds < 1;
    }];
    [self.timerSignal subscribeNext:^(id x) {
        [[RACScheduler mainThreadScheduler] schedule:^{
            self.countdownLabel.text = [NSString stringWithFormat:@"%zd", --self.leftSeconds];
            [self setNeedsDisplay];
        }];
    }];
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();//获取上下文对象  只要是用了 CoreGraPhics  就必须创建他
    CGContextSetLineWidth(context, 5);//显然是设置线宽
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);// 设置颜色
    CGContextAddArc(context, self.frame.size.width/2.0, self.frame.size.height/2.0, self.bounds.size.width/2.0 - 5, 0, ((self.totalSeconds - self.leftSeconds)/self.totalSeconds * M_PI * 2), 0);//这就是画曲线了
    /*
     CGContextAddArc(上下文对象    ,     圆心x,     圆心y,     曲线开始点,    曲线结束点,     半径);
     */
    CGContextStrokePath(context);
}
                        



@end
