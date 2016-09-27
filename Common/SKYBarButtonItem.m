//
//  SKYBarButtonItem.m
//  tripBySoyoung
//
//  Created by soyoung on 16/1/18.
//  Copyright © 2016年 soyoung. All rights reserved.
//

#import "SKYBarButtonItem.h"

@implementation SKYBarButtonItem
+(instancetype)initWithSkyTitle:(NSString *)title Style:(SKYNavItemStyle)style target:(id)target action:(SEL)action image:(NSString *)image heighImage:(NSString *)heighImage{

    switch (style) {
        case 0:{
            //60*60@2x
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:heighImage] forState:UIControlStateSelected];
            CGRect frame=(CGRect){{-10,0},button.currentBackgroundImage.size};
            button.frame = frame;
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            return [[SKYBarButtonItem alloc]initWithCustomView:button];
            break;
        }
        case 1:{
            SKYBarButtonItem *item=[[SKYBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
            [item setTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
            item.tintColor = [UIColor blackColor];
            return item;
            break;
        }
        case 2:{
            //48*48@2x
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:heighImage] forState:UIControlStateSelected];
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:15.0];
            button.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
            button.titleEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
            button.frame=CGRectMake(0, 0, 44, 44);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            return [[SKYBarButtonItem alloc]initWithCustomView:button];
            break;
        }
        default:
            break;
    }
    return nil;
}
+(instancetype)initWithItemTitle:(NSString *)title withItemTintColor:(UIColor *)color target:(id)target action:(SEL)action backImage:(NSString *)image heighImage:(NSString *)heighImage{
    if(color==nil)color=[UIColor blackColor];
    if (image!=nil || heighImage!=nil) {//has image
        if (title!=nil) {
            //48*48@2x
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:heighImage] forState:UIControlStateSelected];
            [button setTitle:title forState:UIControlStateNormal];
            button.titleLabel.font=[UIFont systemFontOfSize:15.0];
            button.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
            button.titleEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
            button.frame=CGRectMake(0, 0, 44, 44);
            [button setTitleColor:color forState:UIControlStateNormal];
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            return [[SKYBarButtonItem alloc]initWithCustomView:button];
        }else{
            //60*60@2x
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:heighImage] forState:UIControlStateSelected];
            CGRect frame=(CGRect){{0,0},button.currentBackgroundImage.size};
            button.frame = frame;
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            return [[SKYBarButtonItem alloc]initWithCustomView:button];
        }
        
    }else{
        SKYBarButtonItem *item=[[SKYBarButtonItem alloc]initWithTitle:title ? title:@"返回" style:UIBarButtonItemStylePlain target:target action:action];
//        [item setTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
        item.tintColor = color;
        return item;
    }
}
- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if ([self.customView isKindOfClass:[UIControl class]])
    {
        UIControl *ctrl = (UIControl *)self.customView;
        ctrl.enabled = enabled;
    }
}

@end
