//
//  UIViewController+AOP.m
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <objc/runtime.h>
#import "SKYBarButtonItem.h"
#import <SKYCategory/CoreArchive.h>

#if (DEVELOPMENT==1)
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
        
        swizzleMethod(class, @selector(viewDidAppear:), @selector(aop_viewDidAppear:));
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
    NSLog(@"viewDidLoad :-------");
    if (self != self.navigationController.viewControllers[0]) {
        NSString *string=[CoreArchive strForKey:@"ThemeColorString"];
        
        UIBarButtonItem *leftItem=[SKYBarButtonItem initWithItemTitle:@"提交" Style:SKYNavItemStyleBack target:self action:@selector(navBackAction) image: [string isEqualToString:@"ffffff"] ? @"nav_back":@"nav_back_white" heighImage:[string isEqualToString:@"ffffff"] ? @"nav_back" :@"nav_back_white"];
        self.navigationItem.leftBarButtonItem=leftItem;
    }
}
-(void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)aop_viewWillAppear:(BOOL)animated{
    [self aop_viewWillAppear:animated];
#if (DEVELOPMENT==1)
    [MobClick beginLogPageView:NSStringFromClass([self class])];
#endif
}
-(void)aop_viewDidAppear:(BOOL)animated{
    [self aop_viewDidAppear:animated];
#warning 填写附加的代码
    
    //    UIView *nav_back = [self.navigationController.navigationBar.subviews objectAtIndex:2];
    //    if ([nav_back isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
    //        nav_back.userInteractionEnabled = YES;
    //        // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    //        // [nav_back addGestureRecognizer:tap];
    //        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //        backButton.frame = CGRectMake(0, 0, 20, 21);
    //        [backButton addTarget:self action:@selector(customNavBackButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    //        [nav_back addSubview:backButton];
    //    }
}

-(void)aop_viewWillDisappear:(BOOL)animated{
    [self aop_viewWillDisappear:animated];
#if (DEVELOPMENT==1)
    [MobClick endLogPageView:NSStringFromClass([self class])];
#endif
}
//-(void)aop_viewDidDisappear:(BOOL)animated{
//    [self aop_viewDidDisappear:animated];
//#warning 填写附加的代码
//}

@end
