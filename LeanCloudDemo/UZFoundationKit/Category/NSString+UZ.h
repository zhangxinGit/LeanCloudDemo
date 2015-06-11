//
//  NSString+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UZ)

// default is utf-8 string encoding
+ (NSString *)stringWithData:(NSData *)data;
+ (NSString *)stringWithData:(NSData *)data stringEncoding:(NSStringEncoding)encoding;

//Validation
- (BOOL)phoneNumberValidation;
- (BOOL)zipCodeValidation;
- (BOOL)emailValidation;

- (NSString *)percentEscapeParttern;

@end
