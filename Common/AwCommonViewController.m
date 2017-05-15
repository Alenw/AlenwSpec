//
//  AwCommonViewController.m
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "AwCommonViewController.h"
#import <SKYCategory/SKYCategory.h>
#import "SKYBarButtonItem.h"

@interface AwCommonViewController ()

@end

@implementation AwCommonViewController

+ (id)controller{
    return [[self alloc] init];
}

- (id)init{
    self = [super init];
    if (self) {
        //        self.isNeedBackItem = YES;
        //        self.bSupportPanUI = YES;
        self.hasNav = YES;
        self.iOS7FullScreenLayout = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //        self.isNeedBackItem = YES;
        //        self.bSupportPanUI = YES;
        self.hasNav = YES;
        self.iOS7FullScreenLayout = NO;
    }
    
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.hasNav = YES;
        self.iOS7FullScreenLayout = NO;
    }
    return self;
}

- (void)setIOS7FullScreenLayout:(BOOL)iOS7FullScreenLayout{
    _iOS7FullScreenLayout = iOS7FullScreenLayout;
    if (IOS7_OR_LATER){
        if (_iOS7FullScreenLayout){
            self.edgesForExtendedLayout = UIRectEdgeAll;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = YES;
        }else{
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}
/**
 *  设置默认的Nav titleView样式
 */
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    //    UILabel *_titleView = [[UILabel alloc] init];
    //    _titleView.textColor = [UIColor lightGrayColor];
    //
    //    _titleView.backgroundColor = [UIColor clearColor];
    //    _titleView.font = [UIFont systemFontOfSize:19.0f];
    //    _titleView.textAlignment = NSTextAlignmentCenter;
    
    CGRect frame = self.titleViewLabel.frame;
    if (IOS7_OR_LATER) {
        frame.size.width = 60;
    }
    self.titleViewLabel.text = title;
    self.titleViewLabel.frame = CGRectMake(frame.origin.x, 5, frame.size.width, 34);
    self.navigationItem.titleView = self.titleViewLabel;
    
}
/**
 *  自定义的Nav titleView
 */
- (UILabel *)titleViewLabel{
    if (!_titleViewLabel) {
        _titleViewLabel = [[UILabel alloc] init];
        //默认颜色
        NSString *string=[CoreArchive strForKey:@"ThemeColorString"];
        _titleViewLabel.textColor = [string isEqualToString:@"ffffff"]  ? [UIColor colorWithHexString:@"282828"]:[UIColor whiteColor];
        _titleViewLabel.backgroundColor = [UIColor clearColor];
        _titleViewLabel.font = [UIFont systemFontOfSize:19.0];
        _titleViewLabel.textAlignment = NSTextAlignmentCenter;
        _titleViewLabel.adjustsFontSizeToFitWidth=YES;
    }
    return _titleViewLabel;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (IOS7_OR_LATER) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)loadView{
    [super loadView];
    [self.view setExclusiveTouch:YES];
}

- (UITableView *)tableView{
    
    if(!_tableView){
        
        _tableView = [UITableView tableView];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        
        //        if ([_tableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        //        {
        //            if ([_tableView.dataSource isKindOfClass:[UIViewController class]])
        //            {
        //                UIViewController *v = (UIViewController *)_tableView.dataSource;
        //                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
        //                {
        //                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
        //                    for (UIGestureRecognizer *ges in _tableView.gestureRecognizers) {
        //                        [nav.panGes requireGestureRecognizerToFail:ges];
        //                    }
        //                }
        //            }
        //        }
    }
    
    return _tableView;
}

- (UITableView *)groupTableView{
    
    if(!_groupTableView){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
        if (IOS7_OR_LATER) {
            _groupTableView = [UITableView groupTableView];
        }else{
            _groupTableView = [UITableView tableView];
        }
#pragma clang diagnostic pop
        _groupTableView.delegate =self;
        
        _groupTableView.dataSource =self;
        //
        //        if ([_groupTableView.dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        //        {
        //            if ([_groupTableView.dataSource isKindOfClass:[UIViewController class]])
        //            {
        //                UIViewController *v = (UIViewController *)_groupTableView.dataSource;
        //                if ([v.navigationController isKindOfClass:[ScreenShotNavViewController class]])
        //                {
        //                    ScreenShotNavViewController *nav = (ScreenShotNavViewController *)v.navigationController;
        //                    for (UIGestureRecognizer *ges in _groupTableView.gestureRecognizers) {
        //                        [nav.panGes requireGestureRecognizerToFail:ges];
        //                    }
        //                }
        //            }
        //        }
    }
    
    return _groupTableView;
}


#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}



#pragma mark -
#pragma mark utils

- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar{
    if (IOS7_OR_LATER && self.isIOS7FullScreenLayout){
        //全屏布局
        CGRect frame = [[UIScreen mainScreen] bounds];
        return frame;
    }else{
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.size.height -= 20;
        if (hasNav) {
            frame.size.height -= 44;
        }
        if (hasTabBar) {
            frame.size.height -= 48;
        }
        return frame;
    }
}

#pragma mark ----------------------------- ios7 兼容

#ifdef __IPHONE_7_0
//如果需要更换导航状态栏颜色，重写这个方法
- (UIStatusBarStyle)preferredStatusBarStyle{
    NSString * colorstring=[CoreArchive strForKey:@"ThemeColorString"];
    if(IsStrEmpty(colorstring)){
        colorstring=@"ffffff";
        [CoreArchive setStr:@"ffffff" key:@"ThemeColorString"];
        return UIStatusBarStyleDefault;
    }else if([colorstring isEqualToString:@"ffffff"]){
        return UIStatusBarStyleDefault;
    }else{
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

#endif

@end
