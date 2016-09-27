//
//  NSArray+SNFoundation.h
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SNFoundation)

/** NSArray安全取值 */
- (id)safeObjectAtIndex:(NSUInteger)index;
/** 深拷贝 */
- (id)deepCopy;
/** 可变拷贝 */
- (id)mutableDeepCopy;
/** 深拷贝 */
- (id)trueDeepCopy;
/** 可变拷贝 */
- (id)trueDeepMutableCopy;

@end

#pragma mark -

@interface NSMutableArray (WeakReferences)
/** 弱引用 */
+ (id)noRetainingArray;
/** 弱引用 */
+ (id)noRetainingArrayWithCapacity:(NSUInteger)capacity;

@end

#pragma mark -

@interface NSMutableDictionary (WeakReferences)
/** 弱引用 */
+ (id)noRetainingDictionary;
/** 弱引用 */
+ (id)noRetainingDictionaryWithCapacity:(NSUInteger)capacity;

@end