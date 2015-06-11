//
//  UProductSimilarItem.m
//  UZhong
//
//  Created by Hanran Liu on 15/3/23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UProductSimilarItem.h"

@interface UProductSimilarItem ()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *actLabel;

@property (nonatomic, strong) SelectProductCallback callback;
@property (nonatomic, strong) UProductSummaryModel *bindModel;

@end

@implementation UProductSimilarItem

+ (instancetype)item {
  return [[[UINib nibWithNibName:@"UProductSimilarItem" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
}

- (IBAction)onClickItem:(id)sender {
  if (self.callback) {
    self.callback(self.bindModel);
  }
}

- (void)bindProduct:(UProductSummaryModel *)product {
  self.bindModel = product;
  
  [self.productImageView sd_setImageWithURL:[UComUtil imageUrlAppendString:product.major_pic withSize:_productImageView.frame.size.width] placeholderImage:nil options:SDWebImageLowPriority | SDWebImageRetryFailed];
  self.subjectLabel.text = product.brand_name;
  self.priceLabel.text = [NSString stringWithFormat:@"￥%@", product.discount];
  if (StringNotEmpty(product.label)) {
    self.actLabel.text = [NSString stringWithFormat:@"【%@】", product.label];
  } else {
    self.actLabel.text = @"";
  }
}

- (void)didSelectCallback:(void (^)(UProductSummaryModel *))callback {
  self.callback = callback;
}

@end
