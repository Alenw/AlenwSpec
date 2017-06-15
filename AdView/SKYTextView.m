//
//  SKYTextView.h
//  SKYCategory
//
//  Created by yelin on 2017/4/11.
//  Copyright © 2017年 Alenw. All rights reserved.
//  增强：带有占用文字

#import "SKYTextView.h"
#import <SKYCategory/UIColor+Sky.h>
#import <SKYCategory/UIView+Extension.h>

@interface SKYTextView ()
@property(nonatomic,assign) CGSize skyContentSize;
@end

@implementation SKYTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initContentViews];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initContentViews];
}
-(void)initContentViews{
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.width += 10;
    leftImageView.center = CGPointMake(20, 15);
    leftImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:leftImageView];
    self.leftImageView = leftImageView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}
-(void)textDidChange{
    if(self.limitLength){
        if(self.text.length>self.limitLength){
            self.text=[self.text substringToIndex:self.limitLength];
        }
    }
    self.leftImageView.hidden = YES;
    if (self.hasText == NO) {
        self.leftImageView.hidden = NO;
    }
    //重绘
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [self.backgroundImage drawInRect:rect];
    
    if(self.limitLength>0){
        NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
        attrs[NSFontAttributeName]=self.font;
        attrs[NSForegroundColorAttributeName]=self.placeholderColor?self.placeholderColor:RGBCOLOR(214, 214, 218);
        NSString *text=[NSString stringWithFormat:@"%@/%@",@(self.text.length),@(self.limitLength)];
        CGRect rect=[text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
        
        if(self.contentSize.height == self.frame.size.height){
            self.contentSize=CGSizeMake(self.contentSize.width, self.contentSize.height+rect.size.height);
            [self scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width, self.contentSize.height) animated:YES];
        }
        
        CGFloat height=self.contentSize.height>self.frame.size.height ? self.contentSize.height : self.frame.size.height;
        CGFloat x=self.contentSize.width - rect.size.width-5;
        CGFloat w=rect.size.width;
        CGFloat y=height - rect.size.height-5;
        CGFloat h=rect.size.height;
        CGRect placeholderRect=CGRectMake(x, y, w, h);
        
        [text drawInRect:placeholderRect withAttributes:attrs];
    }
    
    //如果有文字直接返回，不显示占位文字
    if(self.hasText)return;
    
    //文字属性
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=self.font;
    attrs[NSForegroundColorAttributeName]=self.placeholderColor?self.placeholderColor:RGBCOLOR(214, 214, 218);
    
    //画文字
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    
    CGFloat x=5;
    CGFloat w=rect.size.width-2*x;
    CGFloat y=8;
    CGFloat h=rect.size.height-2*y;
    CGRect placeholderRect=CGRectMake(x, y, w, h);
//    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder=[placeholder copy];
    [self setNeedsDisplay];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor=placeholderColor;
    [self setNeedsDisplay];
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
