//
//  UBrandSimpleModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBrandSimpleModel.h"

@implementation UBrandSimpleModel

//将对象的属性映射到JSON中不同的key path
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
   return @{@"brandId":@"id"};
}

@end
