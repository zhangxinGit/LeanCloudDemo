//
//  UBrandDetailModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBrandSummaryModel.h"

@interface UBrandDetailModel : UBrandSummaryModel

@property (nonatomic, strong) NSString  *abbreviation;        //品牌
@property (nonatomic, strong) NSString  *displayDescription;  //品牌描述
@property (nonatomic, strong) NSString  *recommend;           //品牌推荐
@property (nonatomic, strong) NSString  *title;               //品牌标题
@property (nonatomic, strong) NSString  *keywords;            //品牌关键字
@property (nonatomic, assign) BOOL       introduced;          //品牌介绍
@property (nonatomic, strong) NSString  *shop_link;           //品牌购买链接
@property (nonatomic, strong) NSString  *genre;               //品牌
@property (nonatomic, strong) NSString  *summary;             //品牌
@property (nonatomic, strong) NSString  *pronunciation;       //品牌
@property (nonatomic, strong) NSString  *link;                //品牌链接
@property (nonatomic, strong) NSString  *material;            //品牌材质
@property (nonatomic, strong) NSNumber  *year;
@property (nonatomic, strong) NSNumber  *country_id;          //品牌所属国家
@property (nonatomic, strong) NSString  *sepcial_product_ids; //品牌特殊商品
@property (nonatomic, strong) NSDictionary *country;

@end
