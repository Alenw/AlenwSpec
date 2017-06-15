//
//  SKYTextView.h
//  SKYCategory
//
//  Created by yelin on 2017/4/11.
//  Copyright © 2017年 Alenw. All rights reserved.
//  增强：带有占用文字

#import <UIKit/UIKit.h>

@interface SKYTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 整个TextView的背景色 */
@property (nonatomic, strong) UIImage *backgroundImage;
/** 下标文字长度/剩余可输入长度 */
@property (nonatomic, assign) NSUInteger limitLength;
/** 占位文字前图标 */
@property (nonatomic, weak) UIImageView *leftImageView;
@end
