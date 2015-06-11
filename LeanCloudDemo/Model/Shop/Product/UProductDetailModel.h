//
//  UProductDetailModel.h
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UProductSummaryModel.h"
#import "UBrandDetailModel.h"
#import "UCategoryDetailModel.h"
#import "UProductMallModel.h"

@interface UProductDetailModel : UProductSummaryModel

@property (strong, nonatomic) NSNumber *category2_id;               //商品二级分类ID
@property (strong, nonatomic) NSString *match_product_ids;          //商品匹配的商品ID
@property (strong, nonatomic) NSString *relate_product_ids;         //商品相关的商品ID
@property (strong, nonatomic) NSString *video_id;                   //商品视频ID
@property (strong, nonatomic) NSString *image_id;                   //商品图片ID
@property (strong, nonatomic) NSString *created_at;                 //商品创建时间
@property (strong, nonatomic) NSString *measureTable;               //商品尺码说明信息字符串
@property (strong, nonatomic) NSMutableArray *measureTableArray;    //商品尺码说明信息数组
@property (strong, nonatomic) NSString *measureStyle;               //商品尺码风格
@property (strong, nonatomic) NSString *measureDescription;         //商品尺码描述
@property (strong, nonatomic) NSString *color_pic;                  //商品颜色图片链接
@property (strong, nonatomic) NSString *recommend;                  //商品推荐标签
@property (strong, nonatomic) NSString *productDescription;         //商品描述
@property (strong, nonatomic) NSString *u_upper_limit;              //商品U上限
@property (strong, nonatomic) NSString *u_lower_limit;              //商品U下限

@property (strong, nonatomic) NSDictionary *brand;                  //商品品牌信息只接收原始数据

@property (strong, nonatomic) NSDictionary *category1;              //商品一级分类信息只接收原始数据
@property (nonatomic, strong) UCategoryDetailModel *category1Model; //商品一级分类信息Model

@property (strong, nonatomic) NSDictionary *category2;              //商品二级分类信息只接收原始数据
@property (nonatomic, strong) UCategoryDetailModel *category2Model; //商品二级分类信息Model

@property (strong, nonatomic) NSDictionary *mall;                   //商品卖场信息Model只接收原始数据
@property (strong, nonatomic) UProductMallModel *mallModel;         //商品卖场信息Model

@property (strong, nonatomic) NSArray *relate_products;             //商品相关商品数组只接收原始数据
@property (strong, nonatomic) NSMutableArray *relate_productsArray; //商品相关商品数组包含商品SummaryModel

@property (strong, nonatomic) NSArray *videos;                      //商品视频信息数组包含视屏只接收原始数据
@property (strong, nonatomic) NSMutableArray *videosArray;          //商品视频信息数组包含视屏

@property (strong, nonatomic) NSArray *values;                      //商品规格参数数组包含参数只接收原始数据
@property (strong, nonatomic) NSMutableArray *valuesArray;          //商品规格参数数组包含参数Model

@property (strong, nonatomic) NSArray *images;                      //商品轮换系列图片数组包只接收原始数据
@property (strong, nonatomic) NSMutableArray *imagesArray;          //商品轮换系列图片数组包含图片Model

@end
