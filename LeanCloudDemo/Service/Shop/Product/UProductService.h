//
//  UProductService.h
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UProductDetailModel.h"

/**
 *  商品数据请求服务
 */
@interface UProductService : NSObject

/**
 *  根据分类ID请求商品ID数组数据
 */
+ (void)getConvertGoodsList:(NSString *)categoryId success:(void(^)(NSDictionary *response))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据商品的ID数组请求得到商品模型数组数据
 *  @productArray 成功返回商品Model数组
 *  @responseArray
 */
+ (void)getGoodsInfo:(NSArray *)idsArray success:(void(^)(NSMutableArray *productArray))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据商品的ID请求得到商品详情模型数据
 *  @UProductDetailModel 成功返回商品Model
 */
+ (void)getGoodDetailInfo:(NSNumber *)productId success:(void (^)(UProductDetailModel *detailModel))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据商品的ID数组请求得到同类型商品ID数据
 *  @productIds 成功返回商品ID数组
 */
+ (void)getSimilarGoods:(NSNumber *)productId succss:(void (^)(NSArray *productIds))successResult failure:(UErrorBlock)failureResult;

/*
 *  搜索畅销商品数组
 *  @productIds 成功返回商品ID数组
 */
+ (void)getSellWellGoodsWithSuccss:(void (^)(NSArray *productIds))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据二级分类的ID和排序条件获取Summary商品数组。
 *  如果order为空则为默认排序。
 */
+ (void)getGoodsWithCategory2Id:(NSNumber *)category2Id order:(NSString *)order success:(void (^)(NSArray *productArray, NSString *filterStr))successResult failure:(UErrorBlock)failureResult;

/*
 *  根据一级分类的ID和排序条件获取Summary商品数组。
 *  如果order为空则为默认排序。
 
 */
+ (void)getGoodsWithCategory1Id:(NSNumber *)category1Id order:(NSString *)order success:(void (^)(NSArray *productArray, NSString *filterStr))successResult failure:(UErrorBlock)failureResult;

+ (void)getGoodsWithCustomQueryUrl:(NSString *)urlStr success:(void (^)(NSArray *productArray, NSString *filterStr))successResult failure:(UErrorBlock)failureResult;


@end
