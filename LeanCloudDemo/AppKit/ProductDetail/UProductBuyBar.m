//
//  UProductBuyBar.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductBuyBar.h"

@interface UProductBuyBar ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMargin;
@property (nonatomic, copy) dispatch_block_t purchaseCallback;
@end

@implementation UProductBuyBar

+ (instancetype)buyBar {
  id bar = [[[UINib nibWithNibName:@"UProductBuyBar" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
  return bar;
}

- (void)awakeFromNib {
  [self.priceLabel moveToX:MARGIN_HORIZONTAL];
  [self.discountLabel moveToX:MARGIN_HORIZONTAL];
  self.rightMargin.constant = MARGIN_HORIZONTAL;
  self.barState = BuyBarStateBuy;
  [self addTopSeparator];
}

- (void)setBarState:(BuyBarState)barState {
  _barState = barState;
  if (barState == BuyBarStateClear) {
    [self.purchaseButton setImage:ImageCache(@"cart_clearbtn_enable") forState:UIControlStateNormal];
  } else {
    [self.purchaseButton setImage:ImageCache(@"purchase_btn_normal") forState:UIControlStateNormal];
  }
}

- (void)setPurchaseClickCallback:(dispatch_block_t)callback {
  self.purchaseCallback = callback;
}

- (IBAction)onClickPurchaseButton:(id)sender {
  if (self.purchaseCallback) {
    self.purchaseCallback();
  }
}

@end
