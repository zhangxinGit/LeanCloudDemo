//
//  UProductSummaryModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UProductSimpleModel.h"

@interface UProductSummaryModel : UProductSimpleModel

@property (strong, nonatomic) NSNumber *brand_id;                 //商品对应的品牌ID
@property (strong, nonatomic) NSString *brand_name;               //商品对应的品牌名称
@property (strong, nonatomic) NSNumber *category1_id;             //商品所属一级分类ID
@property (strong, nonatomic) NSString *color_name;               //商品颜色名称
@property (strong, nonatomic) NSNumber *discount;                 //商品价格
@property (strong, nonatomic) NSString *label;                    //商品标签
@property (strong, nonatomic) NSString *major_pic;                //商品图片地址
@property (strong, nonatomic) NSNumber *mall_id;                  //商品所属卖场ID
@property (strong, nonatomic) NSMutableDictionary *measures_unsold_count;//商品未售完尺码字典
@property (strong, nonatomic) NSNumber *minimum_price;            //商品最低价
@property (strong, nonatomic) NSNumber *multibuy_id;              //商品的连拍ID
@property (strong, nonatomic) NSString *name;                     //商品名称
@property (strong, nonatomic) NSString *percent_text;             //
@property (strong, nonatomic) NSNumber *point;                    //
@property (strong, nonatomic) NSString *prefix;                   //前缀
@property (strong, nonatomic) NSNumber *price;                    //原价
@property (assign) BOOL                 published;                //商品是否已经发布
@property (strong, nonatomic) NSNumber *sell_current;             //
@property (strong, nonatomic) NSString *target;                   //商品性别 男性 女性 中性
@property (strong, nonatomic) NSNumber *unsold_count;             //商品的未售完数目
@property (strong, nonatomic) NSNumber *zoom;

@property (nonatomic, strong) NSString *select_measure;           //选择的尺寸
@property (nonatomic, strong) NSNumber *cart_id;
@property (nonatomic, assign) BOOL isExclusive;
@property (nonatomic, assign) BOOL isSoldOut;

@property (nonatomic, strong) NSNumber *favor_id;                 //收藏id

@end