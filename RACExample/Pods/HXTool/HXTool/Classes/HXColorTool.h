//
//  HXTool.h
//  Pods
//
//  Created by 海啸 on 2017/2/27.
//
//
#import <UIKit/UIKit.h>
@interface UIColor(HXTool)
+ (UIColor *)hx_colorWithRGBString:(NSString *)string;
+ (UIColor *)hx_colorWithRGBNumber:(NSUInteger )red green:(NSUInteger )green blue:(NSUInteger )blue;
+ (UIColor *)hx_colorWithRGBNumber:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;

+ (UIColor *)hx_randomColor;
@end
