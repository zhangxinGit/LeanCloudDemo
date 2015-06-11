//
//  UProductSimilarView.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//  同类商品视图

#import <UIKit/UIKit.h>
#import "UProductSimilarItem.h"

@interface UProductSimilarView : UIView

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, assign) CGFloat expectHeight;

- (void)didSelectItemCallback:(SelectProductCallback)callback;

@end
