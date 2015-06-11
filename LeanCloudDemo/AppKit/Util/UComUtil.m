//
//  UComUtil.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UComUtil.h"

static NSDateFormatter * formatter = nil;

@implementation UComUtil

+ (void)load {
  formatter = [[NSDateFormatter alloc] init];
}

+ (NSDate *)stod:(NSString *)dateString format:(NSString *)format {
  [formatter setDateFormat:format];
  return [formatter dateFromString:dateString];
}

+ (NSString *)dtos:(NSDate *)date format:(NSString *)format {
  [formatter setDateFormat:format];
  return [formatter stringFromDate:date];
}

+ (NSURL *)imageUrlAppendString:(NSString *)urlString withSize:(CGFloat)size{
  return [self imageUrlAddSuffix:[NSString stringWithFormat:@"%@%@", USTATION_IMAGE_URL, urlString] size:size];
}

+ (NSURL *)imageUrlAddSuffix:(NSString *)wholeStr size:(CGFloat)size {
  NSString *suffixStr;
  
  size *= RETINA_SCALE;
  
  if (size <= 50) {
    suffixStr = @"s50";
  } else if (size <= 90) {
    suffixStr = @"m90";
  } else if (size <= 130) {
    suffixStr = @"m130";
  } else if (size <= 180) {
    suffixStr = @"small";
  } else if (size <= 220) {
    suffixStr = @"m220";
  } else if (size <= 270) {
    suffixStr = @"m270";
  } else if (size <= 300) {
    suffixStr = @"middle";
  } else if (size <= 350) {
    suffixStr = @"promote";
  } else if (size <= 400) {
    suffixStr = @"s400";
  } else if (size <= 450) {
    suffixStr = @"moderate";
  } else if (size <= 500) {
    suffixStr = @"p500";
  } else if (size <= 580) {
    suffixStr = @"m580";
  } else if (size <= 640) {
    suffixStr = @"m640";
  } else {    //750
    suffixStr = @"large";
  }
  
  NSString *urlStr = [NSString stringWithFormat:@"%@.%@.jpg", wholeStr, suffixStr];
  NSURL *url = [NSURL URLWithString:urlStr];
  return url;
}

+ (NSURL *)videoUrlAppendString:(NSString *)urlString withSuffix:(NSString *)suffixString{
  NSString *urlStr = [NSString stringWithFormat:@"%@%@.%@.mp4",UVIDEO_URL,urlString,suffixString];
  NSURL *url = [NSURL URLWithString:urlStr];
  return url;
}

+ (NSString *)filterSpecialChar:(NSString *)oraginString withSpecialChar:(NSString *)charString
{
  NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}""（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
  oraginString = [[oraginString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
  
  NSMutableString *responseString = [NSMutableString stringWithString:oraginString];
  
  NSString *character = nil;
  
  for (int i = 0; i < responseString.length; i ++){
    character = [responseString substringWithRange:NSMakeRange(i, 1)];
    if ([character isEqualToString:charString]){
      [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
       i--;
    }
  }
  
  return responseString;
}

+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"dd-MM-yyyy"];
  NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
  NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
  NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
  NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
  NSComparisonResult result = [dateA compare:dateB];
  NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
  if (result == NSOrderedDescending) {
    //NSLog(@"Date1  is in the future");
    return 1;
  }
  else if (result == NSOrderedAscending){
    //NSLog(@"Date1 is in the past");
    return -1;
  }
  //NSLog(@"Both dates are the same");
  return 0;
  
}

@end
