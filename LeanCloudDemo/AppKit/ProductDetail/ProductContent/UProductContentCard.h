//
//  UProductContentCard.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UProductRefreshControl.h"

typedef void (^ChosenColorCallback)(id colorProduct);
typedef void (^ChosenSizeCallback)(NSString *sizeText);

@interface UProductContentCard : UIView

@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UIScrollView *colorChosenTool;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UIButton *sizeButton;
@property (nonatomic, strong) UIImageView *dotLine;
@property (nonatomic, strong) UIScrollView *sizeChosenTool;

@property (nonatomic, strong) UProductRefreshControl *controlView;

@property (nonatomic, strong) NSArray *colorModels;
@property (nonatomic, strong) NSDictionary *sizeDict;

- (void)sizeButtonClickCallback:(dispatch_block_t)callback;
- (void)didSelectColorModelCallback:(ChosenColorCallback)callback;
- (void)didSelectSizeCallback:(ChosenSizeCallback)callback;

@end
