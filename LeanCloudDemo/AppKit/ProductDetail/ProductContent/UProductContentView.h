//
//  UProductContentView.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UProductContentCard.h"
#import "UProductContentScroll.h"

#define REFRESH_BOUNCE_HEIGHT (50)

typedef NS_ENUM(NSInteger, ContentState) {
  ContentStateNotAllowInteraction = 0,
  ContentStateAllowInteraction,
  ContentStateCard,
  ContentStateCardMoving,
  ContentStateWholePage
};

@interface UProductContentView : UIScrollView

@property (nonatomic, assign) ContentState state;

@property (nonatomic, strong) UProductContentCard *cardView;
@property (nonatomic, strong) UProductContentScroll *contentScroll;

@property (nonatomic, assign) CGFloat expectHeight;

- (void)frameShouldChangeCallback:(dispatch_block_t)callback;
- (void)shouldShowSizePageCallback:(dispatch_block_t)callback;

@end
