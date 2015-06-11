//
//  UBaseTableCell.m
//  UZhong
//
//  Created by Hanran Liu on 15/4/13.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBaseTableCell.h"

@interface UBaseTableCell () 
@end

@implementation UBaseTableCell

- (void)showCustomSeparator {
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height-1, SCREEN_WIDTH, 1)];
  [self.contentView addSubview:lineView];
//  [lineView setBackgroundColor:COLOR(224, 224, 224, 1)];
  lineView.backgroundColor = [UIColor lightGrayColor];
  lineView.transform = CGAffineTransformMakeScale(1, 0.5);
}

@end
