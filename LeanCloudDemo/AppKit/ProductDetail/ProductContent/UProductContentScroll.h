//
//  UProductContentScroll.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UProductValueView.h"
#import "UProductSimilarView.h"

@interface UProductContentScroll : UIScrollView

@property (nonatomic, strong) UILabel *desTitleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *brandDesTitleLabel;
@property (nonatomic, strong) UILabel *brandDesLabel;
@property (nonatomic, strong) UILabel *similarTitleLabel;
@property (nonatomic, strong) UProductValueView *valueView;
@property (nonatomic, strong) UProductSimilarView *similarView;

- (void)shouldChangePageCallback:(dispatch_block_t)callback;

@end
