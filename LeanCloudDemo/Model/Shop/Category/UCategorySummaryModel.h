//
//  UCategorySummaryModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UCategorySimpleModel.h"

#define CategoryNewId (-1)

@interface UCategorySummaryModel : UCategorySimpleModel

@property (nonatomic, strong) NSString *female;      //女性

@property (nonatomic, strong) NSString *male;        //男性

@property (nonatomic, strong) NSString *name;        //名称

@property (nonatomic, strong) NSNumber *order;       //排序

@property (nonatomic, strong) NSNumber *parent_id;   //父分类ID

@property (nonatomic, strong) NSMutableArray  *children;

- (BOOL)haveChildren;

@end
