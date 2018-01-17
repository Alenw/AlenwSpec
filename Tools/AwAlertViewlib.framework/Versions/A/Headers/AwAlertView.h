//
//  AwAlertView.h
//  AwAlertViewlib
//
//  Created by yelin on 16/5/23.
//  Copyright © 2016年 AlenW. All rights reserved.
//  last updated 2017-11-16

#import <UIKit/UIKit.h>
#import "AwTipView.h"

/** AwAlertView默认4种样式,其他样式请自定义 */
typedef enum {
    AwAlertViewDefault=0,
    AwAlertViewStyle1,
    AwAlertViewStyle2,
    AwAlertViewStyle3
}AwAlertViewStyle;

/** 弹出动画样式 ==> animationStyle */
typedef enum {
    AwAlertViewAniNone=0,//无动画
    AwAlertViewAniMin,//小幅度回弹
    AwAlertViewAniMax,//大幅度回弹
    AwAlertViewAniDown,//从上往下
    AwAlertViewAniUp//从下往上
}AwAlertViewAnimationStyle;
/** 消失动画样式 ==> dismissAnimation */
typedef enum {
    AwDismissNone=0,//无动画
    AwDismissDown,//往小消失
    AwDismissUp,//往上消失
    AwDismissOut//放大消失
}AwDismissAnimation;

@class AwAlertView;
@protocol AwAlertViewDelegate <NSObject>
@optional
/** 按钮点击事件代理方法 */
// before animation and hiding view
- (void)awAlertView:(nonnull AwAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)awAlertView:(nonnull AwAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
@end

/**
 *  禁止使用［AwAlertView alloc］init]形式创建对象
 *  新增NSNotification awAlertViewDismiss 用于移除 AwAlertView,详见Demo b10
 */
@interface AwAlertView : UIView
@property (nonatomic, weak,nullable) id<AwAlertViewDelegate> delegate;

@property (nonatomic, assign) AwAlertViewStyle awStyle;

/** 提供多个动画效果，默认AwAlertViewAniDefault */
@property (nonatomic, assign) AwAlertViewAnimationStyle animationStyle;

/** 提供多个移除动画，默认AwDismissDefault */
@property (nonatomic, assign) AwDismissAnimation dismissAnimation;
/** block,注意:只响应一次 */
@property (nonatomic, copy,nullable) AwTipViewCompletionBlock clickBlock;

@property (nonatomic, copy,nullable) AwTipViewCompletionBlock dismissBlock;

/** 内容View */
@property (nonatomic, strong,nullable) UIView *contentView;
/*!
 是否正在显示
 */
@property (nonatomic, readonly, getter=isVisible) BOOL visible;
/*!
 背景视图，覆盖全屏的，默认nil
 */
@property (nonatomic, strong,nullable) UIView *backgroundView;

/*!
 * 在contentView左上角加showTime时间
 @property      showTime
 @abstract      展示的时间，可设置
 */
@property (nonatomic, assign) unsigned int showTime;
/** 显示位置距离center的偏移量 */
@property (nonatomic, assign) CGPoint offset;

/*!
 *  @property           dimBackground
 *  @abstract           是否显示背景渐变色,默认显示
 */
@property (nonatomic, assign) BOOL hideDimBackground;
/** 是否启用背景事件，默认不启用 */
@property (nonatomic, assign) BOOL isUseHidden;

/** 是否需要放弃键盘响应,这个属性与isUserHidden一起使用 */
@property (nonatomic, assign) BOOL needGiveupTouch;
#pragma mark - 不同需求的Show方法

/**
 *  显示AwAlertView
 *
 *  @param animated 是否加载动画
 */
- (void)showAnimated:(BOOL)animated;
/**
 *  移除AwAlertView
 *  @param animated     是否加载动画
 */
- (void)dismissAnimated:(BOOL)animated;

/**
 *  延迟隐藏AwAlertView
 *
 *  @param animated     是否动画
 *  @param delay        延迟时间
 */
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

/**
 * 自定义View初始化方法
 *
 *  @param contentView 自定义View
 */
- (nullable instancetype)initWithContentView:(nonnull UIView *)contentView;
/**
 *  动态更新自定义View的Y值
 *
 *  @param positionY     动态调整自定义View的Y值
 *  @param duration      持续时间,动画时间,键盘弹起的时间是0.25秒
 */
- (void)awAlertViewAnimationWithPositionYValues:(CGFloat)positionY andDuration:(NSTimeInterval)duration;

/*****************************下面属性作用域**********************************/

/** 标题 */
@property (nonatomic, copy,nullable) NSString *title;
/** 标题字体颜色 */
@property (nonatomic, copy,nullable) UIColor *titleTextColor;

/** 信息 */
@property (nonatomic, copy,nullable) NSString *message;
/** 信息字体颜色 */
@property (nonatomic, copy,nullable) UIColor *messageTextColor;
/** 取消按钮 */
@property (nonatomic, strong,nullable) UIButton *cancelBtn;
/** 确定按钮 */
@property (nonatomic, strong,nullable) UIButton *otherBtn;
/** 关闭按钮 */
@property (nonatomic, strong,nullable) UIButton *closeBtn;

/**
 *  标准样式AwAlertView
 *  @return AwAlertView
 */
-(nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate customView:(nullable UIView *)customview cancelTitle:(nullable NSString *)cancelText otherTitle:(nullable NSString *)otherText;
/**
 *  不同样式的AwAlertView初始化方法
 */
-(nullable instancetype)initWithStyle:(AwAlertViewStyle)awStyle title:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelTitle:(nullable NSString *)cancelText otherTitle:(nullable NSString *)otherText;
/**
 *  不同样式的AwAlertView初始化方法
 *
 *  @param awStyle    AwAlertView风格
 *  @param title      标题
 *  @param message    信息
 *  @param delegate   代理
 *  @param customview 自定义视图，可以是UIView,UITableView,...
 *  @param cancelText 取消按钮title
 *  @param otherText  其他按钮title
 *
 *  @return AwAlertView
 */
-(nullable instancetype)initWithStyle:(AwAlertViewStyle)awStyle title:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate customView:(nullable UIView *)customview cancelTitle:(nullable NSString *)cancelText otherTitle:(nullable NSString *)otherText;

/***************************************************************************/
@end

@interface AwAlertView (Deprecated)

/** 按钮颜色 */
@property (nonatomic, strong,nullable) UIColor *cancelTextColor __attribute__((deprecated("Use cancelBtn to set attributes.")));
/** 按钮图标 */
@property (nonatomic, strong,nullable) UIImage *cancelImage __attribute__((deprecated("Use cancelBtn to set attributes.")));
/** 按钮颜色 */
@property (nonatomic, strong,nullable) UIColor *otherTextColor __attribute__((deprecated("Use otherBtn to set attributes.")));
/** 按钮图标 */
@property (nonatomic, strong,nullable) UIImage *otherImage __attribute__((deprecated("Use otherBtn to set attributes.")));

/** 关闭按钮正常图片 */
@property (nonatomic, strong,nullable) UIImage *closeImage __attribute__((deprecated("Use closeBtn to set attributes.")));
/** 关闭按钮高亮图片 */
@property (nonatomic, strong,nullable) UIImage *closeImage_hl __attribute__((deprecated("Use closeBtn to set attributes.")));

/**  指定即将展示的View在父视图中的Y值,view显示位置居中 */
-(void)showAnimated:(BOOL)animated withPositionY:(CGFloat)posY NS_DEPRECATED_IOS(2_0, 7_0, "Use offset attribute.") __TVOS_PROHIBITED;
/** 指定即将展示的View的距离底部的偏移值,view显示位置居中,标记是否选择动画 */
-(void)showAnimated:(BOOL)animated WithBottomYOffset:(CGFloat)offset NS_DEPRECATED_IOS(2_0, 7_0, "Use offset attribute.") __TVOS_PROHIBITED;

/** 指定在某个位置展示 */
-(void)showAnimated:(BOOL)animated inPoint:(CGPoint)point NS_DEPRECATED_IOS(2_0, 7_0, "Use offset attribute.") __TVOS_PROHIBITED;

/**
 *  指定在某个区域显示,Note:如果是自定义View，只支持约束和在layoutSubViews重写的布局，
 *  如果这个方面不是太懂的尽量不用这个方法
 */
-(void)showAnimated:(BOOL)animated inRect:(CGRect)rect NS_DEPRECATED_IOS(2_0, 7_0, "Use offset attribute.") __TVOS_PROHIBITED;
@end
