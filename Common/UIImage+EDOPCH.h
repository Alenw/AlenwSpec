//
//  UIImage+FQQ.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EDOPCH)
-(UIImage*)imageScaledToSize:(CGSize)newSize;
-(UIImage*)imageScaledToWidth:(CGFloat)f;
+ (UIImage*) createImageWithColor: (UIColor*) color;
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
-(UIImage*)imageScaledToRect:(CGRect)recr;
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
@end
