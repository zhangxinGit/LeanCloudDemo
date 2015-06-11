//
//  UAppContext.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/8.
//  Copyright (c) 2015年 com.ihaveu.mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "UDefaultsData.h"

@interface UAppContext : NSObject

@property (nonatomic, strong, readonly) NSString *appVersion;
@property (nonatomic, assign, readonly, getter=isFirstLaunch) BOOL firstLaunch;

@property (nonatomic, strong, readonly) DeviceInfo    *deviceInfo;
@property (nonatomic, strong, readonly) UDefaultsData *defaultsData;

+ (instancetype)context;

- (void)startupAppLaunchFlow;
- (void)clearLoginDefault;

- (void)terminateOpreations;

@end
