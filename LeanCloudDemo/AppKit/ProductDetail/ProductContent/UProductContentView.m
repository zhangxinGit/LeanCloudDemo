//
//  UProductContentView.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductContentView.h"

#define SpringValueMax (1)
#define SwipeJudgeDistance (10)

@interface UProductContentView () {
  CGFloat _cardNormalY;
}
@property (nonatomic, copy) dispatch_block_t changeFrameCallback;
@property (nonatomic, copy) dispatch_block_t sizePageCallback;
@property (nonatomic, strong) UIPanGestureRecognizer *cardGesture;
@end

@implementation UProductContentView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initializationConfig];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initializationConfig];
  }
  return self;
}

- (void)initializationConfig {
  _cardView = [[UProductContentCard alloc] init];
  [_cardView sizeButtonClickCallback:^{
    if (self.sizePageCallback) {
      self.sizePageCallback();
    }
  }];
  [self addSubview:_cardView];
  
  
  _contentScroll = [[UProductContentScroll alloc] init];
  [_contentScroll shouldChangePageCallback:^{
    self.state = ContentStateCard;
    [self setContentOffset:CGPointZero animated:YES];
    [self executeFrameChangeCallback];
  }];
  [self addSubview:_contentScroll];
  
  self.scrollEnabled = NO;
  self.showsVerticalScrollIndicator = NO;
  self.backgroundColor = [UIColor whiteColor];
  
  self.state = ContentStateNotAllowInteraction;
  [self setupInteraction];
}

- (void)setupInteraction {
  static CGFloat startY;
  
  UIPanGestureRecognizer *cardGesture = [[UIPanGestureRecognizer alloc] initWithHandler:^(UIGestureRecognizer *recognizer, UIGestureRecognizerState state) {
    if (self.state == ContentStateNotAllowInteraction) return;
    
    CGPoint touchPoint = [recognizer locationInView:_cardView];
    
    switch (state) {
      case UIGestureRecognizerStateBegan: {
        startY = [recognizer locationInView:_cardView].y;
      }
        break;
      case UIGestureRecognizerStateChanged: {
        CGFloat deltaY = startY - touchPoint.y;
        if (self.state == ContentStateCard) {
          if (deltaY > 0) {
            self.state = ContentStateCardMoving;
            _cardNormalY = self.frame.origin.y;
          }
        }
        if (self.state == ContentStateCardMoving) {
          CGFloat oriY = self.frame.origin.y;
          CGFloat oriDelta = ABS(oriY - _cardNormalY);
          CGFloat springValue = SpringValueMax * (1 - oriDelta/REFRESH_BOUNCE_HEIGHT);
          CGFloat newY = oriY - springValue * deltaY;
          [self moveToY:newY];
          
          if (newY < _cardNormalY) {
            CGFloat rate = (_cardNormalY - newY) / REFRESH_BOUNCE_HEIGHT;
            _cardView.controlView.rate = rate;
          }
        }
      }
        break;
      case UIGestureRecognizerStateCancelled:
      case UIGestureRecognizerStateEnded:
      default: {
        if (self.state == ContentStateAllowInteraction) {
          CGFloat deltaY = startY - touchPoint.y;
          if (deltaY >= SwipeJudgeDistance) {
            self.state = ContentStateCard;
            [self executeFrameChangeCallback];
          }
        } else if (self.state == ContentStateCard) {
          CGFloat deltaY = startY - touchPoint.y;
          if (deltaY <= SwipeJudgeDistance) {
            self.state = ContentStateAllowInteraction;
            _cardView.controlView.rate = 0.0;
            [self executeFrameChangeCallback];
          }
        } else if (self.state == ContentStateCardMoving) {
          if (_cardView.controlView.rate >= REFRESH_JUDGE_VALUE) {
            self.state = ContentStateWholePage;
            [self setContentOffset:CGPointMake(0, self.expectHeight+REFRESH_BOUNCE_HEIGHT) animated:YES];
          } else {
            self.state = ContentStateCard;
          }
          _cardView.controlView.rate = 0.0;
          [self executeFrameChangeCallback];
        }
      }
        break;
    }
  }];
  [_cardView addGestureRecognizer:cardGesture];
  self.cardGesture = cardGesture;
}

- (void)executeFrameChangeCallback {
  if (self.changeFrameCallback) {
    self.changeFrameCallback();
  }
}

- (void)frameShouldChangeCallback:(dispatch_block_t)callback {
  self.changeFrameCallback = callback;
}

- (void)shouldShowSizePageCallback:(dispatch_block_t)callback {
  self.sizePageCallback = callback;
}

@end
