//
//  UIViewController+AOP.m
//  Localization
//
//  Created by soyoung on 16/1/4.
//  Copyright © 2016年 RW. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <objc/runtime.h>
#import "SKYBarButtonItem.h"

#if (DEVELOPMENT==0)
#import <UMMobClick/MobClick.h>
#endif
@implementation UIViewController (AOP)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class=[self class];
        swizzleMethod(class,@selector(viewDidLoad),@selector(aop_viewDidLoad));
#pragma 界面即将显示
        swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
//        swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
#pragma 界面即将消失
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(aop_viewWillDisappear:));
        swizzleMethod(class, @selector(awakeFromNib), @selector(aop_awakeFromNib));
    });
    
   
}
void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector){
    Method originalMethod=class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod=class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod=class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
-(void)aop_awakeFromNib{
    NSLog(@"======viewController==%@,awakeFromNib======",NSStringFromClass([self class]));
}
-(void)aop_viewDidLoad{
    [self aop_viewDidLoad];
    NSLog(@"viewDidLoad :%@",NSStringFromClass([self class]));
    if (self != self.navigationController.viewControllers[0]) {
        UIBarButtonItem *leftItem=[SKYBarButtonItem initWithSkyTitle:@"提交" Style:SKYNavItemStyleBack target:self action:@selector(navBackAction) image:@"nav_back_white" heighImage:@"nav_back_white"];
        self.navigationItem.leftBarButtonItem=leftItem;
    }
}
-(void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)aop_viewWillAppear:(BOOL)animated{
    [self aop_viewWillAppear:animated];
#if (DEVELOPMENT==0)
    [MobClick beginLogPageView:NSStringFromClass([self class])];
#endif
}
//-(void)aop_viewDidAppear:(BOOL)animated{
//    [self aop_viewDidAppear:animated];
//#warning 填写附加的代码
//}

-(void)aop_viewWillDisappear:(BOOL)animated{
    [self aop_viewWillDisappear:animated];
#if (DEVELOPMENT==0)
    [MobClick endLogPageView:NSStringFromClass([self class])];
#endif
}
//-(void)aop_viewDidDisappear:(BOOL)animated{
//    [self aop_viewDidDisappear:animated];
//#warning 填写附加的代码
//}
#ifdef __IPHONE_7_0
//如果需要更换导航状态栏颜色，重写这个方法
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden{
    return NO;
}
#endif
@end
