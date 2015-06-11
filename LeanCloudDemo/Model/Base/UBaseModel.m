//
//  UBaseModel.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/13.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UBaseModel.h"

static NSDateFormatter *dateFormatter;

@implementation UBaseModel

+ (NSDateFormatter *)dateFormatter {
  dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'+08:00'";
  return dateFormatter;
}

+ (NSValueTransformer *)commonDateValueTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  } reverseBlock:^(NSDate *date) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

+ (NSValueTransformer *)updated_atJSONTransformer {
  return [self commonDateValueTransformer];
}

+ (NSValueTransformer *)created_atJSONTransformer {
  return [self commonDateValueTransformer];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  //hold undefined key
}

@end
