//
//  UBaseViewController.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBaseNavigationController.h"
#import "UBaseViewModel.h"

@interface UBaseViewController : UIViewController

@property (nonatomic, strong) UBaseNavigationController *naviController;

- (instancetype)initWithViewModel:(UBaseViewModel *)viewModel;
- (void)showNaviBackButton;

- (void)willPopToLastController;

- (void)hideTabbar;

- (void)registerConflictGestureScroll:(UIScrollView *)scroll;

@end
