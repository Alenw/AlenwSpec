//
//  AwTextField.m
//  SKYCategory
//
//  Created by yelin on 2017/4/11.
//  Copyright © 2017年 Alenw. All rights reserved.
//

#import "AwTextField.h"

@implementation AwTextField

//控制 placeHolder 的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}

// 控制文本的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}

@end
