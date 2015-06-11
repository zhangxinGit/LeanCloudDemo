//
//  UProductSizeViewModel.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//  尺寸视图ViewModel

#import "UBaseViewModel.h"
#import "UProductDetailModel.h"

@interface UProductSizeViewModel : UBaseViewModel
//尺码说明尺码及属性值数组
@property (strong, nonatomic) NSArray *measureTableArray;
//尺码说明属性数组
@property (strong, nonatomic) NSMutableArray *measure_propertiesArray;
//尺码说明图片链接
@property (strong, nonatomic) NSString *measure_pic;

-(instancetype)initWithDetailProduct:(UProductDetailModel *)productDetailModel;

@end
