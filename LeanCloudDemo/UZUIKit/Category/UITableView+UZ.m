//
//  UITableView+UZ.m
//  UZhong
//
//  Created by Hanran Liu on 15/4/7.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UITableView+UZ.h"

@implementation UITableView (UZ)

- (void)dontShowEmptyCell {
  self.tableFooterView = [[UIView alloc] init];
}

@end
