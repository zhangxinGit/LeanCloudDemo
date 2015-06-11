//
//  UProductContentCard.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductContentCard.h"
#import "UProductColorButton.h"
#import "UProductSizeButton.h"

#define COLOR_BUTTON_INSET (15)
#define COLOR_BUTTON_Y     (5)

#define SIZE_BUTTON_INSET (15)
#define SIZE_BUTTON_Y     (8)

@interface UProductContentCard () {
  UProductSizeButton *_selectButton;
}
@property (nonatomic, copy) dispatch_block_t sizeCallback;
@property (nonatomic, copy) ChosenColorCallback chosenColorCallback;
@property (nonatomic, copy) ChosenSizeCallback chosenSizeCallback;
@end

@implementation UProductContentCard

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initConfig];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initConfig];
  }
  return self;
}

- (void)initConfig {
  //标题
  UILabel *subjectLabel = [[UILabel alloc] init];
  subjectLabel.font = [UIFont systemFontOfSize:17.0];
  subjectLabel.numberOfLines = 0;
  self.subjectLabel = subjectLabel;
  
  //颜色
  UILabel *colorLabel = [[UILabel alloc] init];
  self.colorLabel = colorLabel;
  
  //颜色选择栏
  UIScrollView *colorChosenTool = [[UIScrollView alloc] init];
  colorChosenTool.showsHorizontalScrollIndicator = NO;
  self.colorChosenTool = colorChosenTool;
  
  //尺寸
  UILabel *sizeLabel = [[UILabel alloc] init];
  self.sizeLabel = sizeLabel;
  
  //尺码说明按钮
  UIButton *sizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [sizeButton setImage:ImageCache(@"product_size_button_normal") forState:UIControlStateNormal];
  [sizeButton addOnClickEventHandler:^(id sender) {
    if (self.sizeCallback) {
      self.sizeCallback();
    }
  }];
  self.sizeButton = sizeButton;
  
  //分隔线
  UIImage *image = ImageCache(@"product_size_line");
  UIImageView *dotLine = [[UIImageView alloc] initWithImage:image];
  self.dotLine = dotLine;
  
  //尺码选择栏
  UIScrollView *sizeChosenTool = [[UIScrollView alloc] init];
  sizeChosenTool.showsHorizontalScrollIndicator = NO;
  self.sizeChosenTool = sizeChosenTool;
  
  //上拉显示更多
  UProductRefreshControl *controlView = [[UProductRefreshControl alloc] init];
  self.controlView = controlView;
}

- (void)sizeButtonClickCallback:(dispatch_block_t)callback {
  self.sizeCallback = callback;
}

- (void)setColorModels:(NSArray *)colorModels {
  _colorModels = colorModels;
  
  for (NSInteger i = 0; i < colorModels.count; i++) {
    UProductColorButton *colorBtn = [[UProductColorButton alloc] initWithFrame:CGRectMake(MARGIN_HORIZONTAL + i*(COLOR_BTN_WIDTH + COLOR_BUTTON_INSET), COLOR_BUTTON_Y, COLOR_BTN_WIDTH, COLOR_BTN_HEIGHT)];
    colorBtn.bindModel = colorModels[i];
    [colorBtn setColorButtonState:ColorButtonStateNormal];
    [self.colorChosenTool addSubview:colorBtn];
    [colorBtn didChosenColorModelCallback:^{
      if (self.chosenColorCallback) {
        self.chosenColorCallback(colorModels[i]);
      }
    }];
    
    if (i == colorModels.count - 1) {
      self.colorChosenTool.contentSize = CGSizeMake(CGRectGetMaxX(colorBtn.frame) + MARGIN_HORIZONTAL, 0);
    }
  }
}

- (void)setSizeDict:(NSDictionary *)sizeDict {
  _sizeDict = sizeDict;
  
  NSArray *keysList = [sizeDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    return [obj1 integerValue] > [obj2 integerValue];
  }];
  
  for (NSInteger i = 0; i < keysList.count; i++) {
    UProductSizeButton *sizeBtn = [[UProductSizeButton alloc] initWithFrame:CGRectMake(SIZE_BUTTON_INSET + i*(SIZE_BTN_WIDTH + SIZE_BUTTON_INSET), SIZE_BUTTON_Y, SIZE_BTN_WIDTH, SIZE_BTN_HEIGHT)];
    [sizeBtn setSizeText:keysList[i]];
    [sizeBtn setSizeButtonState:SizeButtonStateNormal];
    [self.sizeChosenTool addSubview:sizeBtn];
    [sizeBtn didChosenSizeCallback:^{
      if (_selectButton) {
        [_selectButton setSizeButtonState:SizeButtonStateNormal];
      }
      [sizeBtn setSizeButtonState:SizeButtonStateSelected];
      _selectButton = sizeBtn;
      
      if (self.chosenSizeCallback) {
        self.chosenSizeCallback(keysList[i]);
      }
    }];
    
    if (i == sizeDict.allKeys.count - 1) {
      self.sizeChosenTool.contentSize = CGSizeMake(CGRectGetMaxX(sizeBtn.frame) + SIZE_BUTTON_INSET, 0);
    }
  }
}

- (void)didSelectColorModelCallback:(ChosenColorCallback)callback {
  self.chosenColorCallback = callback;
}

- (void)didSelectSizeCallback:(ChosenSizeCallback)callback {
  self.chosenSizeCallback = callback;
}

@end
