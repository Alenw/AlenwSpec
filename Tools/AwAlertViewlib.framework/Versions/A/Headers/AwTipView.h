//
//  AwTipView.h
//  AwAlertViewTest
//
//  Created by yelin on 2017/7/11.
//  Copyright © 2017年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AwDebug 1
typedef void (^AwTipViewCompletionBlock)();

NS_ASSUME_NONNULL_BEGIN
/**
 *  这是一个绘制View背景色的方法
 *
 *  @param context     context
 *  @param rect        绘制的rect
 *  @param orientation 绘制三角形方向 orientation 0-->上 1-->下 2-->左 3-->右
 *  @param offset      三角形偏移量
 *  @param margin      三角形高度 一般使用15;
 *  @param color       绘制的颜色
 *  @param corner      绘制的圆角大小，一般是5;
 *  @param special     是否绘制带三角形指向
 */
extern void addBackgroundTipColor(CGContextRef context, CGRect rect,int orientation,float offset,float margin,UIColor *color,float corner,BOOL special);
//纯色填充颜色
extern void addRoundedRectToPath(CGContextRef context, CGRect rect,float ovalWidth,float ovalHeight);
//从中心点渐变填充颜色
extern void drawColorInCenter(CGContextRef context,CGFloat *color,CGPoint center, CGFloat radius);
NS_ASSUME_NONNULL_END

/** AwTipView 显示样式 */
typedef enum {
    AwTipViewStyleNone=0,//不显示图片
    AwTipViewStyleIndicatorMid,//显示进度指示器到中间
    AwTipViewStyleIndicatorLeft,//显示进度指示器到左边
    AwTipViewStyleDeterminate,
    AwTipViewStyleAnnularDeterminate,
    AwTipViewStyleDeterminateHorizontalBar,
}AwTipViewShowStyle;

@class AwBgView;
@interface AwTipView : UIView
/**
 *  类方法，显示message到指定View 的height－120的位置,默认显示1.5秒
 *  可以使用posY字段去修改这个位置,showTime 去改变显示时间
 *  @param message 将要显示到message
 *  @param view    View
 */
+(nullable AwTipView *)showToast:(nullable NSString *)message toView:(nullable UIView *)view;
/**
 *  类方法，显示message到指定View,不会自动消失,必须调用 hideForView:Animated:方法
 *  可以运用在HTTP加载时，加载成功手动隐藏
 *  @param message 将要显示到message
 *  @param view    View
 */
+(nullable AwTipView *)showMessage:(nullable NSString *)message toView:(nullable UIView *)view;
/**
 *  类方法,显示带图片的AwTipView 会自动隐藏，显示时间随success文字长度而改变(1个字符0.2s)
 *  可以使用showtime字段修改显示时长
 *  @param success success 信息
 *  @param view    View
 */
+(nullable AwTipView *)showSuccess:(nullable NSString *)success toView:(nullable UIView *)view;
/**
 *  类方法,显示带图片的AwTipView 会自动隐藏，显示时间随success文字长度而改变(1个字符0.2s)
 *  可以使用showtime字段修改显示时长
 *  @param error error 信息
 *  @param view    View
 */
+(nullable AwTipView *)showError:(nullable NSString *)error toView:(nullable UIView *)view;
/**
 *  显示icon，message到AwTipView中 会自动隐藏，显示时间随message文字长度而改变(1个字符0.2s)
 *  可以使用showtime字段修改显示时长
 *  @param iconName iconName，例如：AwAlertViewlib.bundle/success
 *  @param message  message
 *  @param view     view
 *
 *  @return AwTipView
 */
+(nullable AwTipView *)showIcon:(nullable NSString *)iconName message:(nullable NSString *)message toView:(nullable UIView *)view;

/**
 *  类方法，在View中移除AwTipView
 *
 *  @param view     view
 *  @param animated 是否动画
 */
+(void)hideForView:(nullable UIView *)view Animated:(BOOL)animated;

/**
 *  初始化方法
 */
- (nullable instancetype)initWithTipStyle:(AwTipViewShowStyle)style inView:(nullable UIView *)view title:(nullable NSString *)title message:(nullable NSString *)message icon:(nullable NSString *)iconName offset:(CGPoint)offset;

/*!
 * 仅对除进度指示器之外的style有效,如:AwTipViewStyleNone,AwTipViewStyleIndicatorMid,AwTipViewStyleIndicatorLeft
 @property      showTime
 @abstract      展示的时间，可设置
 */
@property (nonatomic, assign) CGFloat showTime;

/** 显示的位置 */
@property (nonatomic, assign) CGPoint offset;
/** 显示的style */
@property (nonatomic, assign) AwTipViewShowStyle style;
/*!
 @property      dimBackground
 @abstract      是否显示背景渐变色
 */
@property (nonatomic, assign) BOOL dimBackground;

/** 默认背景色是0.8 black ,0.8white 0.8alph */
@property (nonatomic, strong,nullable) AwBgView *contentView;

/**
 * The progress of the progress indicator, from 0.0 to 1.0. Defaults to 0.0.
 */
@property (assign, nonatomic) float progress;

/*!
 @method        show
 @abstract      弹出
 */
- (void)showAnimated:(BOOL)animated;

/*!
 @param animated 消失时是否使用动画
 */
- (void)hideAnimated:(BOOL)animated;
/**
 *  延迟隐藏AwTipView
 *
 *  @param animated 是否动画
 *  @param delay    延迟时间
 */
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

/**
 *  在当前view中查找是否存在AwTipView
 *
 *  @param view AwTipView显示的view
 *
 *  @return AwTipView or nil
 */
+ (nullable AwTipView *)HUDForView:(nonnull UIView *)view ;

/**
 *  默认执行完block中的内容会移除AwTipView
 *
 *  @param animated   是否启用动画
 *  @param block      显示AwTipView时候执行的block
 *  @param completion 完成时候执行的block
 */
- (void)showAnimated:(BOOL)animated whileExecutingBlock:(nullable dispatch_block_t)block completionBlock:(nullable void (^)())completion ;
@end

/*
 * 带方向角标的背景View，用于AwTipView
 */
@interface AwBgView : UIView
/** 方向 */
@property (nonatomic, assign) int orientation;
/** 偏移量 */
@property (nonatomic, assign) float offset;
/** 三角形H 高度 */
@property (nonatomic, assign) float margin;
/** 0直角，一般5左右 */
@property (nonatomic, assign) float corner;
/** 标识是否带三角形指向 */
@property (nonatomic, assign) BOOL special;
/** 背景色 */
@property (nonatomic, copy,nullable) UIColor *color;

@end

@interface AwTipView (Deprecated)

/*!
 @method        initWithView:message:posY:
 @abstract      初始化方法
 @param         view  所在的view
 @param         message  展示内容
 @param         posY  离superView顶部的距离
 @result        AwTipView的对象
 */
- (nullable instancetype)initWithView:(nullable UIView *)view message:(nullable NSString *)message posY:(CGFloat)posY __attribute__((deprecated("Use offset attribute.")));

- (nullable instancetype)initWithView:(nullable UIView *)view title:(nullable NSString *)title message:(nullable NSString *)message posY:(CGFloat)posY __attribute__((deprecated("Use offset attribute.")));

- (nullable instancetype)initWithTipStyle:(AwTipViewShowStyle)style inView:(nullable UIView *)view title:(nullable NSString *)title message:(nullable NSString *)message posY:(CGFloat)posY __attribute__((deprecated("Use offset attribute.")));

- (nullable instancetype)initWithTipStyle:(AwTipViewShowStyle)style inView:(nullable UIView *)view icon:(nullable NSString *)iconName message:(nullable NSString *)message posY:(CGFloat)posY __attribute__((deprecated("Use offset attribute.")));
@end
