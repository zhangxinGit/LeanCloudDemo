//
//  TextFieldValidate.h
//  EaseMobDemo
//
//  Created by Mac on 15-6-9.
//  Copyright (c) 2015年 Mac. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface TextFieldValidate : NSObject

//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile;

//验证电子邮箱
+ (BOOL) validateEmail:(NSString *)email;

//验证密码
+ (BOOL) validatePassword:(NSString *) password;

@end
