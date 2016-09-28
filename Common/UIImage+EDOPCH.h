//
//  UIImage+FQQ.h
//  FQQ
//
//  Created by feiquanqiu on 15/5/18.
//  Copyright (c) 2015年 feiquanqiu. All rights reserved.
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
