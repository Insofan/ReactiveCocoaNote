//
//  MVVMMovieModel.h
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MVVMMovieModel : NSObject

//电影名
@property (nonatomic,copy) NSString *title;
//剧照
@property (nonatomic,strong) NSDictionary *images;

@end

