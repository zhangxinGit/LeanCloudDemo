//
//  UProductValueModel.h
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBaseModel.h"

@interface UProductValueModel : UBaseModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber *valueId;           //材质ID

@property (strong, nonatomic) NSString *content;           //材质内容

@property (strong, nonatomic) NSString *attribute_name;    //材质属性名称

@end
