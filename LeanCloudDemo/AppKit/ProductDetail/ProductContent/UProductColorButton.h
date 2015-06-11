//
//  UProductColorButton.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/26.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_BTN_WIDTH   (35)
#define COLOR_BTN_HEIGHT  (35)

typedef NS_ENUM(NSInteger, ColorButtonState) {
  ColorButtonStateNormal = 1,
  ColorButtonStateSelected
};

@interface UProductColorButton : UIView

@property (nonatomic, strong) id bindModel;

- (void)setColorButtonState:(ColorButtonState)state;
- (void)didChosenColorModelCallback:(dispatch_block_t)callback;

@end
