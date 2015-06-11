//
//  UProductRefreshControl.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductRefreshControl.h"

@implementation UProductRefreshControl

- (instancetype)init {
  return [[[UINib nibWithNibName:@"UProductRefreshControl" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
}

- (void)awakeFromNib {
  self.textLabel.text = @"上拉查看详情";
}

- (void)setRate:(CGFloat)rate {
  _rate = rate;
  
  if (rate == 0.0) {
    [UIView beginAnimations:nil context:nil];
    self.controlImage.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
  } else {
    self.controlImage.transform = CGAffineTransformMakeRotation(M_PI * MIN(rate, 1.0));
  }
  
  if (rate >= REFRESH_JUDGE_VALUE) {
    self.textLabel.text = @"释放查看详情";
  } else {
    self.textLabel.text = @"上拉查看详情";
  }
}

@end
