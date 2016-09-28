//
//  JYADView.h
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYADView;
@protocol JYADViewDelegate <NSObject>

@optional
-(void)ADViewDidSelected:(JYADView *)adView atIndex:(NSInteger)index;

@end

@interface JYADView : UIView
/** 轮播图片数组<UIImage *> */
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;
/** 图片点击事件 */
@property(nonatomic,copy)void (^adDidClick)(NSInteger index);
/** 未使用 */
@property (nonatomic, copy) NSString *type;
/** self 高度 */
@property (nonatomic, assign) NSInteger ADViewheight;
/** 图片数组中图片对应的文字<NSString *> */
@property (nonatomic, copy) NSArray *titleTexts;
/** 代理 */
@property (nonatomic, weak) id<JYADViewDelegate> delegate;

/** 是否自动滚动,default YES */
@property (nonatomic, assign) BOOL isAutoScroll;


@end

