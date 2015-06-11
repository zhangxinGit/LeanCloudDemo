//
//  ProductImageModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-16.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UProductImageModel.h"

@implementation UProductImageModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{@"imageId":@"id",@"imageUrl":@"large",@"imageDescription":@"description"};
}

@end
