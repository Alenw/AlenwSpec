//
//  NSString+Extension.h
//  AlenW
//
//  Created by yelin on 16/6/8.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/** 通过字体，最大宽度计算文字范围 */
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/** 通过字体 计算文字范围 */
-(CGSize)sizeWithFont:(UIFont *)font;

/** 通过最大宽度 计算文字范围 */
- (CGSize)sizeWithMaxW:(CGFloat)maxW;

/** 计算当前文件/文件夹大小 */
-(NSInteger)fileSize;

/*
 *  document根文件夹
 */
+(NSString *)documentFolder;

/*
 *  caches根文件夹
 */
+(NSString *)cachesFolder;

/**
 *  生成子文件夹
 *
 *  如果子文件夹不存在，则直接创建；如果已经存在，则直接返回
 *
 *  @param subFolder 子文件夹名
 *
 *  @return 文件夹路径
 */
-(NSString *)createSubFolder:(NSString *)subFolder;

/** 在URL后面拼接字典参数并转UTF8 */
- (NSString *)urlByAppendingDict:(NSDictionary *)params;
/** 在URL后面拼接字典参数 */
- (NSString *)urlByAppendingDictNoEncode:(NSDictionary *)params;
/** 把字典中的键值对转拼接成&的字符串 */
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict addingPercentEscapes:(BOOL)add;
/**  */
- (NSDictionary *)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;
/** 把字典转成JSON字符串 */
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

/**  */
- (NSString *)URLEncoding;
/**  */
- (NSString *)URLDecoding;
/**  */
- (NSString *)trim;
/**  */
- (BOOL)isEmpty;
/**  */
- (BOOL)eq:(NSString *)other;
/**  */
- (BOOL)isValueOf:(NSArray *)array;
/**  */
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;
/**  */
- (NSString *)getterToSetter;
/**  */
- (NSString *)setterToGetter;
/**  */
- (NSString *)formatJSON;
/**  */
+ (NSString *)GUIDString;
/**  */
- (NSString *)removeHtmlTags;
/**  */
- (BOOL)has4ByteChar;
/**  */
- (BOOL)isAsciiString;
/**  */
+ (NSString*)md5HexDigest:(NSString*)input;

/**  */
+ (NSString *)generateGuid;
/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;

/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)versionStringCompare:(NSString *)other;



- (CGSize)heightWithFont:(UIFont *)withFont
                   width:(float)width
               linebreak:(NSLineBreakMode)lineBreakMode;


/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;


- (NSString *)replacedWhiteSpacsByString:(NSString *)replaceString;

- (NSString *)URLEvalutionEncoding;

- (NSString *)queryStringNoEncodeFromDictionary:(NSDictionary *)dict;

//- (NSString *)passport;
@end

#pragma mark -

@interface NSString (SNEncryption)

- (NSString *)MD5Hex;
- (NSData *)hexStringToData;    //从16进制的字符串格式转换为NSData
@end
