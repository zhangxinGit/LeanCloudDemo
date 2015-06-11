//
//  UProductSimilarView.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductSimilarView.h"

@interface UProductSimilarView ()
@property (nonatomic, copy) SelectProductCallback callback;
@end

@implementation UProductSimilarView

- (void)setProducts:(NSArray *)products {
  _products = products;
  
  [self layoutItems];
}

- (void)layoutItems {
  [self clearSubviews];
  
  NSInteger count = self.products.count;
  
  if (count%2 == 1) {
    count -= 1;
  }
  
  for (NSInteger i = 0; i < count; i++) {
    NSInteger row = i/2;
    NSInteger col = i%2;
    
    UProductSimilarItem *item = [UProductSimilarItem item];
    item.frame = CGRectMake(col * (NORMAL_ITEM_SIZE_W+NORMAL_SPACING), row * NORMAL_ITEM_SIZE_H, NORMAL_ITEM_SIZE_W, NORMAL_ITEM_SIZE_H);
    [item bindProduct:self.products[i]];
    [self addSubview:item];
    
    [item didSelectCallback:^(UProductSummaryModel *product) {
      if (self.callback) {
        self.callback(product);
      }
    }];
    
    if (i == count - 1) {
      self.expectHeight = CGRectGetMaxY(item.frame);
      break;
    }
  }
}

- (void)clearSubviews {
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
}

- (void)didSelectItemCallback:(void (^)(UProductSummaryModel *))callback {
  self.callback = callback;
}

@end
