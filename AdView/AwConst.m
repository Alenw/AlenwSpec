//
//  AwConst.m
//  EasyLearnFs
//
//  Created by yelin on 2017/8/11.
//  Copyright © 2017年 Alenw. All rights reserved.
//

#import "AwConst.h"
#import "CoreArchive.h"
#import <SKYCategory/UIColor+Sky.h>

#define nsxt 1

@implementation AwConst
+(NSString *)navTextColor{
    if (!nsxt) return @"ffffff";
    NSString *colorString=[AwConst getColorString];
    NSString *navTextColor=[colorString isEqualToString:@"ffffff"]  ? @"282828":@"ffffff";
    return navTextColor;
}
+(NSString *)baseNavBack{
    if (!nsxt) return @"nav_back_white";
    NSString *colorString=[AwConst getColorString];
    NSString *baseNavBack=[colorString isEqualToString:@"ffffff"] ? @"nav_back":@"nav_back_white";
    return baseNavBack;
}
+(NSString *)navBackgound{
    if (!nsxt) return @"409fff";
    NSString *navBackgound= [AwConst getColorString];
    return navBackgound;
}
+(NSString *)getColorString{
    NSString *colorString=[CoreArchive strForKey:@"ThemeColorString"];
    colorString=((colorString) == nil) || ([(colorString) isEqual:[NSNull null]]) ||([(colorString)isEqualToString:@""]) ?@"ffffff" : colorString;
    return colorString;
}
@end

