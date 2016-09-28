//
//  AwWebViewController.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "AwCommonViewController.h"

@interface AwWebViewController : AwCommonViewController
/** 网页URL */
@property (nonatomic, copy) NSString *urlstr;
/** 导航栏title */
@property (nonatomic, copy) NSString *titlestr;

/** 网页返回按钮是否显示 */
@property (nonatomic, assign) BOOL notNeedBackItem;
/** 返回按钮颜色 */
@property (nonatomic, strong) UIColor *itemTinColor;
@end
