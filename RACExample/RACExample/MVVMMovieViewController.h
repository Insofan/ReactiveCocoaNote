//
//  MVVMMovieViewController.h
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVVMMovieViewController : UIViewController
@property (strong, nonatomic) RACSubject *movieModelSubject;

@end
