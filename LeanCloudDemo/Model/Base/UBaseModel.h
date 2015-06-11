//
//  UBaseModel.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/13.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "Mantle.h"

@interface UBaseModel : MTLModel

+ (NSDateFormatter *)dateFormatter;
+ (NSValueTransformer *)commonDateValueTransformer;

@end
