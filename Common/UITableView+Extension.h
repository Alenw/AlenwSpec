//
//  UITableView+Extension.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)
//工厂方法
+ (instancetype)tableView;
+ (instancetype)groupTableView;

//工具方法
- (void)scrollToBottom;
@end
