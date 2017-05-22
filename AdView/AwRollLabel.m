//
//  AwRollLabel.m
//  YFRollingLabel
//
//  Created by yelin on 16/6/25.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "AwRollLabel.h"

@interface UIView(AwRollLabel)
@property (nonatomic, assign) CGFloat y;
@end
@implementation UIView(AwRollLabel)
@dynamic y;
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
@end

#define alignLeft 10

@interface AwRollLabel ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *label3;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation AwRollLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self prepareWork];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self prepareWork];
    }
    return self;
}
-(void)prepareWork{
    
    //初始化控件
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(alignLeft, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(alignLeft, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(alignLeft, self.frame.size.height*2, self.frame.size.width, self.frame.size.height)];
    [self addSubview:label3];
    self.label1=label1;
    self.label2=label2;
    self.label3=label3;
    
    //初始化事件监听
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    self.clipsToBounds=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollBegin:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rollStop:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)rollBegin:(NSNotification *)notification{
    [self reloadData];
}
-(void)rollStop:(NSNotification *)notification{
    [self pauseTimer];
}

-(void)tapAction{
    if (self.index==0) {
        NSLog(@"index=%@,text:%@",@(self.textArray.count-1),[self.textArray lastObject]);
    }else{
        NSLog(@"index=%@,text:%@",@(self.index-1),self.textArray[self.index-1]);
    }
    if (self.tapBlock) {
        if (self.index==0) {
            self.tapBlock(self.textArray.count-1);
        }else{
            self.tapBlock(self.index-1);
        }
    }
}
-(void)setTextArray:(NSArray *)textArray{
    _textArray=textArray;
    
    if (textArray.count>1) {
        self.label1.text=self.textArray[self.index];
        self.label2.text=self.textArray[self.index+1];
        self.index=1;
        [self addTimer];
    }
    if (textArray.count==1) {
        self.label1.text=self.textArray[self.index];
    }
}
-(void)setLabelColor:(UIColor *)labelColor{
    _labelColor=labelColor;
    self.label1.textColor=labelColor;
    self.label2.textColor=labelColor;
    self.label3.textColor=labelColor;
}
-(void)setLabelFont:(NSInteger)labelFont{
    _labelFont=labelFont;
    self.label1.font=[UIFont systemFontOfSize:labelFont];
    self.label2.font=[UIFont systemFontOfSize:labelFont];
    self.label3.font=[UIFont systemFontOfSize:labelFont];
}
-(void)reloadData{
    [self stopTimer];
    self.index=0;
    self.textArray=self.textArray;
}
-(void)beginTimer{
    if(self.timer == nil){
        [self addTimer];
        return;
    }
    if(_timer && [_timer isValid]){
        [_timer setFireDate:[NSDate date]];
    }
}

-(void)pauseTimer{
    if(_timer && [_timer isValid]){
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

-(void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}
/**
 *  添加定时器
 */
-(void)addTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //    [[NSRunLoop currentRunLoop] runMode:UITrackingRunLoopMode beforeDate:[NSDate date]];
    
    self.timer=timer;
}

-(void)timerAction{
    CGFloat height=self.frame.size.height;
    __weak typeof(self) weakself=self;
    [UIView animateWithDuration:1 animations:^{
        weakself.label1.y -= height;
        weakself.label2.y -= height;
    } completion:^(BOOL finished) {
        
        if (weakself.label1.y<=-height) {
            weakself.label1.y=height;
        }
        if (weakself.label2.y<=-height) {
            weakself.label2.y=height;
        }
        if (weakself.label3.y<=-height) {
            weakself.label3.y=2*height;
        }
        if (weakself.label1.y==0) {
            weakself.index++;
            if (weakself.index >=weakself.textArray.count) {
                weakself.index=0;
                weakself.label2.text=weakself.textArray[0];
                weakself.currentIndex=0;
            }else{
                weakself.label2.text=weakself.textArray[self.index];
                weakself.currentIndex=weakself.index;
            }
        }
        if (weakself.label2.y==0) {
            weakself.index++;
            if (weakself.index >=weakself.textArray.count) {
                weakself.index=0;
                weakself.label1.text=weakself.textArray[0];
                weakself.currentIndex=0;
            }else{
                weakself.label1.text=weakself.textArray[weakself.index];
                weakself.currentIndex=weakself.index;
            }
        }
    }];
}
-(void)dealloc{
    [self.timer invalidate];
}

@end
