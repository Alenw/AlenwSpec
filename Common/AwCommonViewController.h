//
//  AwCommonViewController.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AwCommonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) UITableView       *groupTableView;


/** 控件用于替换不同类型的Nav titleView */
@property (nonatomic, strong) UILabel           *titleViewLabel;

@property (nonatomic, assign) BOOL              hasNav; //default is YES;

//@property (nonatomic, assign) BOOL bSupportPanUI;//是否支持拖动pop手势，默认yes
//@property (nonatomic, assign) BOOL              isNeedBackItem;
//@property (nonatomic, strong) UIColor *backgroudColor;

@property (nonatomic, assign, getter=isIOS7FullScreenLayout) BOOL  iOS7FullScreenLayout;   //default is NO;


+ (id)controller;

//工具方法计算visibileRect
- (CGRect)visibleBoundsShowNav:(BOOL)hasNav showTabBar:(BOOL)hasTabBar;
@end
