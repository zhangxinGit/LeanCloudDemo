//
//  UProductSummaryModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UProductSummaryModel.h"

@implementation UProductSummaryModel
@synthesize measures_unsold_count;

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
  return @{@"productId":@"id"};
}

- (id)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
  self = [super initWithDictionary:dictionaryValue error:error];
  
  NSString *unsold_countStr = [UComUtil filterSpecialChar:dictionaryValue[@"measures_unsold_count"] withSpecialChar:@"\""];
  
  NSArray *measure_unsoldArray = [unsold_countStr componentsSeparatedByString:@","];
  
  measures_unsold_count = [[NSMutableDictionary alloc] initWithCapacity:[measure_unsoldArray count]];
  
  for (int i = 0; i < [measure_unsoldArray count]; i++) {
    if (![measure_unsoldArray[i] isEqualToString:@""]) {
      NSArray *tempArr = [measure_unsoldArray[i] componentsSeparatedByString:@":"];
      [measures_unsold_count setObject:tempArr[1] forKey:[NSString stringWithFormat:@"%@",tempArr[0]]];
    }
    
  }
  
  return self;
}

@end
