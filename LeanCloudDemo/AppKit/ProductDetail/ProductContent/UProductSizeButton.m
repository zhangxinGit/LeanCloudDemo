//
//  UProductSizeButton.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/28.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductSizeButton.h"

@interface UProductSizeButton ()
@property (nonatomic, copy) dispatch_block_t callback;
@end

@implementation UProductSizeButton

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.font = [UIFont systemFontOfSize:15.0];
    self.textAlignment = NSTextAlignmentCenter;
    [self setupInteraction];
  }
  return self;
}

- (void)setupInteraction {
  self.userInteractionEnabled = YES;
  UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithHandler:^(UIGestureRecognizer *recognizer, UIGestureRecognizerState state) {
    if (self.callback) {
      self.callback();
    }
  }];
  [self addGestureRecognizer:tapGes];
}

- (void)setSizeText:(NSString *)sizeText {
  self.text = sizeText;
}

- (void)setSizeButtonState:(SizeButtonState)state {
  self.layer.borderWidth = 1;
  if (state == SizeButtonStateNormal) {
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
  } else if (state == SizeButtonStateSelected) {
    self.layer.borderColor = [UIColor blackColor].CGColor;
  }
}

- (void)didChosenSizeCallback:(dispatch_block_t)callback {
  self.callback = callback;
}

@end
