//
//  UProductColorModel.h
//  UZhong
//
//  Created by jack on 15-3-25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBaseModel.h"

@interface UProductColorModel : UBaseModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber *colorId;

@property (strong, nonatomic) NSString *color_name;

@property (strong, nonatomic) NSString *color_pic;

@property (strong, nonatomic) NSString *name;

@end
