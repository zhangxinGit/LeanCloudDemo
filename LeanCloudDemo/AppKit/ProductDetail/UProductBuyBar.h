//
//  UProductBuyBar.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//  购买栏

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BuyBarState) {
  BuyBarStateBuy = 0,
  BuyBarStateClear
};

@interface UProductBuyBar : UIView

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIButton *purchaseButton;

@property (nonatomic, assign) BuyBarState barState;

+ (instancetype)buyBar;

- (void)setPurchaseClickCallback:(dispatch_block_t)callback;

@end
