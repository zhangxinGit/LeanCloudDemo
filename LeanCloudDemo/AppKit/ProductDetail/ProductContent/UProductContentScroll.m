//
//  UProductContentScroll.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductContentScroll.h"

#define SCROLL_JUDGE_DISTANCE (-40)

@interface UProductContentScroll () <UIScrollViewDelegate>
@property (nonatomic, copy) dispatch_block_t callback;
@end

@implementation UProductContentScroll

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initialConfig];
    [self setupUI];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initialConfig];
    [self setupUI];
  }
  return self;
}

- (void)initialConfig {
  self.backgroundColor = [UIColor whiteColor];
  self.showsVerticalScrollIndicator = YES;
  self.bounces = YES;
  self.delegate = self;
}

- (void)setupUI {
  UILabel *desTitle = [[UILabel alloc] init];
  desTitle.font = [UIFont systemFontOfSize:17.0];
  self.desTitleLabel = desTitle;
  
  UILabel *des = [[UILabel alloc] init];
  des.font = [UIFont systemFontOfSize:14.0];
  des.textColor = [UIColor grayColor];
  des.numberOfLines = 0;
  self.desLabel = des;
  
  UILabel *brandDesTitle = [[UILabel alloc] init];
  brandDesTitle.font = [UIFont systemFontOfSize:17.0];
  self.brandDesTitleLabel = brandDesTitle;

  UILabel *brandDes = [[UILabel alloc] init];
  brandDes.font = [UIFont systemFontOfSize:14.0];
  brandDes.textColor = [UIColor grayColor];
  brandDes.numberOfLines = 0;
  self.brandDesLabel = brandDes;
  
  self.desTitleLabel.text = @"描述";
  self.brandDesTitleLabel.text = @"品牌";
  
  UProductValueView *valueView = [[UProductValueView alloc] init];
  self.valueView = valueView;
  
  UILabel *similarTitle = [[UILabel alloc] init];
  similarTitle.backgroundColor = COLOR(142, 142, 142, 1.0);
  similarTitle.textColor = [UIColor whiteColor];
  similarTitle.text = @"   同类商品推荐";
  similarTitle.font = [UIFont systemFontOfSize:17.0];
  self.similarTitleLabel = similarTitle;
  
  UProductSimilarView *similarView = [[UProductSimilarView alloc] init];
  self.similarView = similarView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.contentOffset.y < SCROLL_JUDGE_DISTANCE) {
    if (self.callback) {
      self.callback();
    }
  }
}

- (void)shouldChangePageCallback:(dispatch_block_t)callback {
  self.callback = callback;
}

@end
