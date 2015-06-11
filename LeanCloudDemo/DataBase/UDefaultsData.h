//
//  UDefaultsData.h
//  LeanCloudDemo
//
//  Created by Mac on 15-6-11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UManagedObject.h"


@interface UDefaultsData : UManagedObject

@property (nonatomic, retain) NSString * appVersion;
@property (nonatomic, retain) NSNumber * dbVersion;
@property (nonatomic, retain) NSNumber * isLogin;
@property (nonatomic, retain) NSNumber * launchCount;
@property (nonatomic, retain) NSString * loginName;
@property (nonatomic, retain) NSString * password;

@end
