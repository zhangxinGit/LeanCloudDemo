//
//  UIView+UZ.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/19.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UIView+UZ.h"
#import "UIndicatorView.h"
#import <objc/runtime.h>

static void * ULoadingIndicatorKey = &ULoadingIndicatorKey;

@implementation UIView (UZ)

- (void)moveToX:(CGFloat)x {
  CGFloat y = self.frame.origin.y;
  [self moveToX:x y:y];
}

- (void)moveToY:(CGFloat)y {
  CGFloat x = self.frame.origin.x;
  [self moveToX:x y:y];
}

- (void)moveToX:(CGFloat)x y:(CGFloat)y {
  CGSize size = self.frame.size;
  self.frame = CGRectMake(x, y, size.width, size.height);
}

- (void)changeWidth:(CGFloat)width {
  CGFloat height = self.frame.size.height;
  [self changeSize:CGSizeMake(width, height)];
}

- (void)changeHeight:(CGFloat)height {
  CGFloat width = self.frame.size.width;
  [self changeSize:CGSizeMake(width, height)];
}

- (void)changeSize:(CGSize)size {
  CGPoint origin = self.frame.origin;
  self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (void)beginLoadingEffect {
  UIndicatorView *indicator = [[UIndicatorView alloc] initWithFrame:self.bounds];
  indicator.backgroundColor = [UIColor whiteColor];
  [self addSubview:indicator];
  
  [indicator startLoading];
  objc_setAssociatedObject(self, ULoadingIndicatorKey, indicator, OBJC_ASSOCIATION_ASSIGN);
}

- (void)stopLoadingEffect {
  UIndicatorView *indicator = objc_getAssociatedObject(self, ULoadingIndicatorKey);
  if (indicator != nil) {
    [indicator stopLoading];
    [indicator removeFromSuperview];
    objc_setAssociatedObject(self, ULoadingIndicatorKey, nil, OBJC_ASSOCIATION_ASSIGN);
  }
}

- (void)addBottomSeparator {
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height-1, SCREEN_WIDTH, 1)];
  [self addSubview:lineView];
  lineView.backgroundColor = [UIColor lightGrayColor];
  lineView.transform = CGAffineTransformMakeScale(1, 0.5);
}

- (void)addTopSeparator {
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0, SCREEN_WIDTH, 1)];
  [self addSubview:lineView];
  lineView.backgroundColor = [UIColor lightGrayColor];
  lineView.transform = CGAffineTransformMakeScale(1, 0.5);
}

- (void)addSeparatorAtHeight:(CGFloat)height {
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, height, SCREEN_WIDTH, 1)];
  [self addSubview:lineView];
  lineView.backgroundColor = [UIColor lightGrayColor];
  lineView.transform = CGAffineTransformMakeScale(1, 0.5);
}

- (void)add1PixelSeparatorAtHeight:(CGFloat)height {
  UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, height, SCREEN_WIDTH, 1)];
  [self addSubview:lineView];
  lineView.backgroundColor = [UIColor lightGrayColor];
}

- (UIView *)generateSubLine {
  UIView *line = [[UIView alloc] init];
  line.backgroundColor = UIColorFromHex(0xeeeeee);
  return line;
}

@end
