//
//  UProductBannerView.h
//  UZhong
//
//  Created by jack on 15-3-24.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIImageView+WebCache.h>
#import "UProductDetailModel.h"
#import "UPageControl.h"

@interface UProductBannerView : UIView<UIScrollViewDelegate>
{
  @public
  UIScrollView *imgScrollView;
  
  @protected
  UPageControl *pageIndicatorView;
  
  UIImageView *imgView;
  
  UIView *videoView;
  
  MPMoviePlayerController *moviePlayer;
  
  NSURL *videoUrl;
  
  UIButton *playBtn;
  
  NSInteger pageIndex;
  
  NSMutableArray *imgSaveArray;
  
  NSMutableDictionary *imgLoadCompletedDic;
  
  //轮播长度即页面个数
  NSInteger loopLength;
}

@property (strong, nonatomic) NSArray *productImagesArray;

@property (strong, nonatomic) NSArray *productVideoArray;

-(void)setBannerData;

@end
