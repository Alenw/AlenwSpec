//
//  NSObject+AwError.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <Foundation/Foundation.h>

void AwSwizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector);
//默认AwErrorCrash = 1，开启crash拦截功能，如不需要刻意手动关闭
#define AwErrorCrash 0
//static const BOOL AwErrorCrash = 1;
@interface NSObject (AwError)

@end
