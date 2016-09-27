//
//  AwNavigationController.m
//  AlenW
//
//  Created by soyoung on 16/2/1.
//  Copyright © 2016年 AlenW. All rights reserved.
//

#import "AwNavigationController.h"
#import "AwCommonViewController.h"
#import <SKYCategory/SKYCategory.h>

static NSArray *AuthControllers=nil;
@interface AwNavigationController ()
- (BOOL)isLotteryController:(UIViewController *)viewController;
@end

@implementation AwNavigationController


+ (void)initialize
{
    if (self == [AwNavigationController class]) {
        AuthControllers=[[NSArray alloc] init];
#pragma mark 这里添加需要验证登陆的控制器
//        AuthControllers = [[NSArray alloc]  initWithObjects:[ServiceTrackListViewController class]];
        
//        [AwNavigationController setupNavTheme];
    }
}

// 设置导航栏的主题,这里不适应
+(void)setupNavTheme{
    // 设置导航样式
    
    UINavigationBar *navBar = [UINavigationBar appearance
                               ];
    
    [[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
    // 1.设置导航条的背景
    
    // 高度不会拉伸，但是宽度会拉伸
    //  [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.设置栏的字体
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor colorWithRed:1.000 green:0.485 blue:0.568 alpha:1.000];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    [navBar setTitleTextAttributes:att];
    
    // 设置状态栏的样式
    // xcode5以上，创建的项目，默认的话，这个状态栏的样式由控制器决定
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    
    return [self initWithRootViewController:rootViewController hasTopRoundCorner:YES];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController hasTopRoundCorner:(BOOL)isTopRound
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        self.delegate = self;
        
        if ([rootViewController isKindOfClass:[AwCommonViewController class]])
        {
            if (![(AwCommonViewController *)rootViewController hasNav])
            {
                [self.navigationBar setHidden:YES];
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarBackgoundWithColor:[UIColor colorWithHexString:@"26bd7b"]];
}
- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        CGRect frame = [[UIScreen mainScreen] bounds];
        _backgroundView.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        _backgroundView.backgroundColor = [UIColor clearColor];
        //        _backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kNavControllerBackgroundImage]];
    }
    return _backgroundView;
}

#pragma mark -
#pragma mark logon auth

- (BOOL)needLogonAuth:(UIViewController *)viewController{
    BOOL need = NO;
    for (id class in AuthControllers) {
        if ([[viewController class] isSubclassOfClass:class]) {
            need = YES;
            break;
        }
    }
    return need;
}

- (BOOL)isLotteryController:(UIViewController *)viewController{
    BOOL isLottery = NO;
    for (id class in AuthControllers) {
        if ([[viewController class] isSubclassOfClass:class]) {
            isLottery = YES;
            break;
        }
    }
    return isLottery;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
#pragma mark 这里可以设置每个控制器的导航栏样式
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc]init];
    returnButtonItem.title = @"返回";
    viewController.navigationItem.backBarButtonItem = returnButtonItem;
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
          viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        
    }
    if ([self needLogonAuth:viewController]) {
#pragma mark 未配置需要登录的控制器
/*
//        SYAccount *account=[SKYAccountTool account];
//        if (IsStrEmpty(account.flag) || [account.flag isEqualToString:@"0"])
//        {
//            NSLog(@"needLogonAuth \n");
//            SYLoginViewController *loginVC = [[SYLoginViewController alloc] init];
//            loginVC.nextController = viewController;
//            loginVC.nextNavigationController = self;
//            loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//            
//            AwNavigationController *navController = [[AwNavigationController alloc] initWithRootViewController:loginVC];
//            //            TT_RELEASE_SAFELY(loginVC);
//            
//            [self presentViewController:navController animated:YES completion:nil];
//            //            TT_RELEASE_SAFELY(navController);
//            
//            return;
//        }*/
        
        if ([self.viewControllers containsObject:viewController]) {
            //[viewController viewWillAppear:animated];
            return;
        }
    }
    
    //如果在push过程中触发手势滑动返回，会导致导航栏崩溃（从日志中可以看出）。针对这个问题，我们需要在pop过程禁用手势滑动返回功能：
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.enabled = NO;
    //    }
    
    [super pushViewController:viewController animated:animated];
    
    //    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    //    [viewController.view addGestureRecognizer:swipeRight];
    //    [swipeRight release];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated{
    
    [super dismissModalViewControllerAnimated:animated];
    
    NSLog(@"dismissModalViewControllerAnimated \n");
    
}


- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}

- (void)setNavBarBackgoundWithColor:(UIColor *)color
{
    if (IOS7_OR_LATER)
    {
        //translucent=NO,navigationBar的背景色alph＝1.0,translucent=YES,navigationBar的背景色alph＝0.8
        self.navigationBar.translucent=NO;
        self.navigationBar.barTintColor = color;
//        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:color size:self.navigationBar.size] forBarMetrics:UIBarMetricsDefaultPrompt];
//        UIImage *image = [UIImage imageWithColor:color size:self.navigationBar.size];
//         self.navigationBar.layer.contents = (id)image.CGImage;
    }
    else
    {
        UIImage *image = [UIImage imageWithColor:color size:self.navigationBar.size];
        
        if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
        {
            [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            self.navigationBar.layer.contents = (id)image.CGImage;
        }
    }
}

#pragma mark ----------------------------- navigationController delegate

- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate
{
    NSAssert(delegate == self, @"AuthNavViewController can only accept self as delegate");
    [super setDelegate:delegate];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果在push过程中触发手势滑动返回，会导致导航栏崩溃（从日志中可以看出）。针对这个问题，我们需要在pop过程禁用手势滑动返回功能：
    //    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        navigationController.interactivePopGestureRecognizer.enabled = YES;
    //    }
    
    if ([viewController isKindOfClass:[AwCommonViewController class]])
    {
        if (![(AwCommonViewController *)viewController hasNav])
        {
            if (!self.navigationBarHidden) [self setNavigationBarHidden:YES animated:animated];
            
        }
        else
        {
            if (self.navigationBarHidden) [self setNavigationBarHidden:NO animated:animated];
        }
    }
    else
    {
        NSLog(@"use CommonViewController as super please");
    }
}
#pragma mark -新增代码，用于滑动动画设计的
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                  animationControllerForOperation:(UINavigationControllerOperation)operation
//                                               fromViewController:(UIViewController *)fromVC
//                                                 toViewController:(UIViewController *)toVC
//{
//    if (operation == UINavigationControllerOperationPop) {
//        if (self.popAnimator == nil) {
//            self.popAnimator = [WQPopAnimator new];
//        }
//        return self.popAnimator;
//    }
//
//    return nil;
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    return self.popInteractionController;
//}

#pragma mark -
//
//- (void)enablePanToPopForNavigationController:(UINavigationController *)navigationController
//{
//    UIScreenEdgePanGestureRecognizer *left2rightSwipe = [[UIScreenEdgePanGestureRecognizer alloc]
//                                                         initWithTarget:self
//                                                         action:@selector(didPanToPop:)];
//    //[left2rightSwipe setDelegate:self];
//    [left2rightSwipe setEdges:UIRectEdgeLeft];
//    [navigationController.view addGestureRecognizer:left2rightSwipe];
//
//    self.popAnimator = [WQPopAnimator new];
//    self.supportPan2Pop = YES;
//}
//
//- (void)didPanToPop:(UIPanGestureRecognizer *)panGesture
//{
//    if (!self.supportPan2Pop) return ;
//
//    UIView *view = self.navigationController.view;
//
//    if (panGesture.state == UIGestureRecognizerStateBegan) {
//        self.popInteractionController = [UIPercentDrivenInteractiveTransition new];
//        [self.navigationController popViewControllerAnimated:YES];
//    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
//        CGPoint translation = [panGesture translationInView:view];
//        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
//        [self.popInteractionController updateInteractiveTransition:d];
//    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
//        if ([panGesture velocityInView:view].x > 0) {
//            [self.popInteractionController finishInteractiveTransition];
//        } else {
//            [self.popInteractionController cancelInteractiveTransition];
//        }
//        self.popInteractionController = nil;
//    }
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.topViewController.preferredStatusBarStyle;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end