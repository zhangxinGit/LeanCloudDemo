//
//  UBaseViewController.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UBaseViewController.h"

@interface UBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation UBaseViewController

- (instancetype)initWithViewModel:(UBaseViewModel *)viewModel {
  return [self init];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)showNaviBackButton {
  UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  backBtn.frame = CGRectMake(0, 0, 20, 20);
  [backBtn setImage:ImageCache(@"nav_back_normal") forState:UIControlStateNormal];
  [backBtn addOnClickEventHandler:^(id sender) {
    [self willPopToLastController];
    [self.naviController popViewControllerAnimated:YES];
  }];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (UBaseNavigationController *)naviController {
  return (UBaseNavigationController *)self.navigationController;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}

- (void)willPopToLastController {
  //abstract...
}

- (void)hideTabbar {
  self.hidesBottomBarWhenPushed = YES;
}

- (void)registerConflictGestureScroll:(UIScrollView *)scroll {
  [scroll.panGestureRecognizer requireGestureRecognizerToFail:self.naviController.interactivePopGestureRecognizer];
}

@end
