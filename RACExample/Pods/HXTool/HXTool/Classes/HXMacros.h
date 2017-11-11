//
//  HXMacros.h
//  HXTool
//
//  Created by 海啸 on 2017/11/5.
//

#ifndef HXMacros_h
#define HXMacros_h

// App Frame Height&Width
#define AppFrameHeight        [[UIScreen mainScreen] applicationFrame].size.height
#define AppFrameWidth         [[UIScreen mainScreen] applicationFrame].size.width


// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 是否IOS7
#define IsIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define IsIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
//
#define IsIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)

//App版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



//obj范型，计算obj类型

#if __has_feature(objc_generics)
#   define GENERICS(class, ...)      class<__VA_ARGS__>
#   define GENERICS_TYPE(type)       type
#else
#   define GENERICS(class, ...)      class
#   define GENERICS_TYPE(type)       id
#endif

#endif /* HXMacros_h */
