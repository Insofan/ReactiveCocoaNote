//
//  MVVMMovieViewModel.h
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVVMMovieViewModel : NSObject

/**
 command 用来处理网络请求
 */
@property (strong, nonatomic, readonly) RACCommand *command;
@end
