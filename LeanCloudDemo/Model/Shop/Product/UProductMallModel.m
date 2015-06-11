//
//  UProductMallModel.m
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductMallModel.h"

@implementation UProductMallModel
@synthesize mallId,mallName;

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
  return @{@"mallId":@"id",@"mallName":@"name"};
}

@end
