//
//  UIAlertView+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "UIAlertView+UZ.h"
#import <objc/runtime.h>

static void const * UAlertHandlerKey = &UAlertHandlerKey;

@implementation UIAlertView (UZ)

- (void)setCompletionHandler:(UAlertCompletionHandler)handler {
  objc_setAssociatedObject(self, UAlertHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
  if (handler != NULL) {
    self.delegate = self;
  }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  UAlertCompletionHandler handler = objc_getAssociatedObject(self, UAlertHandlerKey);
  if (handler) {
    handler(alertView, buttonIndex);
  }
}

@end
