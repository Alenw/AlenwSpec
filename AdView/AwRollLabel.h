//
//  AwRollLabel.h
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AwRollTapBlock)(NSInteger index);

@interface AwRollLabel : UIView
@property (nonatomic, copy) NSArray *textArray;
@property (nonatomic, copy) AwRollTapBlock tapBlock;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, assign) NSInteger labelFont;
/** 启动定时器 */
-(void)beginTimer;
/** 暂停定时器 */
-(void)pauseTimer;
/** 停止定时器 */
-(void)stopTimer;
/** 重新刷新数据 */
-(void)reloadData;
@end
