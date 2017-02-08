//
//  UserModel.h
//  RACExample
//
//  Created by 海啸 on 2017/2/4.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (copy, nonatomic) NSString *login;
@property (copy, nonatomic) NSString *avatar_url;
@property (copy, nonatomic) NSString *location;

@property (copy, nonatomic) NSString *url;
@end
