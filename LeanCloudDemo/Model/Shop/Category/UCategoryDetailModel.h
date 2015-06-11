//
//  UCategoryDetailModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UCategorySummaryModel.h"

@interface UCategoryDetailModel : UCategorySummaryModel

@property (nonatomic, strong) NSString *ranges;             //分类范围

@property (nonatomic, strong) NSDate   *created_at;         //分类创建时间

@property (nonatomic, strong) NSString *measure_properties; //尺码说明属性

@property (nonatomic, strong) NSString *measure_pic;        //尺码说明图片链接

@end
