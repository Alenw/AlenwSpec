//
//  NSDictionary+Extension.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
/**
 is valid NSDictionary
 
 @return    yes or no
 */
- (BOOL)isValueDict;

/**
 parse NSDictionary in NSDictionary
 
 @param key  the key of the value
 @return     the NSDictionary value
 */
- (NSDictionary *)parseDictKey:(NSString *)key;

/**
 parse NSDictionary in NSDictionary
 
 @param key  the key of the value
 @return     the NSDictionary value, possible is nil
 */
- (NSArray *)parseArrayKey:(NSString *)key;

/**
 parse NSString in NSDictionary
 
 @param key  the key of the value
 @return     the NSDictionary value, possible is nil
 */
- (NSString *)parseStringKey:(NSString *)key;

/**
 parse any object in NSDictionary
 
 @param key  the key of the value
 @return     the value, possible is nil
 */
- (id)parseObjectKey:(NSString *)key;

@end

@interface NSMutableDictionary (Extension)

@end
