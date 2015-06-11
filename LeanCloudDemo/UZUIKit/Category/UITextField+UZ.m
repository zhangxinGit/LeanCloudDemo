//
//  UITextField+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

static void * UDidBeginEditingHandlerKey = &UDidBeginEditingHandlerKey;
static void * UDidEndEditingHandlerKey = &UDidEndEditingHandlerKey;
static void * UChangeInputHandlerKey = &UChangeInputHandlerKey;
static void * UShouldReturnHandlerKey = &UShouldReturnHandlerKey;
static void * UShouldBeginHandlerKey = &UShouldBeginHandlerKey;

static void * UInputTextMutableCopyKey = &UInputTextMutableCopyKey;

#import "UITextField+UZ.h"
#import <objc/runtime.h>

@implementation UITextField (UZ)

- (void)registerForHandler {
  if (self.delegate != self) self.delegate = self;
}

- (void)setDidBeginEditingHandler:(UEditingHandler)handler {
  NSParameterAssert(handler);
  [self registerForHandler];
  objc_setAssociatedObject(self, UDidBeginEditingHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDidEndEditingHandler:(UEditingHandler)handler {
  NSParameterAssert(handler);
  [self registerForHandler];
  objc_setAssociatedObject(self, UDidEndEditingHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setChangeInputHandler:(UInputChangeHandler)handler {
  NSParameterAssert(handler);
  [self registerForHandler];
  objc_setAssociatedObject(self, UChangeInputHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setShouldReturnHandler:(UShouldReturnHandler)handler {
  NSParameterAssert(handler);
  [self registerForHandler];
  objc_setAssociatedObject(self, UShouldReturnHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setShouldBeginHandler:(UShouldBeginHandler)handler {
  NSParameterAssert(handler);
  [self registerForHandler];
  objc_setAssociatedObject(self, UShouldBeginHandlerKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  UEditingHandler handler = objc_getAssociatedObject(self, UDidBeginEditingHandlerKey);
  if (handler) {
    handler(textField);
  }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  UEditingHandler handler = objc_getAssociatedObject(self, UDidEndEditingHandlerKey);
  if (handler) {
    handler(textField);
  }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  UShouldBeginHandler handler = objc_getAssociatedObject(self, UShouldBeginHandlerKey);
  if (handler) {
    return handler(textField);
  }
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  UInputChangeHandler handler = objc_getAssociatedObject(self, UChangeInputHandlerKey);
  if (handler) {
    NSMutableString *input = [self.text mutableCopy];
    BOOL isRem = range.length;
    if (isRem) {
      [input deleteCharactersInRange:range];
    } else {
      [input insertString:string atIndex:range.location];
    }
    handler(textField, [input copy]);
  }
  
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  UShouldReturnHandler handler = objc_getAssociatedObject(self, UShouldReturnHandlerKey);
  if (handler) {
    return handler(textField, textField.text);
  }
  
  return YES;
}

@end
