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
-(void)beginTimer;

-(void)pauseTimer;

-(void)stopTimer;
-(void)reloadData;
@end
