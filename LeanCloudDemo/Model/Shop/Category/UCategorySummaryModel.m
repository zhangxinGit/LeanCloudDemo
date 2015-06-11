//
//  UCategorySummaryModel.m
//  UZhongDemo
//
//  Created by jack on 15-3-18.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UCategorySummaryModel.h"

@implementation UCategorySummaryModel

- (BOOL)haveChildren {
  return ArrayNotEmpty(self.children);
}

@end
