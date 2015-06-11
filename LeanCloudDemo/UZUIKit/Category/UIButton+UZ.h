//
//  UIButton+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

typedef void (^UButtonClickHandler)(id sender);

#import <UIKit/UIKit.h>

@interface UIButton (UZ)

//Action
- (void)addOnClickEventHandler:(UButtonClickHandler)handler;

@end
