//
//  NSTimerHelper.m
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "NSTimerHelper.h"

//arc 支持performSelector:
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface NSTimerHelper()
{
    id __weak delegate_;
    SEL action_;
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) SEL action;

@end

/*********************************************************************/

@implementation NSTimerHelper

@synthesize timer = timer_;
@synthesize delegate = delegate_;
@synthesize action = action_;

- (void)dealloc {
    [self invalidate];
    delegate_ = nil;
    action_ = nil;
}

+ (NSTimerHelper *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    NSTimerHelper *helper = [[NSTimerHelper alloc] init];
    
    [helper invalidate];
    
    helper.delegate = aTarget;
    helper.action = aSelector;
    
    helper.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:helper selector:@selector(doSomething) userInfo:userInfo repeats:yesOrNo];
    
    return helper;
}

- (void)invalidate
{
    [timer_ invalidate];
    timer_ = nil;
}

- (void)doSomething
{
    if (self.delegate && [self.delegate respondsToSelector:self.action]) {
        SuppressPerformSelectorLeakWarning([self.delegate performSelector:self.action]);
    }
}

@end
