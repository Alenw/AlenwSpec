//
//  UIView+ViewAction.h
//  ViewText
//
//  Created by yelin on 16/7/27.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewAction)

/*********************以下操作二选一即可************************/
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
/** default 1 view下划线的高度 */
@property (nonatomic, assign) float lineheight;

/** 下划线颜色 */
@property (nonatomic, copy,nullable) UIColor *lineColor;

/**
 *  view点击的颜色,default white 0.9
 *  @warning 当selectedColor || lineColor Not Null时,clickColor的值会被覆盖
 */
@property (nonatomic, copy,nullable) UIColor *clickColor ;


#pragma mark - 下面方法,参数不建议主动调用
/** 原始背景色 */
@property (nonatomic, copy,readonly,nullable) UIColor *originColor;

/** target 执行 action */
- (void)sendAction:(nullable SEL)action to:(nullable id)target;
/** 保存监听self的target */
@property (nonatomic, strong,nullable) NSMutableDictionary *awObjects;
@end
