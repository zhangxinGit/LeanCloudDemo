//
//  UProductSizeViewModel.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductSizeViewModel.h"
#import "UCategoryDetailModel.h"

@implementation UProductSizeViewModel
@synthesize measureTableArray,measure_propertiesArray,measure_pic;

-(instancetype)initWithDetailProduct:(UProductDetailModel *)productDetailModel{
  
  self = [super init];
  
  UCategoryDetailModel *category2Model = productDetailModel.category2Model;
  
  measure_pic = category2Model.measure_pic;
  
  measureTableArray = productDetailModel.measureTableArray;

  NSString *prefixStr = @"原码,通用,";
  
  NSString *measure_propertyStr = [NSString stringWithFormat:@"%@%@",prefixStr,category2Model.measure_properties];
  
  NSArray *measureArray = [measure_propertyStr componentsSeparatedByString:@","];
  
  measure_propertiesArray = [[NSMutableArray alloc] initWithCapacity:[measureArray count]];
  
  for (int i = 0;i < [measureArray count];i++) {
    NSString *measureString = measureArray[i];
    if (![measureString isEqualToString:@""]) [measure_propertiesArray addObject:[measureString substringToIndex:2]];
  }
  
  return self;
}

@end
