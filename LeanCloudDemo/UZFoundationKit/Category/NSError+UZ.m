//
//  NSError+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/4.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import "NSError+UZ.h"

static NSString * const UModelErrorDomain = @"UModelErrorDomain";
static const NSInteger UModelErrorExceptionThrown = 1;
static NSString * const UModelThrownExceptionErrorKey = @"UModelThrownException";

static NSString * const UServiceErrorDomain = @"UServiceErrorDomain";

@implementation NSError (UZ)

+ (instancetype)modelErrorWithException:(NSException *)exception {
  NSParameterAssert(exception);
  
  NSDictionary *userInfo = @{NSLocalizedDescriptionKey: exception.description,
                             NSLocalizedFailureReasonErrorKey: exception.reason,
                             UModelThrownExceptionErrorKey: exception};
  
  return [NSError errorWithDomain:UModelErrorDomain code:UModelErrorExceptionThrown userInfo:userInfo];
}

+ (instancetype)serviceErrorWithInfo:(NSDictionary *)info {
  NSParameterAssert(info);
  
  if ([info isKindOfClass:NSDictionary.class] && info[@"message"] && info[@"code"]) {
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: info[@"message"]};
    return [NSError errorWithDomain:UServiceErrorDomain code:[info[@"code"] integerValue] userInfo:userInfo];
  } else {
    return [NSError errorWithDomain:UServiceErrorDomain code:0 userInfo:nil];
  }
}

@end

