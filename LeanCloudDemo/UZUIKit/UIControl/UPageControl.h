//
//  UPageControl.h
//  UZhong
//
//  Created by jack on 15-3-22.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPageControl : UIPageControl
{
   UIImage *_activeImage;          //当前圆点图片
   UIImage *_inactiveImage;        //默认圆点图片
   UIImage *_specialActiveImage;   //特殊的当前图片
   UIImage *_specialInactiveImage; //特殊的默认图片
}

@property(nonatomic, assign) Boolean hasVideo;

@end
