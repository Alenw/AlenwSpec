//
//  UITableView+Extension.h
//  AlenW
//
//  Created by soyoung on 16/2/1.
//  Copyright © 2016年 AlenW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)
//工厂方法
+ (instancetype)tableView;
+ (instancetype)groupTableView;

//工具方法
- (void)scrollToBottom;
@end
