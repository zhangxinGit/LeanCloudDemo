//
//  UComUtil.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UComUtil : NSObject

// date to string.
+ (NSString *)dtos:(NSDate *)date format:(NSString *)format;
// string to date.
+ (NSDate *)stod:(NSString *)dateString format:(NSString *)format;

// 图片地址拼后缀
+ (NSURL *)imageUrlAppendString:(NSString *)urlString withSize:(CGFloat) size;
// 只拼后缀
+ (NSURL *)imageUrlAddSuffix:(NSString *)wholeStr size:(CGFloat)size;

// 视频地址拼后缀
+ (NSURL *)videoUrlAppendString:(NSString *)urlString withSuffix:(NSString *)suffixString;

// 字符串过滤特殊字符如转义字符括号
+ (NSString *)filterSpecialChar:(NSString *)oraginString withSpecialChar:(NSString *)charString;

// 时间的比较 只根据日期
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

@end
