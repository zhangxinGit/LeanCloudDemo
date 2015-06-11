//
//  UIGestureRecognizer+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UIGestureRecognizer+UZ.h"
#import <objc/runtime.h>

static void * UGestureHandlerKey = &UGestureHandlerKey;

@implementation UIGestureRecognizer (UZ)

+ (instancetype)gestureRecognizerWithHandler:(UGestureStateHandler)handler {
  return [[self alloc] initWithHandler:handler];
}

- (instancetype)initWithHandler:(UGestureStateHandler)handler {
  NSParameterAssert(handler);
  self = [self initWithTarget:self action:@selector(handleAction:)];
  if (!self) return nil;
  objc_setAssociatedObject(self, UGestureHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
  return self;
}

- (void)handleAction:(UIGestureRecognizer *)sender {
  UGestureStateHandler handler = objc_getAssociatedObject(self, UGestureHandlerKey);
  handler(self, self.state);
}

@end
