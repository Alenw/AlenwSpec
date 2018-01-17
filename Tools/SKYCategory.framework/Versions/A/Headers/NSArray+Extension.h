//
//  NSArray+Extension.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
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


/**
 parse array
 
 @param index    the index of the array
 @param name     the class name of the object in array
 @return         a object
 */
- (id)parseObjectAtIndex:(NSInteger)index className:(NSString *)name;


/**
 parse like tableview datasource
 
 @param section  section data array
 @param row      row data array
 @param name     the class name of the object in array
 @return         a object
 */
- (id)parseTableSection:(NSInteger)section row:(NSInteger)row className:(NSString *)name;

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
