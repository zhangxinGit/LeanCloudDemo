//
//  NSError+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/4.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (UZ)
+ (instancetype)modelErrorWithException:(NSException *)exception;
+ (instancetype)serviceErrorWithInfo:(NSDictionary *)info;
@end
