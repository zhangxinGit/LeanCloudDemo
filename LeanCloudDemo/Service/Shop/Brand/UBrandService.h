//
//  UBrandService.h
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  品牌数据请求服务
 */
@interface UBrandService : NSObject

/**
 *  品牌的Simple数据返回所有品牌的ID数组
 */
+ (void)getBrandSimpleInfoWithSuccess:(void(^)(NSMutableArray *brandIds))successResult failure:(UErrorBlock)failureResult;

/**
 *  请求所有品牌数据
 */
+ (void) getAllBrands:(id)sender success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据品牌所属字母请求得到品牌ID数组数据
 */
+ (void) getBrandsWithIntial:(NSString *)initial success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据品牌的ID数组请求得到品牌模型数组数据
 *  @brandArray 成功返回品牌Model数组
 *  @responseArray
 */
+ (void)getBrandsInfo:(NSArray *)idsArray success:(void (^)(NSMutableArray *brandArray))successResult failure:(UErrorBlock)failureResult;

/**
 *  根据品牌的ID请求得到品牌详情模型数据
 *  @UBrandDetailModel 成功返回品牌Model
 */
+ (void)getBrandDetailInfo:(NSNumber *)brandId success:(void (^)(id result))successResult failure:(UErrorBlock)failureResult;

@end
