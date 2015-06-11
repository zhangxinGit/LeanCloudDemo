//
//  UProductSizeButton.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/28.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SIZE_BTN_WIDTH   (45)
#define SIZE_BTN_HEIGHT  (30)

typedef NS_ENUM(NSInteger, SizeButtonState) {
  SizeButtonStateNormal = 1,
  SizeButtonStateSelected
};

@interface UProductSizeButton : UILabel

- (void)setSizeText:(NSString *)sizeText;
- (void)setSizeButtonState:(SizeButtonState)state;
- (void)didChosenSizeCallback:(dispatch_block_t)callback;

@end
