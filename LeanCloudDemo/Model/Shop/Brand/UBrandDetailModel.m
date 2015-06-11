//
//  UBrandDetailModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBrandDetailModel.h"

@implementation UBrandDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{@"brandId":@"id",@"displayDescription": @"description"};
}

@end
