//
//  HXNSDictionary.h
//  HXTool
//
//  Created by 海啸 on 2017/11/10.
//

#import <Foundation/Foundation.h>
#import "HXMacros.h"

@interface GENERICS(NSDictionary, KeyType, ObjectType) (HXTool)
/**
 enumerateObjects
 枚举array
 @param block ObjectType
 */
- (void)hx_each:(void (^)(KeyType key, ObjectType obj))block;
@end
