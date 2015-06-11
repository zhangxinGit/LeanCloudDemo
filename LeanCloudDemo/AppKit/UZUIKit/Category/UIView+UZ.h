//
//  UIView+UZ.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/19.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UZ)

//移动位置，不改变尺寸
- (void)moveToX:(CGFloat)x;
- (void)moveToY:(CGFloat)y;
- (void)moveToX:(CGFloat)x y:(CGFloat)y;

//改变尺寸，不改变位置
- (void)changeSize:(CGSize)size;
- (void)changeHeight:(CGFloat)height;
- (void)changeWidth:(CGFloat)width;

//加载效果
- (void)beginLoadingEffect;
- (void)stopLoadingEffect;

//底部、顶部加分割线
- (void)addBottomSeparator;
- (void)addTopSeparator;
- (void)addSeparatorAtHeight:(CGFloat)height;
- (void)add1PixelSeparatorAtHeight:(CGFloat)height;
- (UIView *)generateSubLine;

@end
