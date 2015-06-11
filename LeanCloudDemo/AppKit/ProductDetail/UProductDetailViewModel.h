//
//  UProductDetailViewModel.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//  商品详情ViewModel

#import "UBaseViewModel.h"
#import "UProductDetailModel.h"

@interface UProductDetailViewModel : UBaseViewModel

//商品视图
@property (nonatomic, strong) NSArray *productImages;
//视频地址
@property (nonatomic, strong) NSArray *productVideo;
//商品标题
@property (nonatomic, strong) NSString *productSubject;
//颜色文字
@property (nonatomic, strong) NSString *colorText;
//关联颜色
@property (nonatomic, strong) NSArray *colors;
//尺码文字
@property (nonatomic, strong) NSString *sizeText;
//关联尺码
@property (nonatomic, strong) NSMutableDictionary *measureSize;
//商品描述
@property (nonatomic, strong) NSString *productDescription;
//品牌描述
@property (nonatomic, strong) NSString *brandDescription;
//其他描述
@property (nonatomic, strong) NSArray *valuesList;
//同类商品
@property (nonatomic, strong) NSArray *similarProducts;
//价格文字
@property (nonatomic, strong) NSString *priceText;
//折扣文字
@property (nonatomic, strong) NSString *discountText;
//品牌名称
@property (nonatomic, strong) NSString *brandName;
//商品summary基本数据
@property (nonatomic, strong) UProductSummaryModel *summaryProduct;
//商品detail完整数据
@property (nonatomic, strong) UProductDetailModel  *detailProduct;
//是否收藏
@property (nonatomic, assign) BOOL isFavorite;

//使用上级点击的产品初始化
- (instancetype)initWithSummaryProduct:(UProductSummaryModel *)productSummaryModel;

//获取完整的产品数据
- (void)fetchCompleteProductInfomationWithSuccess:(dispatch_block_t)success failure:(dispatch_block_t)failure;

//提交到购物车
- (void)submitToCartWithSuccess:(dispatch_block_t)success failure:(UErrorBlock)failure failureMessage:(NSString **)message;

//收藏/取消收藏商品
- (void)favoriteCurrentProductWithSuccess:(dispatch_block_t)success failure:(UErrorBlock)failure;
- (void)cancelFavoriteCurrentProductWithSuccess:(dispatch_block_t)success failure:(UErrorBlock)failure;

//使用假数据测试
- (void)generateSummaryProduct;

@end
