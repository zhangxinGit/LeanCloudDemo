//
//  UCategoryService.h
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  分类数据请求服务
 */
@interface UCategoryService : NSObject

/**
 *  请求分类ID数组数据
 */
+ (void)getCategoryList:(id)sender success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据分类的ID数组请求得到分类模型数组数据
 *  @categoryArray 成功返回商品Model数组
 *  @responseArray
 */
+ (void)getCategoryInfo:(NSArray *)idsArray success:(void (^)(NSMutableArray *categoryArray))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据分类的ID请求得到分类详情模型数据
 *  @UCategoryDetailModel 成功返回分类Model
 */
+ (void)getCategoryDetailInfo:(NSString *)categoryId success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult;

+ (void)getFemaleCategoriesWithSuccess:(void (^)(NSArray *categoryList))success failure:(UErrorBlock)failure;
+ (void)getMaleCategoriesWithSuccess:(void (^)(NSArray *categoryList))success failure:(UErrorBlock)failure;
+ (void)getHomeLifeCategoriesWithSuccess:(void (^)(NSArray *categoryList))success failure:(UErrorBlock)failure;
+ (void)getEastLuxuryCategoriesWithSuccess:(void (^)(NSArray *categoryList))success failure:(UErrorBlock)failure;

@end
