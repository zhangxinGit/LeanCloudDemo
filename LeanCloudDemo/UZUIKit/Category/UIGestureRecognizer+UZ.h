//
//  UIGestureRecognizer+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UGestureStateHandler)(UIGestureRecognizer *recognizer, UIGestureRecognizerState state);

@interface UIGestureRecognizer (UZ)

//Action
+ (instancetype)gestureRecognizerWithHandler:(UGestureStateHandler)handler;
- (instancetype)initWithHandler:(UGestureStateHandler)handler NS_REPLACES_RECEIVER;

@end
