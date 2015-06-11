//
//  UProductDetailModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved. brandModel,category1Model,category2Model,
//

#import "UProductDetailModel.h"
#import "UProductImageModel.h"
#import "UProductVideoModel.h"
#import "UProductValueModel.h"
#import "UProductColorModel.h"

@implementation UProductDetailModel
@synthesize mallModel,category1Model,category2Model,relate_productsArray,videosArray,valuesArray,imagesArray,measureTableArray;

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{@"productId":@"id",
//           @"colorPicUrl":@"color_pic",
           @"productDescription":@"description",@"measureTable":@"measure_table",@"measureStyle":@"measure_style",@"measureDescription":@"measure_description"};
}

- (id)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error
{
  self = [super initWithDictionary:dictionaryValue error:error];
  
  if (self == nil) return nil;
  
  category1Model = [MTLJSONAdapter modelOfClass:UCategoryDetailModel.class fromJSONDictionary:dictionaryValue[@"category1"] error:nil];
  
  category2Model = [MTLJSONAdapter modelOfClass:UCategoryDetailModel.class fromJSONDictionary:dictionaryValue[@"category2"] error:nil];
  
  mallModel = [MTLJSONAdapter modelOfClass:UProductMallModel.class fromJSONDictionary:dictionaryValue[@"mall"] error:nil];
  
  NSArray *relate_productsArr = dictionaryValue[@"relate_products"];
  
  relate_productsArray = [[NSMutableArray alloc] initWithCapacity:[relate_productsArr count]];
  
  for (int i = 0; i < [relate_productsArr count]; i++) {
    UProductColorModel *colorModel = [MTLJSONAdapter modelOfClass:UProductColorModel.class fromJSONDictionary:relate_productsArr[i] error:nil];
    [relate_productsArray addObject:colorModel];
  }
  
  NSArray *videoArr = dictionaryValue[@"videos"];
  
  videosArray = [[NSMutableArray alloc] initWithCapacity:[videoArr count]];
  
  for (int i = 0; i < [videoArr count]; i++) {
    UProductVideoModel *videoModel =  [MTLJSONAdapter modelOfClass:UProductVideoModel.class fromJSONDictionary:videoArr[i] error:nil];
    [videosArray addObject:videoModel];
  }
  
  NSArray *valueArr = dictionaryValue[@"values"];
  
  valuesArray = [[NSMutableArray alloc] initWithCapacity:[valueArr count]];
  
  for (int i = 0; i < [valueArr count]; i++) {
    NSDictionary *valueDict = valueArr[i];
    BOOL needNew = YES;
    for (UProductValueModel *valueM in valuesArray) {
      if (StringEqual(valueDict[@"attribute_name"], valueM.attribute_name)) {
        valueM.content = [NSString stringWithFormat:@"%@ , %@", valueM.content, valueDict[@"content"]];
        needNew = NO;
      }
    }
    
    if (needNew) {
      UProductValueModel *valueModel =  [MTLJSONAdapter modelOfClass:UProductValueModel.class fromJSONDictionary:valueDict error:nil];
      [valuesArray addObject:valueModel];
    }
  }
  
  NSArray *imgArr = dictionaryValue[@"images"];
  
  imagesArray = [[NSMutableArray alloc] initWithCapacity:[imgArr count]];
  
  for (int i = 0; i < [imgArr count]; i++) {
    UProductImageModel *imageModel =  [MTLJSONAdapter modelOfClass:UProductImageModel.class fromJSONDictionary:imgArr[i] error:nil];
    [imagesArray addObject:imageModel];
  }
  
  NSString *measureTableStr;
  NSArray *measureTableArr;
  
  //空字符串也得去处理
  if (![dictionaryValue[@"measureTable"] isEqual:[NSNull null]]) {
    measureTableStr  = [NSString stringWithFormat:@"%@",dictionaryValue[@"measureTable"]];
    measureTableArr = [measureTableStr componentsSeparatedByString:@"\r\n"];
  }
  
  measureTableArray = [[NSMutableArray alloc] initWithCapacity:[measureTableArr count]];
  
  for (int i = 0; i < [measureTableArr count]; i++) {
    NSArray *valueArray = [[NSString stringWithString:measureTableArr[i]] componentsSeparatedByString:@","];
    if([valueArray count]>1) [measureTableArray addObject:valueArray];
  }
  
  return self;
  
}

@end
