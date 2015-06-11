//
//  ProductImageModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-16.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBaseModel.h"

@interface UProductImageModel : UBaseModel<MTLJSONSerializing>

@property (strong,nonatomic) NSNumber *imageId;

@property (strong,nonatomic) NSString *imageUrl;

@property (strong,nonatomic) NSString *imageDescription;

@end
