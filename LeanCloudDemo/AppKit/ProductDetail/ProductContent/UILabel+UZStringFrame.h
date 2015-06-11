//
//  UILabel+StringFrame.h
//  Udemo
//
//  Created by Mac on 15-3-23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UZStringFrame)
/*
 根据获取到的字符串以及字体计算label需要的size
 size 传人宽高 高为0
 */
- (CGSize)boundingRectWithSize:(CGSize)size;
@end
