//
//  UIColor+Sky.h
//  iPhoneTest
//
//  Created by soyoung on 15/10/8.
//  Copyright © 2015年 soyoung. All rights reserved.
//

#import <UIKit/UIKit.h>

//颜色创建
#undef  RGBCOLOR
#define RGBCOLOR(r,g,b)     RGBACOLOR(r,g,b,1.0)
#undef	SKYRandColor
#define SKYRandColor        RGBCOLOR((rand()%255+1),(rand()%255+1),(rand()%255+1))
#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#undef	HEX_RGB
#define HEX_RGB(V)          [UIColor colorWithRGBHex:V]
#undef	SKYDefaultColor
#define SKYDefaultColor     RGBCOLOR(243,245,246)

@interface UIColor (Sky)
/** 16进制创建颜色 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
/** 字符串创建颜色 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
