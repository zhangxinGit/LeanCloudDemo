//
//  UProductSizeController.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//  尺寸视图控制器

#import "UBaseViewController.h"
#import "UProductSizeViewModel.h"

@interface UProductSizeController : UBaseViewController<UIScrollViewDelegate>
{
  UIScrollView *contentView;
  UIView *tableView;
}
@property (nonatomic, strong) UProductSizeViewModel *sizeViewModel;

@end
