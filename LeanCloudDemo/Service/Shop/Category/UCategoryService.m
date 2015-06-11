//
//  UCategoryService.m
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UCategoryService.h"
#import "UCategorySimpleModel.h"
#import "UCategorySummaryModel.h"
#import "UCategoryDetailModel.h"

@implementation UCategoryService

+ (void)getCategoryList:(id)sender success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult
{
  NSString *listDataUrlStr = [NSString stringWithFormat:@"%@/categories.json",UMOBILE_URL];
  [[UHttpClient sharedClient] GETRequestWithPath:listDataUrlStr success:^(id responseObject) {
    
    NSArray *categoryListArr = [responseObject objectForKey:@"data"];
    
    NSMutableArray *categoryModelArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i< [categoryListArr count]; i++) {
      
      UCategorySimpleModel *categorySimpleModel = [MTLJSONAdapter modelOfClass:UCategorySimpleModel.class  fromJSONDictionary:categoryListArr[i] error:nil];
      [categoryModelArr addObject:categorySimpleModel];
    }
    
    successResult(categoryModelArr);
    
  } failure:failureResult];
  
}

+ (void)getCategoryInfo:(NSArray *)idsArray success:(void (^)(NSMutableArray *categoryArray))successResult failure:(UErrorBlock )failureResult
{
  NSString *idsStr = [idsArray componentsJoinedByString:@","];
  NSString *url = [NSString stringWithFormat:@"%@/categories.json?response=summary&ids=%@",UMOBILE_URL,idsStr];
  
  [[UHttpClient sharedClient] GETRequestWithPath:url parameters:nil success:^(id responseObject) {
    
    NSMutableArray *summaryModelArray = [[NSMutableArray alloc] initWithCapacity:[responseObject count]];
    
    for (NSInteger i = 0; i < [responseObject count]; i++) {
      
      UCategorySummaryModel *summaryModel = [MTLJSONAdapter modelOfClass:UCategorySummaryModel.class fromJSONDictionary:responseObject[i] error:nil];
      [summaryModelArray addObject:summaryModel];
    }
    
    successResult(summaryModelArray);
    
  } failure:failureResult];
}

+ (void)getCategoryDetailInfo:(NSString *)categoryId success:(void (^)(NSArray *))successResult failure:(UErrorBlock)failureResult;
{
  NSString *urlStr = [NSString stringWithFormat:@"%@/categories/%@.json",UMOBILE_URL,categoryId];
  
  [[UHttpClient sharedClient] GETRequestWithPath:urlStr parameters:nil success:^(id responseObject) {
    
    UCategoryDetailModel *detailModel = [MTLJSONAdapter modelOfClass: UCategoryDetailModel.class fromJSONDictionary:responseObject error:nil];
    
    NSArray *detailModelArray = [NSArray arrayWithObjects:detailModel, nil];
    
    successResult(detailModelArray);
    
  } failure:failureResult];
}

+ (void)getFemaleCategoriesWithSuccess:(void (^)(NSArray *))success failure:(UErrorBlock)failure {
  NSString *path = [NSString stringWithFormat:@"%@/categories.json?response=simple&where[female]=true", UMOBILE_URL];
  
  [UCategoryService getSummaryCategoriesWithPath:path parentId:@1 success:^(NSMutableArray *categoryArray) {
    UCategorySummaryModel *homeLife = nil;
    UCategorySummaryModel *eastLuxury = nil;
    UCategorySummaryModel *outdoor = nil;
    for (UCategorySummaryModel *category in categoryArray) {
      if ([category.categoryId integerValue] == 103) {
        homeLife = category;
      } else if ([category.categoryId integerValue] == 203) {
        eastLuxury = category;
      } else if ([category.categoryId integerValue] == 193) {
        outdoor = category;
      } else if ([category.categoryId integerValue] == 336) {
        //U质甄选
        ClearObj(category.children);
      } else {
        UCategorySummaryModel *allCate = [UCategorySummaryModel new];
        allCate.name = [NSString stringWithFormat:@"所有%@", category.name];
        allCate.categoryId = @([category.categoryId integerValue]);
        
        [category.children insertObject:allCate atIndex:0];
      }
    }
    
    [categoryArray removeObject:homeLife];
    [categoryArray removeObject:eastLuxury];
    [categoryArray removeObject:outdoor];
    
    UCategorySummaryModel *new = [[UCategorySummaryModel alloc] init];
    new.categoryId = @(CategoryNewId);
    new.name = @"女士最新";

    [categoryArray insertObject:new atIndex:0];
    
    if (success) {
      success(categoryArray);
    }
  } failure:failure];
}

+ (void)getMaleCategoriesWithSuccess:(void (^)(NSArray *))success failure:(UErrorBlock)failure {
  NSString *path = [NSString stringWithFormat:@"%@/categories.json?response=simple&where[male]=true", UMOBILE_URL];
  
  [UCategoryService getSummaryCategoriesWithPath:path parentId:@1 success:^(NSMutableArray *categoryArray) {
    UCategorySummaryModel *homeLife = nil;
    UCategorySummaryModel *eastLuxury = nil;
    UCategorySummaryModel *outdoor = nil;
    for (UCategorySummaryModel *category in categoryArray) {
      if ([category.categoryId integerValue] == 103) {
        homeLife = category;
      } else if ([category.categoryId integerValue] == 203) {
        eastLuxury = category;
      } else if ([category.categoryId integerValue] == 193) {
        outdoor = category;
      } else if ([category.categoryId integerValue] == 336) {
        //U质甄选
        ClearObj(category.children);
      } else {
        UCategorySummaryModel *allCate = [UCategorySummaryModel new];
        allCate.name = [NSString stringWithFormat:@"所有%@", category.name];
        allCate.categoryId = @([category.categoryId integerValue]);
        
        [category.children insertObject:allCate atIndex:0];
      }
    }
    
    [categoryArray removeObject:homeLife];
    [categoryArray removeObject:eastLuxury];
    [categoryArray removeObject:outdoor];
    
    UCategorySummaryModel *new = [[UCategorySummaryModel alloc] init];
    new.categoryId = @(CategoryNewId);
    new.name = @"男士最新";
    
    [categoryArray insertObject:new atIndex:0];
    
    if (success) {
      success(categoryArray);
    }
  } failure:failure];
}

+ (void)getHomeLifeCategoriesWithSuccess:(void (^)(NSArray *))success failure:(UErrorBlock)failure {
  NSString *path = [NSString stringWithFormat:@"%@/categories.json?response=simple", UMOBILE_URL];
  
  [UCategoryService getSummaryCategoriesWithPath:path parentId:@103 success:^(NSMutableArray *categoryArray) {
    NSMutableArray *homelifeList = categoryArray;
    [UCategoryService getCategoryInfo:@[@193] success:^(NSMutableArray *categoryArray) {
      UCategorySummaryModel *outdoor = [categoryArray firstObject];
      [UCategoryService getSummaryCategoriesWithPath:path parentId:outdoor.categoryId success:^(NSMutableArray *categoryArray) {
        outdoor.children = categoryArray;
        
        UCategorySummaryModel *allCate = [UCategorySummaryModel new];
        allCate.name = [NSString stringWithFormat:@"所有%@", outdoor.name];
        allCate.categoryId = @([outdoor.categoryId integerValue]);
        [outdoor.children insertObject:allCate atIndex:0];
        
        [homelifeList addObject:outdoor];
        
        UCategorySummaryModel *new = [[UCategorySummaryModel alloc] init];
        new.categoryId = @(103);
        new.name = @"家居最新";
        
        [homelifeList insertObject:new atIndex:0];
        
        if (success) {
          success(homelifeList);
        }
      } failure:failure];
    } failure:failure];
  } failure:failure];
}

+ (void)getEastLuxuryCategoriesWithSuccess:(void (^)(NSArray *))success failure:(UErrorBlock)failure {
  NSString *path = [NSString stringWithFormat:@"%@/categories.json?response=simple", UMOBILE_URL];
  
  [UCategoryService getSummaryCategoriesWithPath:path parentId:@203 success:^(NSMutableArray *categoryArray) {
    UCategorySummaryModel *new = [[UCategorySummaryModel alloc] init];
    new.categoryId = @(203);
    new.name = @"东方奢侈品最新";
    
    [categoryArray insertObject:new atIndex:0];
    
    for (UCategorySummaryModel *category in categoryArray) {
      ClearObj(category.children);
    }
    
    if (success) {
      success(categoryArray);
    }
  } failure:failure];
}

+ (void)getSummaryCategoriesWithPath:(NSString *)path parentId:(NSNumber *)parentId success:(void (^)(NSMutableArray *categoryArray))success failure:(UErrorBlock)failure {
  NSString *urlStr = [NSString stringWithFormat:@"%@&where[parent_id]=%@", path, parentId];
  [HttpClient GETRequestWithPath:urlStr success:^(id responseObject) {
    NSArray *simples = responseObject[@"data"];
    NSMutableArray *categoryIds = [NSMutableArray arrayWithCapacity:simples.count];
    for (NSDictionary *dict in simples) {
      [categoryIds addObject:dict[@"id"]];
    }
    
    [UCategoryService getCategoryInfo:categoryIds success:^(NSMutableArray *categoryArray) {
      __block NSInteger successCount = 0;
      NSInteger totalCount = categoryArray.count;
      for (UCategorySummaryModel *category in categoryArray) {
        NSString *cateUrlStr = [NSString stringWithFormat:@"%@&where[parent_id]=%@", path, category.categoryId];
        
        [HttpClient GETRequestWithPath:cateUrlStr success:^(id responseObject) {
          NSArray *cateSimples = responseObject[@"data"];
          NSMutableArray *cateIds = [NSMutableArray arrayWithCapacity:cateSimples.count];
          for (NSDictionary *cateDict in cateSimples) {
            [cateIds addObject:cateDict[@"id"]];
          }
          
          [UCategoryService getCategoryInfo:cateIds success:^(NSMutableArray *childrenCategories) {
            category.children = childrenCategories;
            successCount++;
            if (successCount == totalCount) {
              if (success) success(categoryArray);
            }
          } failure:failure];
        } failure:failure];
      }
    } failure:failure];
  } failure:failure];
}

@end
