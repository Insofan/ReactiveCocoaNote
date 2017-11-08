//
//  MVVMMovieBaseModel.h
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVVMMovieBaseModel : NSObject
//返回数量
@property (nonatomic,assign) NSInteger count;
//分页量
@property (nonatomic,assign) NSInteger start;
//数据库总数量
@property (nonatomic,assign) NSInteger total;
//返回数据相关信息
@property (nonatomic,copy)   NSString *title;
@end
