//
//  UITextField+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UEditingHandler)(UITextField *textField);
typedef void (^UInputChangeHandler)(UITextField *textField, NSString *totalInput);
typedef BOOL (^UShouldReturnHandler)(UITextField *textField, NSString *input);
typedef BOOL (^UShouldBeginHandler)(UITextField *textField);

@interface UITextField (UZ) <UITextFieldDelegate>

- (void)setDidBeginEditingHandler:(UEditingHandler)handler;
- (void)setDidEndEditingHandler:(UEditingHandler)handler;
- (void)setChangeInputHandler:(UInputChangeHandler)handler;
- (void)setShouldReturnHandler:(UShouldReturnHandler)handler;
- (void)setShouldBeginHandler:(UShouldBeginHandler)handler;

@end
