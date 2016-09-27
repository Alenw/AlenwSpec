//
//  UIImage+Extend.h
//  CDHN
//
//  Created by muxi on 14-10-14.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)
/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param completeBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock;


-(UIImage *)remakeImageWithFullSize:(CGSize)fullSize zoom:(CGFloat)zoom;

/*
 *  生成一个默认的占位图片：bundle默认图片
 */
+(UIImage *)phImageWithSize:(CGSize)fullSize zoom:(CGFloat)zoom;

/** 本地图片/从bundle获取 */
+ (UIImage *)noCacheImageNamed:(NSString *)imageName;
/** 通过颜色、大小返回一个图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/** 图片拉伸1/2 */
+ (UIImage *)streImageNamed:(NSString *)imageName;
/** 图片自定义拉伸 */
+ (UIImage *)streImageNamed:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;
/** 图片拉伸1/2 */
- (UIImage *)stretched;
/**  */
- (UIImage *)grayscale;

/** 图片返回颜色 */
- (UIColor *)patternColor;
/** 返回指定大小的图片 */
- (UIImage *)imageAtRect:(CGRect)rect;
/**
 * 根据指定图片的文件名获取一张圆型的图片对象,并加边框
 * @param name 图片文件名
 * @param borderWidth 边框的宽
 * @param borderColor 边框的颜色
 * @return 切好的圆型图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 * 将一张图片变成指定的大小
 * @param image 原图片
 * @param size 指定的大小
 * @return 指定大小的图片
 */
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;
/**
 *  将指定图片画成圆形
 *
 *  @param imgV 被修改的UIImageView
 */
+(void)drawCircleImageView:(UIImageView *)imgV andRadius:(NSInteger)radius;

/**
 *  按比例缩小图片
 *
 *  @param sourceImage 源图片
 *  @param size        需要改变的大小
 *
 *  @return 修改后的图片
 */
+(UIImage *) scaleToSizeWithImage:(UIImage *)sourceImage size:(CGSize)size;
/**
 *  将图片按指定宽度缩放
 *
 *  @param sourceImage 源图片
 *  @param defineWidth 修改宽度
 *
 *  @return 修改后图片
 */
+(UIImage *) scaleToSizeWithImage:(UIImage *)sourceImage width:(CGFloat)defineWidth;
@end
