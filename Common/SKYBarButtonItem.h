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

+(instancetype)initWithSkyTitle:(NSString *)title Style:(SKYNavItemStyle)style target:(id)target action:(SEL)action image:(NSString *)image heighImage:(NSString *)heighImage;

+(instancetype)initWithItemTitle:(NSString *)title withItemTintColor:(UIColor *)color target:(id)target action:(SEL)action backImage:(NSString *)image heighImage:(NSString *)heighImage;
@end
