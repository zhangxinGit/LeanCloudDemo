//
//  UHotBrandModel.h
//  UZhong
//
//  Created by Mac on 15-5-4.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBaseModel.h"

@interface UHotBrandModel : UBaseModel<MTLJSONSerializing>

//品牌ID
@property (strong, nonatomic) NSNumber *brandId;
//品牌名称
@property (strong, nonatomic) NSString *name;
//品牌Logo图片
@property (strong, nonatomic) NSString *pic;

@end
