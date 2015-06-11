//
//  UBrandSimpleModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBaseModel.h"

@interface UBrandSimpleModel : UBaseModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber *brandId; //品牌ID
@property (strong, nonatomic) NSDate *update_at; //品牌更新时间

@end
