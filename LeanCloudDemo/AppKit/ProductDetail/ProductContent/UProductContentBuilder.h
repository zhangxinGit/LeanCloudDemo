//
//  UProductContentBuilder.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UProductContentView.h"
#import "UProductDetailViewModel.h"

#define BUY_BAR_HEIGHT (60)

@interface UProductContentBuilder : NSObject

@property (nonatomic, strong) UProductContentView *contentView;
@property (nonatomic, strong) UProductDetailViewModel *viewModel;

- (void)buildSummary;
- (void)buildComplete;

@end
