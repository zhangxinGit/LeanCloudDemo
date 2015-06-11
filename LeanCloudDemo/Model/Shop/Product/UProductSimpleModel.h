//
//  UProductSimpleModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBaseModel.h"

@interface UProductSimpleModel : UBaseModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber *productId; //商品ID

@property (strong, nonatomic) NSDate   *update_at; //更新时间

@end
