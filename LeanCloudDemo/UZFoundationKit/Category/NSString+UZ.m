//
//  NSString+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "NSString+UZ.h"

@implementation NSString (UZ)

+ (NSString *)stringWithData:(NSData *)data {
  return [self stringWithData:data stringEncoding:NSUTF8StringEncoding];
}

+ (NSString *)stringWithData:(NSData *)data stringEncoding:(NSStringEncoding)encoding {
  return [[self alloc] initWithData:data encoding:encoding];
}

- (BOOL)phoneNumberValidation {
  NSString *phoneRegex = @"^(1[0-9])\\d{9}$";
  NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
  return [phonePredicate evaluateWithObject:self];
}

- (BOOL)emailValidation {
  NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
  NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailPredicate evaluateWithObject:self];
}

- (BOOL)zipCodeValidation {
  const char *cvalue = [self UTF8String];
  NSInteger len = strlen(cvalue);
  if (len != 6) {
    return NO;
  }
  for (int i = 0; i < len; i++)
  {
    if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
    {
      return YES;
    }
  }
  return YES;
}

- (NSString *)percentEscapeParttern {
  return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
