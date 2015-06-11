//
//  UProductDetailViewModel.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductDetailViewModel.h"
#import "UProductService.h"
//#import "URetailCartService.h"
//#import "UFavoriteService.h"

@interface UProductDetailViewModel ()

@end

@implementation UProductDetailViewModel

- (instancetype)initWithSummaryProduct:(UProductSummaryModel *)productSummaryModel {
  self = [super init];
  if (self) {
    self.summaryProduct = productSummaryModel;
  }
  return self;
}

- (void)setSummaryProduct:(UProductSummaryModel *)summaryProduct {
  _summaryProduct = summaryProduct;
  
  self.priceText = [NSString stringWithFormat:@"¥%@", summaryProduct.discount];
  
  if (StringNotEmpty(summaryProduct.label)) {
    self.productSubject = [NSString stringWithFormat:@"【 %@ 】 %@", summaryProduct.label, summaryProduct.name];
  } else {
    self.productSubject = summaryProduct.name;
  }
  
  if (summaryProduct.percent_text) {
    self.discountText = [NSString stringWithFormat:@"%@折", summaryProduct.percent_text];
  } else {
    self.brandName = [NSString stringWithFormat:@"%@", summaryProduct.brand_name];
  }
  
  if (StringNotEmpty(summaryProduct.color_name)) {
    self.colorText = [NSString stringWithFormat:@"颜色 : %@", summaryProduct.color_name];
  }
  
  self.sizeText = @"尺码 :";
  [self checkSize];
}

- (void)fetchCompleteProductInfomationWithSuccess:(dispatch_block_t)success failure:(dispatch_block_t)failure {
  [UProductService getGoodDetailInfo:self.summaryProduct.productId success:^(UProductDetailModel *detailModel) {
    self.detailProduct = detailModel;
    [self loadProperties];
    if (success) success();
  } failure:^(NSError *error) {
    
  }];
  
//  [UFavoriteService fetchHasFavoriteWithProductId:self.summaryProduct.productId success:^(BOOL hasFavor, NSNumber *favorId) {
//    self.summaryProduct.favor_id = favorId;
//    self.isFavorite = hasFavor;
//  } failure:nil];
}

- (void)submitToCartWithSuccess:(dispatch_block_t)success failure:(UErrorBlock)failure failureMessage:(NSString *__autoreleasing *)message {
  if (self.measureSize.allKeys.count == 1 && StringEqual([self.measureSize.allKeys firstObject], @"")) {
    self.detailProduct.select_measure = @"";
  }
  
  if (self.detailProduct.select_measure == nil) {
    if (self.measureSize.allKeys.count == 0) {
      *message = @"当前商品已售光";
    } else {
      *message = @"请先选择尺码";
    }
    return;
  }
  
//  [URetailCartService createCartWithProductId:self.detailProduct.productId andMeasure:self.detailProduct.select_measure success:^{
//    if (success) success();
//  } failure:^(NSError *error) {
//    *message = @"添加到购物车失败，请稍后再试";
//    if (failure) failure(error);
//  }];
}

- (void)loadProperties {
  self.productDescription = [NSString stringWithFormat:@"%@\n\n编号 : %@", self.detailProduct.productDescription, self.detailProduct.productId];
  self.brandDescription = self.detailProduct.brand[@"description"];
  self.productImages = self.detailProduct.imagesArray;
  self.productVideo = self.detailProduct.videosArray;
  [self checkColors];
  self.valuesList = self.detailProduct.valuesArray;
  [self loadSimilarProducts];
}

- (void)checkColors {
  NSMutableArray *colors = [NSMutableArray arrayWithArray:self.detailProduct.relate_productsArray];
  [colors addObject:self.detailProduct];
  self.colors = colors;
}

- (void)checkSize {
  NSDictionary *measures = self.summaryProduct.measures_unsold_count;
  if (measures != nil) {
    NSMutableDictionary *sizes = [NSMutableDictionary dictionaryWithDictionary:measures];
    for (NSString *key in sizes.allKeys) {
      NSInteger count = [sizes[key] integerValue];
      if (count == 0) {
        [sizes removeObjectForKey:key];
      }
    }
    self.measureSize = [sizes copy];
  }
}

- (void)loadSimilarProducts {
  [UProductService getSimilarGoods:self.detailProduct.productId succss:^(NSArray *productIds) {
    [UProductService getGoodsInfo:productIds success:^(NSMutableArray *productArray) {
      self.similarProducts = productArray;
    } failure:nil];
  } failure:nil];
}

- (void)favoriteCurrentProductWithSuccess:(dispatch_block_t)success failure:(UErrorBlock)failure {
//  [UFavoriteService createFavoriteWithProductId:self.summaryProduct.productId success:^{
//    self.isFavorite = YES;
//    if (success) success();
//  } failure:failure];
}

- (void)cancelFavoriteCurrentProductWithSuccess:(dispatch_block_t)success failure:(UErrorBlock)failure {
//  [UFavoriteService deleteFavoriteWithId:self.summaryProduct.favor_id success:^{
//    self.isFavorite = NO;
//    if (success) success();
//  } failure:failure];
}

- (void)generateSummaryProduct {
//  NSDictionary *jsonDict = @{
//    @"brand_id": @93,
//    @"brand_name": @"Porsche Design",
//    @"category1_id": @45,
//    @"color_name": @"灰白色",
//    @"discount": @3240,
//    @"id": @2979853,
//    @"label": @"",
//    @"major_pic": @"/image/auction/product/002/979/853/major_pic/a5b4017a2dd492f83fcdddfe28149c3d.jpg",
//    @"mall_id": @3,
//    @"measures_unsold_count": @"{\"42.5\":0}",
//    @"minimum_price": [NSNull null],
//    @"multibuy_id": [NSNull null],
//    @"name": @"Porsche Design Adidas联名款灰白色G00114 Racer简约男士运动休闲鞋 ",
//    @"percent_text": [NSNull null],
//    @"point": @0,
//    @"prefix": @"",
//    @"price": @4980,
//    @"published": @true,
//    @"sell_current": [NSNull null],
//    @"target": @"男",
//    @"unsold_count": @0,
//    @"updated_at": @"2014-06-23T17:43:16+08:00",
//    @"zoom": [NSNull null]
//    };
  
  NSDictionary *jsonDict2 = @{
    @"brand_id": @55,
    @"brand_name": @"Emporio Armani",
    @"category1_id": @108,
    @"color_name": @"灰绿色",
    @"discount": @2899,
    @"id": @70287,
    @"label": @"剁手节男装场",
    @"major_pic": @"/image/auction/product/000/070/287/major_pic/c45cace5.jpg",
    @"mall_id": @1,
    @"measures_unsold_count": @"{\"32\":0,\"33\":0,\"34\":1,\"35\":1,\"36\":1}",
    @"minimum_price": [NSNull null],
    @"multibuy_id": [NSNull null],
    @"name": @"Emporio Armani灰绿色棉做旧设计男士牛仔裤",
    @"percent_text": [NSNull null],
    @"point": @0,
    @"prefix": @"",
    @"price": @3700,
    @"published": @true,
    @"sell_current": [NSNull null],
    @"target": @"男",
    @"unsold_count": @3,
    @"updated_at": @"2015-03-15T00:28:11+08:00",
    @"zoom": [NSNull null]
    };
  
  UProductSummaryModel *summaryProduct = [MTLJSONAdapter modelOfClass:UProductSummaryModel.class fromJSONDictionary:jsonDict2 error:nil];
  self.summaryProduct = summaryProduct;
}

@end
