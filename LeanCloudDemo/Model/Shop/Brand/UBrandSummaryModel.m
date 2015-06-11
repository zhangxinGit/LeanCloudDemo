//
//  UBrandSummaryModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBrandSummaryModel.h"

@implementation UBrandSummaryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
  return @{@"brandId":@"id",@"chineseName":@"chinese",@"foreignName":@"name",@"picUrl":@"pic"};
}

@end
