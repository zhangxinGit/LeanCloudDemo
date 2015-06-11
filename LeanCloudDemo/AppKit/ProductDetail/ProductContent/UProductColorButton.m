//
//  UProductColorButton.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/26.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductColorButton.h"

#define SELECT_MARGIN (3)

@interface UProductColorButton () {
  UIImageView *_imageView;
  UITapGestureRecognizer *_tapGes;
}
@property (nonatomic, copy) dispatch_block_t callback;
@end

@implementation UProductColorButton

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initSubviews];
    [self setupInteraction];
  }
  return self;
}

- (void)initSubviews {
  _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
  _imageView.userInteractionEnabled = YES;
  [self addSubview:_imageView];
}

- (void)setupInteraction {
  _tapGes = [[UITapGestureRecognizer alloc] initWithHandler:^(UIGestureRecognizer *recognizer, UIGestureRecognizerState state) {
    if (self.callback) {
      self.callback();
    }
  }];
  [self addGestureRecognizer:_tapGes];
}

- (void)setColorButtonState:(ColorButtonState)state {
  if (state == ColorButtonStateNormal) {
    self.layer.borderColor = nil;
    _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imageView.layer.borderWidth = 1;
    _imageView.frame = self.bounds;
  } else if (state == ColorButtonStateSelected) {
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1;
    _imageView.layer.borderWidth = 1;
    [_imageView changeSize:CGSizeMake(COLOR_BTN_WIDTH-2*SELECT_MARGIN, COLOR_BTN_HEIGHT-2*SELECT_MARGIN)];
    [_imageView moveToX:SELECT_MARGIN y:SELECT_MARGIN];
  }
}

- (void)setBindModel:(id)bindModel {
  _bindModel = bindModel;
  
  NSString *imgStr = [bindModel valueForKey:@"color_pic"];
  [_imageView sd_setImageWithURL:[NSURL URLWithString:ImageConcat(imgStr)] placeholderImage:nil];
}

- (void)didChosenColorModelCallback:(dispatch_block_t)callback {
  self.callback = callback;
}

@end
