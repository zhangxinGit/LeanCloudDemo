//
//  UIButton+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UIButton+UZ.h"
#import <objc/runtime.h>

static void * UClickHandlerKey = &UClickHandlerKey;

@implementation UIButton (UZ)

- (void)addOnClickEventHandler:(UButtonClickHandler)handler {
  NSParameterAssert(handler);
  
  objc_setAssociatedObject(self, UClickHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
  [self addTarget:self action:@selector(invoke:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)invoke:(id)sender {
  UButtonClickHandler handler = objc_getAssociatedObject(self, UClickHandlerKey);
  handler(sender);
}

- (void)addTopSeparator {
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0, SCREEN_WIDTH, 1)];
  [self addSubview:lineView];
  //  [lineView setBackgroundColor:COLOR(224, 224, 224, 1)];
  lineView.backgroundColor = [UIColor lightGrayColor];
  lineView.transform = CGAffineTransformMakeScale(1, 0.5);
}

@end
