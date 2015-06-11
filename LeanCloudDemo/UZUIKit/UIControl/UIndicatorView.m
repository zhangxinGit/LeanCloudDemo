//
//  UIndicatorView.m
//  UZhong
//
//  Created by Hanran Liu on 15/4/8.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UIndicatorView.h"

#define LOADING_SIZE (20)

@interface UIndicatorView () {
  UIImageView *_imageView;
}

@end

@implementation UIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
  if (frame.size.width < LOADING_SIZE || frame.size.height < LOADING_SIZE) {
    return nil;
  }
  
  self = [super initWithFrame:frame];
  if (self) {
    _imageView = [[UIImageView alloc] initWithImage:ImageCache(@"loading17_black")];
    _imageView.bounds = CGRectMake(0, 0, LOADING_SIZE, LOADING_SIZE);
    _imageView.center = CGPointMake(self.center.x, self.center.y);
    [self addSubview:_imageView];
  }
  return self;
}

- (void)startLoading {
  CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  rotationAnimation.duration = 1;
  rotationAnimation.repeatCount = MAXFLOAT;
  rotationAnimation.cumulative = NO;
  rotationAnimation.removedOnCompletion = NO;
  rotationAnimation.fillMode = kCAFillModeForwards;
  [_imageView.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

- (void)stopLoading {
  [_imageView.layer removeAllAnimations];
}

@end
