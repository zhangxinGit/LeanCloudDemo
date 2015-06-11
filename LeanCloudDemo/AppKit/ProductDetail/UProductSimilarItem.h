//
//  UProductSimilarItem.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UProductSummaryModel.h"

#define NORMAL_SPACING      (2)
#define NORMAL_ITEM_SIZE_W  ((SCREEN_WIDTH-NORMAL_SPACING)/2)
#define NORMAL_ITEM_SIZE_H  (NORMAL_ITEM_SIZE_W*25/16)

typedef void (^SelectProductCallback)(UProductSummaryModel *product);

@interface UProductSimilarItem : UIView

+ (instancetype)item;

- (void)bindProduct:(UProductSummaryModel *)product;
- (void)didSelectCallback:(SelectProductCallback)callback;

@end
