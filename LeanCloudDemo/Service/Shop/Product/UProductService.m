//
//  UProductService.m
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductService.h"
#import "UProductSimpleModel.h"
#import "UProductSummaryModel.h"
#import "UProductDetailModel.h"

@implementation UProductService

+ (void)getConvertGoodsList:(NSString *)categoryId success:(void (^)(NSDictionary *))successResult failure:(UErrorBlock)failureResult
{
  NSString *listDataUrlStr = [NSString stringWithFormat:@"%@/products.json?where[category1_id]=%@",UMOBILE_URL,categoryId];
  
  [[UHttpClient sharedClient] GETRequestWithPath:listDataUrlStr success:^(id responseObject) {
    
    NSArray *productListArr = [responseObject objectForKey:@"data"];
    
    NSMutableArray *productModelArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i< [productListArr count]; i++) {
      
      UProductSimpleModel *productSimpleModel = [MTLJSONAdapter modelOfClass:UProductSimpleModel.class  fromJSONDictionary:productListArr[i] error:nil];
      [productModelArr addObject:productSimpleModel];
    }
    
    NSNumber *count = [responseObject objectForKey:@"count"];
    
    NSDictionary *products_facet = [responseObject objectForKey:@"products_facet"];
    
    NSDictionary *productListInfoDic = [NSDictionary dictionaryWithObjectsAndKeys:count, @"count", productModelArr, @"productModelArray", products_facet, @"products_facet", nil];
    
    successResult(productListInfoDic);
  } failure:^(NSError *error) {
    ;
  }];
}

+ (void)getGoodsInfo:(NSArray *)idsArray success:(void (^)(NSMutableArray *productArray))successResult failure:(UErrorBlock)failureResult
{
  NSString *idsStr = [idsArray componentsJoinedByString:@","];
  NSString *url = [NSString stringWithFormat:@"%@/products.json?response=summary&ids=%@",UMOBILE_URL,idsStr];
  
  [[UHttpClient sharedClient] GETRequestWithPath:url parameters:nil success:^(id responseObject) {
    
    NSMutableArray *summaryModelArray = [[NSMutableArray alloc] initWithCapacity:[responseObject count]];
    
    for (NSInteger i = 0; i < [responseObject count]; i++) {
      UProductSummaryModel *summaryModel = [MTLJSONAdapter modelOfClass:UProductSummaryModel.class fromJSONDictionary:responseObject[i] error:nil];
      [summaryModelArray addObject:summaryModel];
    }
    
    successResult(summaryModelArray);
    
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getGoodDetailInfo:(NSNumber *)productId success:(void (^)(UProductDetailModel  *detailModel))successResult failure:(UErrorBlock)failureResult
{
  NSString *urlStr = [NSString stringWithFormat:@"%@/products/%@.json",UMOBILE_URL,productId];  //测试视频 [NSNumber numberWithInt:73812] UMOBILE_URL

  [[UHttpClient sharedClient] GETRequestWithPath:urlStr parameters:nil success:^(id responseObject) {
    
    UProductDetailModel *detailModel = [MTLJSONAdapter modelOfClass: UProductDetailModel.class fromJSONDictionary:responseObject error:nil];
    
    successResult(detailModel);
    
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getSimilarGoods:(NSNumber *)productId succss:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult {
  NSString *urlStr = [NSString stringWithFormat:@"%@/api/products/view_units.json?product_id=%@", USIMILAR_URL, productId];
  
  [HttpClient GETRequestWithPath:urlStr success:^(id responseObject) {
    NSArray *infos = responseObject[@"product_infos"];
    NSMutableArray *ids = [NSMutableArray arrayWithCapacity:infos.count];
    for (NSDictionary *dict in infos) {
      NSNumber *idNumber = dict[@"id"];
      [ids addObject:idNumber];
    }
    successResult([ids copy]);
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getSellWellGoodsWithSuccss:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult; {
  NSString *urlStr = [NSString stringWithFormat:@"%@/products.json?where[recommend]=featured&where[unsold_count][gt]=0", UMOBILE_URL];
  
  [HttpClient GETRequestWithPath:urlStr success:^(id responseObject) {
    NSArray *infos = responseObject[@"data"];
    NSMutableArray *ids = [NSMutableArray arrayWithCapacity:infos.count];
    for (NSDictionary *dict in infos) {
      NSNumber *idNumber = dict[@"id"];
      [ids addObject:idNumber];
    }
    successResult([ids copy]);
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getGoodsWithCategory2Id:(NSNumber *)category2Id order:(NSString *)order success:(void (^)(NSArray *, NSString *))successResult failure:(UErrorBlock)failureResult {
  NSString *orderStr = @"";
  if (StringNotEmpty(order)) {
    orderStr = [NSString stringWithFormat:@"&%@", order];
  }
  
  NSString *urlStr = [NSString stringWithFormat:@"%@/products.json?filter=true&where[category2_id]=%@%@", UMOBILE_URL, category2Id, orderStr];
  
  [HttpClient GETRequestWithPath:urlStr success:^(id responseObject) {
    NSArray *simples = responseObject[@"data"];
    NSMutableArray *productIds = [NSMutableArray arrayWithCapacity:simples.count];
    for (NSDictionary *dict in simples) {
      NSNumber *productId = dict[@"id"];
      [productIds addObject:productId];
    }
    
    NSString *filterStr = responseObject[@"products_facet"];
    
    [UProductService getGoodsInfo:productIds success:^(NSMutableArray *productArray) {
      if (successResult) { successResult(productArray, filterStr); }
    } failure:^(NSError *error) {
      ULog(@"%@",error.localizedDescription);
    }];
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getGoodsWithCategory1Id:(NSNumber *)category1Id order:(NSString *)order success:(void (^)(NSArray *, NSString *))successResult failure:(UErrorBlock)failureResult {
  NSString *orderStr = @"";
  if (StringNotEmpty(order)) {
    orderStr = [NSString stringWithFormat:@"&%@", order];
  }
  
  //不显示售光的，加筛选字段
  NSString *urlStr = [NSString stringWithFormat:@"%@/products.json?filter=true&where[unsold_count][gt]=0&where[category1_id]=%@%@", UMOBILE_URL, category1Id, orderStr];
  
  [HttpClient GETRequestWithPath:urlStr success:^(id responseObject) {
    NSArray *simples = responseObject[@"data"];
    NSMutableArray *productIds = [NSMutableArray arrayWithCapacity:simples.count];
    for (NSDictionary *dict in simples) {
      NSNumber *productId = dict[@"id"];
      [productIds addObject:productId];
    }
    
    NSString *filterStr = responseObject[@"products_facet"];
    
    [UProductService getGoodsInfo:productIds success:^(NSMutableArray *productArray) {
      if (successResult) { successResult(productArray, filterStr); }
    } failure:^(NSError *error) {
      ULog(@"%@",error.localizedDescription);
    }];
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getGoodsWithCustomQueryUrl:(NSString *)urlStr success:(void (^)(NSArray *, NSString *))successResult failure:(UErrorBlock)failureResult {
  NSString *url = [NSString stringWithFormat:@"%@/products.json?filter=true&where[unsold_count][gt]=0%@", UMOBILE_URL, urlStr];
  ULog(@"goods url: %@", url);
  [HttpClient GETRequestWithPath:url success:^(id responseObject) {
    NSArray *simples = responseObject[@"data"];
    NSMutableArray *productIds = [NSMutableArray arrayWithCapacity:simples.count];
    for (NSDictionary *dict in simples) {
      NSNumber *productId = dict[@"id"];
      [productIds addObject:productId];
    }
    
    NSString *filterStr = responseObject[@"products_facet"];
    
    [UProductService getGoodsInfo:productIds success:^(NSMutableArray *productArray) {
      if (successResult) { successResult(productArray, filterStr); }
    } failure:^(NSError *error) {
      ULog(@"%@",error.localizedDescription);
    }];
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

@end
