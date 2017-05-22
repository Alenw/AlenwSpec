//
//  UIImage+Extend.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)
/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param failBlock     出错回调
 */
-(void)savedPhotosAlbum:(void(^)())completeBlock failBlock:(void(^)())failBlock;

// 加载最原始的图片，没有渲染
+ (UIImage *)imageWithOriginalName:(NSString *)imageName;

/** 把图片变成灰阶色调 */
- (UIImage *)grayscale;

/** 图片返回颜色 */
- (UIColor *)patternColor;

/** 本地图片/从bundle获取 */
+ (UIImage *)noCacheImageNamed:(NSString *)imageName;

/**
 *重绘图片
 *  @param fullSize 拉伸后大小
 *  @param zoom     原图大小拉伸倍数
 */
-(UIImage *)remakeImageWithFullSize:(CGSize)fullSize zoom:(CGFloat)zoom;
/*
 *  生成一个默认的占位图片：bundle默认图片
 */
+(UIImage *)phImageWithSize:(CGSize)fullSize zoom:(CGFloat)zoom;


/** 图片中间位置拉伸 */
- (UIImage *)stretched;
/** 图片拉伸1/2 */
+ (UIImage *)streImageNamed:(NSString *)imageName;
/** 图片自定义拉伸 */
+ (UIImage *)streImageNamed:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;

/** 返回指定大小的图片 */
- (UIImage *)imageAtRect:(CGRect)rect;

/**
 * 将一张图片变成指定的大小
 * @param image 原图片
 * @param size 指定的大小
 * @return 指定大小的图片
 */
+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;
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

/**
 *  将指定图片画成圆形
 *
 *  @param imgV 被修改的UIImageView
 */
+(void)drawCircleImageView:(UIImageView *)imgV andRadius:(NSInteger)radius;
/**
 * 根据指定图片的文件名获取一张圆型的图片对象,并加边框
 * @param name 图片文件名
 * @param borderWidth 边框的宽
 * @param borderColor 边框的颜色
 * @return 切好的圆型图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/** 通过颜色、大小返回一个图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  @param color 创建图片的颜色
 *  @param size  图片大小
 *  @param text  文字
 *  @param att   文字属性
 */
+ (UIImage*)createImageWithColor:(UIColor*)color andImageSize:(CGSize)size text:(NSString *)text attributes:(NSDictionary *)att;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

/**************************水印图片********************************/
/** 添加文字水印 */
- (UIImage *)addWaterText:(NSString *)text textPoint:(CGPoint)pt attributes:(NSDictionary *)att;
/** 添加图片水印 */
- (UIImage *)addWaterImage:(UIImage *)image imagePoint:(CGPoint)pt alpha:(CGFloat)alpha;
/** 添加图片文字水印 */
- (UIImage *)addWaterText:(NSString *)text textPoint:(CGPoint)textPt attributes:(NSDictionary *)att waterImage:(UIImage *)image imagePoint:(CGPoint)imagePt alpha:(CGFloat)alpha;

@end

/*
 A category on UIImage that enables you to query the color value of arbitrary
 pixels of the image.
 */
@interface UIImage (ColorAtPixel)

- (UIColor *)colorAtPixel:(CGPoint)point;

@end
