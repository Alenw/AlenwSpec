//
//  UIView+ViewAction.h
//  ViewText
//
//  Created by yelin on 16/7/27.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewAction)

/** 设置点击事件 */
- (void)setTapActionWithBlock:(void (^)(void))block;

/** view点击的间隔时间 */
@property (nonatomic, assign) NSTimeInterval clickDurationTime;

/** view的状态-->类似button 用于判断是否选中 */
@property (nonatomic, assign) BOOL selected;

/** view选中的颜色,default white 0.9 */
@property (nonatomic, copy) UIColor *selectedColor;

/** default 左右间隔0 |-0-[line]-0| */
@property (nonatomic, assign) float linePadding;

/** 下划线颜色 */
@property (nonatomic, copy) UIColor *lineColor;

/**
 *  view点击的颜色,default white 0.9
 *  @warning 当selectedColor 设置时,clickColor的值会被覆盖
 */
@property (nonatomic, copy) UIColor *clickColor ;

/** 原始背景色 */
@property (nonatomic, copy,readonly) UIColor *originColor;
@end
