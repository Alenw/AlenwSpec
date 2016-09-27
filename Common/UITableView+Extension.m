//
//  UITableView+Extension.m
//  AlenW
//
//  Created by soyoung on 16/2/1.
//  Copyright © 2016年 AlenW. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
+ (instancetype)tableView
{
    UITableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStylePlain];
    [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = view;
    
    _tableView.sectionHeaderHeight = 0.f;
    _tableView.sectionFooterHeight = 0.f;
    
#ifdef __IPHONE_7_0
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
#else
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
#endif
    return _tableView;
}

+ (instancetype)groupTableView
{
    UITableView *_tableView = [[self alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStyleGrouped];
    
    [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    _tableView.scrollEnabled = YES;
    _tableView.userInteractionEnabled = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    _tableView.sectionHeaderHeight = 0.f;
    _tableView.sectionFooterHeight = 0.f;
    
#ifdef __IPHONE_7_0
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
#else
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
#endif
    return _tableView;
}

- (void)scrollToBottom{
    NSInteger sectionCount = [self.dataSource numberOfSectionsInTableView:self];
    NSInteger lastSectionRowCount = [self.dataSource tableView:self numberOfRowsInSection:sectionCount-1];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastSectionRowCount-1 inSection:sectionCount-1];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
