//
//  UIAlertView+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UAlertCompletionHandler)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (UZ) <UIAlertViewDelegate>

//Action
- (void)setCompletionHandler:(UAlertCompletionHandler)handler;

@end
