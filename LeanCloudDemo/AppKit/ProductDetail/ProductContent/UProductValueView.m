//
//  UProductValueView.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/26.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductValueView.h"
#import "UProductValueModel.h"

#define INSET   (10)
#define LABEL_HEIGHT  (35)

@implementation UProductValueView

- (void)setValueModels:(NSArray *)valueModels {
  _valueModels = valueModels;
  
  CGFloat h = 0;
  for (UProductValueModel *valueM in valueModels) {
    h += INSET;
    
    UILabel *title = [self createTitleLabelWithText:valueM.attribute_name];
    title.frame = CGRectMake(0, h, CONTENT_WIDTH, LABEL_HEIGHT);
    [self addSubview:title];
    
    h += LABEL_HEIGHT;
    
    UILabel *content = [self createContentLabelWithContent:valueM.content];
    CGFloat contentH = MAX([content boundingRectWithSize:CGSizeMake(CONTENT_WIDTH, 9999)].height, LABEL_HEIGHT) ;
    content.frame = CGRectMake(0, h, CONTENT_WIDTH, contentH);
    [self addSubview:content];
    
    h += contentH;
  }
  
  self.expectHeight = h;
}

- (UILabel *)createTitleLabelWithText:(NSString *)title {
  UILabel *label = [[UILabel alloc] init];
  label.text = title;
  label.font = [UIFont systemFontOfSize:17.0];
  return label;
}

- (UILabel *)createContentLabelWithContent:(NSString *)content {
  UILabel *label = [[UILabel alloc] init];
  label.text = content;
  label.font = [UIFont systemFontOfSize:14.0];
  label.numberOfLines = 0;
  label.textColor = [UIColor grayColor];
  return label;
}

@end
