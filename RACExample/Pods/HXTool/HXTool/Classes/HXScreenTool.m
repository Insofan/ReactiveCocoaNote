//
//  HXScreenTool.m
//  HXTool
//
//  Created by 海啸 on 2017/3/20.
//  Copyright © 2017年 Insofan. All rights reserved.
//

#import "HXScreenTool.h"

@implementation UIScreen(HXTool)
+ (CGFloat )hx_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat )hx_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGRect )hx_screenBounds {
    return [[UIScreen mainScreen] bounds];
}

+ (CGFloat )hx_scale {
    return [UIScreen mainScreen].scale;
}



@end
