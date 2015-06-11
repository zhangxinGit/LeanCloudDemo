//
//  UBrandService.m
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBrandService.h"
#import "UBrandSimpleModel.h"
#import "UBrandSummaryModel.h"
#import "UBrandDetailModel.h"

@implementation UBrandService

+ (void) getAllBrands:(id)sender success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult
{
  NSArray *letterArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
  
  NSMutableDictionary *allBrandsDic = [NSMutableDictionary dictionaryWithCapacity:letterArray.count];
  
  for (NSInteger i = 0; i < [letterArray count]; i++) {
    
    NSString *listDataUrlStr = [NSString stringWithFormat:@"%@/brands.json?where[initial]=%@",UMOBILE_URL,letterArray[i]];
    
    [[UHttpClient sharedClient] GETRequestWithPath:listDataUrlStr success:^(id responseObject) {
      
      NSArray *brandListArr = [responseObject objectForKey:@"data"];
      
      NSMutableArray *brandModelArr = [NSMutableArray array];
      
      for (NSInteger i = 0; i< [brandListArr count]; i++) {
        
        UBrandSimpleModel *brandSimpleModel = [MTLJSONAdapter modelOfClass:UBrandSimpleModel.class  fromJSONDictionary:brandListArr[i] error:nil];
        [brandModelArr addObject:brandSimpleModel];
      }
      
      [allBrandsDic setObject:brandModelArr forKey:letterArray[i]];
      
    } failure:^(NSError *error) {
      ;
    }];
  }
  
}

+ (void) getBrandsWithIntial:(NSString *)initial success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult
{
  NSString *listDataUrlStr = [NSString stringWithFormat:@"%@/brands.json?where[initial]=%@",UMOBILE_URL,initial];
  
  [[UHttpClient sharedClient] GETRequestWithPath:listDataUrlStr success:^(id responseObject) {
    
    NSArray *brandListArr = [responseObject objectForKey:@"data"];
    
    NSMutableArray *brandModelArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i< [brandListArr count]; i++) {
      
      UBrandSimpleModel *brandSimpleModel = [MTLJSONAdapter modelOfClass:UBrandSimpleModel.class  fromJSONDictionary:brandListArr[i] error:nil];
      [brandModelArr addObject:brandSimpleModel];
    }
    
    successResult(brandModelArr);
    
  } failure:^(NSError *error) {
    ;
  }];
  
}

+ (void)getBrandSimpleInfoWithSuccess:(void(^)(NSMutableArray *brandIds))successResult failure:(UErrorBlock)failureResult
{
  NSString *url = [NSString stringWithFormat:@"%@/brands.json",UMOBILE_URL];
  
  [[UHttpClient sharedClient] GETRequestWithPath:url success:^(id responseObject) {
    
    NSArray *brandArray = responseObject[@"data"];
    
    NSMutableArray *brandIds = [NSMutableArray array];
    
    for (id obj in brandArray) {
      [brandIds addObject:obj[@"id"]];
    }
    successResult(brandIds);
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getBrandsInfo:(NSArray *)idsArray success:(void (^)(NSMutableArray *brandArray))successResult failure:(UErrorBlock)failureResult
{
  NSString *idsStr = [idsArray componentsJoinedByString:@","];
  NSString *url = [NSString stringWithFormat:@"%@/brands.json?response=summary&ids=%@",UMOBILE_URL,idsStr];
  
  [[UHttpClient sharedClient] GETRequestWithPath:url success:^(id responseObject) {
    
    NSMutableArray *summaryModelArray = [[NSMutableArray alloc] initWithCapacity:[responseObject count]];
    
    for (NSInteger i = 0; i < [responseObject count]; i++) {
      UBrandSummaryModel *summaryModel = [MTLJSONAdapter modelOfClass:UBrandSummaryModel.class fromJSONDictionary:responseObject[i] error:nil];
      [summaryModelArray addObject:summaryModel];
    }
    
    successResult(summaryModelArray);
    
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

+ (void)getBrandDetailInfo:(NSNumber *)brandId success:(void (^)(id result))successResult failure:(UErrorBlock)failureResult;
{
  NSString *urlStr = [NSString stringWithFormat:@"%@/brands/%@.json",UMOBILE_URL,brandId];
  
  [[UHttpClient sharedClient] GETRequestWithPath:urlStr parameters:nil success:^(id responseObject) {
    
    UBrandDetailModel *detailModel = [MTLJSONAdapter modelOfClass: UBrandDetailModel.class fromJSONDictionary:responseObject error:nil];
    
    successResult(detailModel);
    
  } failure:^(NSError *error) {
    ULog(@"%@",error.localizedDescription);
  }];
}

@end
