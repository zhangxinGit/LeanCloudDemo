//
//  UBaseNavigationController.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/16.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBaseNavigationController.h"

@interface UBaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation UBaseNavigationController

- (void)configuration {
  NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
  [[UINavigationBar appearance] setTitleTextAttributes:attributes];
  [self.navigationBar setBarTintColor:UIColorFromHex(0xf7f6f6)];
  self.navigationBar.translucent = NO;

  self.interactivePopGestureRecognizer.enabled = YES;
  
  __weak UBaseNavigationController *weakSelf = self;
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.interactivePopGestureRecognizer.delegate = weakSelf;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configuration];
}

@end
