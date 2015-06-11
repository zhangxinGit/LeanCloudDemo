//
//  UBrandSummaryModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBrandSimpleModel.h"

@interface UBrandSummaryModel : UBrandSimpleModel

@property (strong, nonatomic) NSString *chineseName;  //品牌中文名

@property (strong, nonatomic) NSString *foreignName;  //品牌英文名

@property (strong, nonatomic) NSString *initial;      //品牌所属字母

@property (strong, nonatomic) NSNumber *order;        //品牌顺序

@property (strong, nonatomic) NSString *picUrl;       //品牌图片链接

@property (strong, nonatomic) NSString *name;         //订单管理的品牌名称

@property (nonatomic, strong) NSNumber *favor_id;

@end
