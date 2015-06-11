//
//  UManagedObject.h
//  LeanCloudDemo
//
//  Created by Mac on 15-6-11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UManagedObject : NSManagedObject

+ (NSString *)entityName;

+ (instancetype)createNewObjectIntoContext:(NSManagedObjectContext *)context;

@end
