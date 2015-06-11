//
//  URuntime.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/6.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

// Swizzle instance method
void USwizzleMethod(Class class, SEL origSel, SEL newSel);
// Swizzle class method
void USwizzleClassMethod(Class class, SEL origSel, SEL newSel);
