//
//  UProductContentBuilder.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductContentBuilder.h"
#import "UProductValueModel.h"

#define TITLE_Y           (20)
#define INSET             (35)
#define COLOR_BAR_HEIGHT  (50)
#define LABEL_HEIGHT      (35)
#define INSET_SIZE        (10)
#define SIZE_BTN_WIDTH    (45)
#define SIZE_BTN_HEIGHT   (55)
#define DOT_LINE_WIDTH    (2)
#define DOT_LINE_HEIGHT   (50)
#define SIZE_TOOL_HEIGHT  (50)

#define REFRESH_WIDTH     (150)
#define REFRESH_HEIGHT    (30)

#define DES_MARGIN        (25)
#define INSET_DES         (5)

#define INSET_SIMILAR     (20)

@implementation UProductContentBuilder

- (void)buildSummary {
  CGFloat totalHeight = 0;
  
  UProductContentCard *cardView = _contentView.cardView;
  
  UILabel *subjectL = cardView.subjectLabel;
  subjectL.text = _viewModel.productSubject;
  CGSize subjectSize = [subjectL boundingRectWithSize:CGSizeMake(CONTENT_WIDTH, 1000)];
  subjectL.frame = CGRectMake(MARGIN_HORIZONTAL, TITLE_Y, CONTENT_WIDTH, subjectSize.height);
  [cardView addSubview:subjectL];
  
  totalHeight = TITLE_Y + subjectSize.height;
  
  if (StringNotEmpty(_viewModel.colorText)) {
    totalHeight += INSET;
    
    UILabel *colorL = cardView.colorLabel;
    colorL.text = _viewModel.colorText;
    colorL.frame = CGRectMake(MARGIN_HORIZONTAL, totalHeight, CONTENT_WIDTH, LABEL_HEIGHT);
    [cardView addSubview:colorL];
    
    totalHeight += LABEL_HEIGHT;
  }
  
  _contentView.cardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, totalHeight);
  CGFloat contentHeight = _contentView.frame.size.height;
  contentHeight = (contentHeight > totalHeight) ? contentHeight : totalHeight;
  [_contentView changeHeight:contentHeight];
}

- (void)buildComplete {
  UProductContentCard *cardView = _contentView.cardView;
  CGFloat totalHeight = _contentView.frame.size.height;
  
  if (ArrayNotEmpty(_viewModel.colors)) {
    
    totalHeight += INSET_SIZE;
    
    cardView.colorChosenTool.frame = CGRectMake(0, totalHeight, SCREEN_WIDTH, COLOR_BAR_HEIGHT);
    cardView.colorModels = _viewModel.colors;
    [cardView addSubview:cardView.colorChosenTool];
    totalHeight += COLOR_BAR_HEIGHT;
  }
  
  if (DictNotEmpty(_viewModel.measureSize) && !StringEqual([_viewModel.measureSize.allKeys firstObject], @"")) {
    totalHeight += INSET;
    
    cardView.sizeLabel.frame = CGRectMake(MARGIN_HORIZONTAL, totalHeight, CONTENT_WIDTH, LABEL_HEIGHT);
    cardView.sizeLabel.text = _viewModel.sizeText;
    [cardView addSubview:cardView.sizeLabel];
    
    totalHeight += LABEL_HEIGHT;
    totalHeight += INSET_SIZE;
    
    cardView.sizeButton.frame = CGRectMake(MARGIN_HORIZONTAL-INSET_SIZE/2, totalHeight, SIZE_BTN_WIDTH, SIZE_BTN_HEIGHT);
    [cardView addSubview:cardView.sizeButton];
    
    cardView.dotLine.frame = CGRectMake(CGRectGetMaxX(cardView.sizeButton.frame)+INSET_SIZE, totalHeight, DOT_LINE_WIDTH, DOT_LINE_HEIGHT);
    [cardView addSubview:cardView.dotLine];
    
    CGFloat sizeToolX = CGRectGetMaxX(cardView.dotLine.frame)+INSET_SIZE;
    cardView.sizeChosenTool.frame = CGRectMake(sizeToolX, totalHeight, SCREEN_WIDTH-sizeToolX, SIZE_TOOL_HEIGHT);
    cardView.sizeDict = _viewModel.measureSize;
    [cardView addSubview:cardView.sizeChosenTool];
    
    totalHeight += SIZE_TOOL_HEIGHT;
  }
  
  totalHeight += INSET;
  
  cardView.controlView.frame = CGRectMake((SCREEN_WIDTH-REFRESH_WIDTH)/2, totalHeight, REFRESH_WIDTH, REFRESH_HEIGHT);
  [cardView addSubview:cardView.controlView];
  
  totalHeight += REFRESH_HEIGHT;
  
  [_contentView.cardView changeHeight:totalHeight];
  _contentView.expectHeight = totalHeight;
  
  totalHeight += REFRESH_BOUNCE_HEIGHT;
  
  [_contentView changeHeight:totalHeight];
  
  _contentView.contentScroll.frame = CGRectMake(0, totalHeight, SCREEN_WIDTH, VIEW_HEIGHT-BUY_BAR_HEIGHT);
  
  CGFloat scrollContentHeight = 0.0;
  
  UProductContentScroll *scroll = _contentView.contentScroll;
  
  scrollContentHeight += DES_MARGIN;
  
  scroll.desTitleLabel.frame = CGRectMake(MARGIN_HORIZONTAL, scrollContentHeight, CONTENT_WIDTH, LABEL_HEIGHT);
  [scroll addSubview:scroll.desTitleLabel];
  
  scrollContentHeight += LABEL_HEIGHT;
  scrollContentHeight += INSET_DES;
  
  scroll.desLabel.text = _viewModel.productDescription;
  CGSize desSize = [scroll.desLabel boundingRectWithSize:CGSizeMake(CONTENT_WIDTH, 1000)];
  scroll.desLabel.frame = CGRectMake(MARGIN_HORIZONTAL, scrollContentHeight, CONTENT_WIDTH, desSize.height);
  [scroll addSubview:scroll.desLabel];
  
  scrollContentHeight += desSize.height;
  scrollContentHeight += INSET;
  
  scroll.brandDesTitleLabel.frame = CGRectMake(MARGIN_HORIZONTAL, scrollContentHeight, CONTENT_WIDTH, LABEL_HEIGHT);
  [scroll addSubview:scroll.brandDesTitleLabel];
  
  scrollContentHeight += LABEL_HEIGHT;
  scrollContentHeight += INSET_DES;
  
  scroll.brandDesLabel.text = _viewModel.brandDescription;
  CGSize brandDesSize = [scroll.brandDesLabel boundingRectWithSize:CGSizeMake(CONTENT_WIDTH, 1000)];
  scroll.brandDesLabel.frame = CGRectMake(MARGIN_HORIZONTAL, scrollContentHeight, CONTENT_WIDTH, brandDesSize.height);
  [scroll addSubview:scroll.brandDesLabel];
  
  scrollContentHeight += brandDesSize.height;
  
  if (ArrayNotEmpty(_viewModel.valuesList)) {
    scroll.valueView.valueModels = _viewModel.valuesList;
    scroll.valueView.frame = CGRectMake(MARGIN_HORIZONTAL, scrollContentHeight, CONTENT_WIDTH, scroll.valueView.expectHeight);
    
    scrollContentHeight += scroll.valueView.expectHeight;
    [scroll addSubview:scroll.valueView];
  }
  
  scroll.contentSize = CGSizeMake(0, scrollContentHeight);
  
//  [self.KVOController observe:_viewModel
//                      keyPath:@keypath(_viewModel, similarProducts)
//                      options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//                        NSArray *similars = change[NSKeyValueChangeNewKey];
//                        if (ArrayNotEmpty(similars)) {
//                          UProductContentScroll *nowScroll = _contentView.contentScroll;
//                          CGFloat nowContentHeight = nowScroll.contentSize.height;
//                          
//                          nowContentHeight += INSET;
//                          
//                          nowScroll.similarTitleLabel.frame = CGRectMake(0, nowContentHeight, SCREEN_WIDTH, LABEL_HEIGHT);
//                          [nowScroll addSubview:nowScroll.similarTitleLabel];
//                          
//                          nowContentHeight += LABEL_HEIGHT;
//                          nowContentHeight += INSET_SIMILAR;
//                          
//                          nowScroll.similarView.products = similars;
//                          nowScroll.similarView.frame = CGRectMake(0, nowContentHeight, SCREEN_WIDTH, nowScroll.similarView.expectHeight);
//                          [nowScroll addSubview:nowScroll.similarView];
//                          
//                          nowContentHeight += nowScroll.similarView.expectHeight;
//                          
//                          nowScroll.contentSize = CGSizeMake(0, nowContentHeight);
//                        }
//                      }];
  
  totalHeight += (VIEW_HEIGHT-BUY_BAR_HEIGHT);
  
  [_contentView changeHeight:totalHeight];
}

@end
