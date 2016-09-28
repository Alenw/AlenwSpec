//
//  UIImage+FQQ.m
//  FQQ
//
//  Created by feiquanqiu on 15/5/18.
//  Copyright (c) 2015年 feiquanqiu. All rights reserved.
//

#import "UIImage+EDOPCH.h"

@implementation UIImage (EDOPCH)
-(UIImage*)imageScaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
-(UIImage*)imageScaledToRect:(CGRect)recr
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(recr.size);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(recr.origin.x,recr.origin.y,recr.size.width,recr.size.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
-(UIImage*)imageScaledToWidth:(CGFloat)f
{
    CGSize newSize =self.size ;
    if (self.size.width<=f) {
        return self;
    }else{
        CGFloat width = newSize.width;
        newSize.width=f;
        CGFloat x = newSize.width/width;
        newSize.height = x*newSize.height;
        
    }
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
     
    /*
    CGRect rect = CGRectMake((self.size.width-newSize.width)/2, (self.size.height-newSize.height)/2, newSize.width, newSize.height);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;*/
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(UIImage *)addImageLogo:(UIImage *)img text:(UIImage *)logo
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth, 0, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}
-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));
    
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}
- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end
