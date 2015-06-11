//
//  URuntime.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "URuntime.h"
#import <objc/runtime.h>

void USwizzleMethod(Class class, SEL origSel, SEL newSel) {
  Method oriMethod = class_getInstanceMethod(class, origSel);
  Method newMethod = class_getInstanceMethod(class, newSel);
  
  BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
  if (didAddMethod) {
    class_replaceMethod(class, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
  } else {
    method_exchangeImplementations(oriMethod, newMethod);
  }
}

void USwizzleClassMethod(Class class, SEL origSel, SEL newSel) {
  Method oriMethod = class_getClassMethod(class, origSel);
  Method newMethod = class_getClassMethod(class, newSel);
  
  BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
  if (didAddMethod) {
    class_replaceMethod(class, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
  } else {
    method_exchangeImplementations(oriMethod, newMethod);
  }
}