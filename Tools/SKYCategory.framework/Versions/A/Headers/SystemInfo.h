//
//  SystemInfo.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IOS10_OR_LATER  (__IPHONE_OS_VERSION_MAX_ALLOWED >= 100000)
#define IOS9_OR_LATER   (__IPHONE_OS_VERSION_MAX_ALLOWED >= 90000)
#define IOS8_OR_LATER	(__IPHONE_OS_VERSION_MAX_ALLOWED >= 80000)
#define IOS7_OR_LATER	(__IPHONE_OS_VERSION_MAX_ALLOWED >= 70000)

#define IS_IPAD         (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define IS_IPHONE_5     [SNSystemInfo is_iPhone_5];

@interface SystemInfo : NSObject

/*系统版本*/
+ (NSString *)osVersion;

/*硬件版本*/
+ (NSString *)platform;

/*硬件版本名称*/
+ (NSString *)platformString;

/*系统当前时间 格式：yyyy-MM-dd HH:mm:ss*/
+ (NSString *)systemTimeInfo;

/*软件版本*/
+ (NSString *)appVersion;

/*是否是iPhone5*/
+ (BOOL)is_iPhone_5;

/*是否越狱*/
+ (BOOL)isJailBroken;

/*越狱版本*/
+ (NSString *)jailBreaker;

/*本地ip*/
+ (NSString *)localIPAddress;

@end
