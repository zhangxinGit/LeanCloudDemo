//
//  UCategorySimpleModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBaseModel.h"

@interface UCategorySimpleModel : UBaseModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *categoryId;  //分类ID

@property (nonatomic, strong) NSDate   *updated_at;  //分类更新时间

@end
