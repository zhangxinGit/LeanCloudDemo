//
//  UManagedObject.m
//  LeanCloudDemo
//
//  Created by Mac on 15-6-11.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "UManagedObject.h"

@implementation UManagedObject

+ (NSString *)entityName{
  return NSStringFromClass(self.class);
}

+ (instancetype)createNewObjectIntoContext:(NSManagedObjectContext *)context{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

@end
