//
//  UIView+ViewAction.h
//  ViewText
//
//  Created by yelin on 16/7/27.
//  Copyright © 2016年 Alenw. All rights reserved.
//  16/11/30 modify

#import <UIKit/UIKit.h>

@interface UIView (ViewAction)

/** 设置点击事件 */
- (void)setTapActionWithBlock:(nullable void (^)(void))block;

/** 只作用于点击,长按事件 */
- (void)addTarget:(nullable id)target action:(nonnull SEL)action;

/** view点击的间隔时间 */
@property (nonatomic, assign) NSTimeInterval clickDurationTime;

/** view的状态-->类似button 用于判断是否选中 */
@property (nonatomic, assign) BOOL selected;

/** view选中的颜色,default white 0.9 */
@property (nonatomic, copy,nullable) UIColor *selectedColor;

/** default 左右间隔0 |-0-[line]-0| */
@property (nonatomic, assign) float linePadding;

/** 下划线颜色 */
@property (nonatomic, copy,nullable) UIColor *lineColor;

/**
 *  view点击的颜色,default white 0.9
 *  @warning 当selectedColor 设置时,clickColor的值会被覆盖
 */
@property (nonatomic, copy,nullable) UIColor *clickColor ;

/** 原始背景色 */
@property (nonatomic, copy,readonly,nullable) UIColor *originColor;

#pragma mark - 下面两个方法不建议主动调用

/** target 执行 action */
- (void)sendAction:(nullable SEL)action to:(nullable id)target;
/** 保存监听self的target */
@property (nonatomic, strong,nullable) NSMutableDictionary *allTargets;
@end
