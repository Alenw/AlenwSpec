//
//  AwNavigationController.h
//  AlenW
//
//  Created by soyoung on 16/2/1.
//  Copyright © 2016年 AlenW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AwNavigationController : UINavigationController<UINavigationControllerDelegate>

@property (nonatomic,strong) UIView *backgroundView;
/** 判断是否需要验证登陆 */
- (BOOL)needLogonAuth:(UIViewController *)viewController;

/** 设置导航栏背景色 */
- (void)setNavBarBackgoundWithColor:(UIColor *)color;
/** 初始化根控制器 */
- (id)initWithRootViewController:(UIViewController *)rootViewController hasTopRoundCorner:(BOOL)isTopRound;
/** 检查是否需要验证登陆 */
@property (nonatomic, assign) BOOL isCheckAuth;
@end
