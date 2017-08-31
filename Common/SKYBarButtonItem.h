//
//  SKYBarButtonItem.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SKYNavItemStyleBack,//直接图片返回
    SKYNavItemStyleDone,//文字返回
    SKYNavItemStyleTitleBack//图片加文字返回
}SKYNavItemStyle;

@interface SKYBarButtonItem : UIBarButtonItem
/**
 *  类方法创建 UIBarButtonItem,有三种风格
 *
 *  @param title      title
 *  @param style      风格标识item样式
 *  @param target     target
 *  @param action     action
 *  @param image      default image
 *  @param heighImage heighlight image
 *
 *  @return UIBarButtonItem
 */
+(instancetype)initWithItemTitle:(NSString *)title Style:(SKYNavItemStyle)style target:(id)target action:(SEL)action image:(NSString *)image heighImage:(NSString *)heighImage;
/**
 *  类方法创建 UIBarButtonItem,有color字段标识title color
 *
 *  @param title      title
 *  @param color      title color
 *  @param target     target
 *  @param action     action
 *  @param image      image
 *  @param heighImage heighImage
 *
 *  @return UIBarButtonItem
 */
+(instancetype)initWithItemTitle:(NSString *)title withItemTintColor:(UIColor *)color target:(id)target action:(SEL)action backImage:(NSString *)image heighImage:(NSString *)heighImage;
/**
 *  创建自定义样式的 UIBarButtonItem
 *
 *  @param customview 自定义view
 *  @param target     target
 *  @param action     action
 */
+ (instancetype)initWithCustomView:(UIView *)customview target:(id)target action:(SEL)action;

+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage __attribute__((deprecated("Use initWithItemTitle:Syle:target:action:image:heighImage")));
@end
