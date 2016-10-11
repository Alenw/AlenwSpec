//
//  UIViewController+AOP.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector);
@interface UIViewController (AOP)

@end
