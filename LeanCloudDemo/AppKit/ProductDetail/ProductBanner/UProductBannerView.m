//
//  UProductBannerView.m
//  UZhong
//
//  Created by jack on 15-3-24.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "UProductBannerView.h"
#import "UProductImageModel.h"
#import "UProductVideoModel.h"
#import "UComUtil.h"

@implementation UProductBannerView
@synthesize productImagesArray;
@synthesize productVideoArray;

-(id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  //初始化Banner视图容器
  [self initUI];
  
  return self;
}

/**
 *  初始化Banner视图容器
 */
-(void)initUI
{
  imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  [self addSubview:imgScrollView];
  imgScrollView.bounces = YES;
  imgScrollView.delegate = self;
  imgScrollView.showsHorizontalScrollIndicator = NO;
  imgScrollView.showsVerticalScrollIndicator = NO;
  imgScrollView.pagingEnabled = YES;
  imgScrollView.userInteractionEnabled = YES;
  imgScrollView.backgroundColor = [UIColor whiteColor];
  
  pageIndicatorView = [[UPageControl alloc] init];
  [self addSubview:pageIndicatorView];
  [pageIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imgScrollView]-(-25)-[pageIndicatorView(==7)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imgScrollView,pageIndicatorView)]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:pageIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
  pageIndicatorView.userInteractionEnabled = NO;
  
}

/**
 *  设置轮播数据
 */
-(void)setBannerData
{
  loopLength = [productImagesArray count];
  
  //图片视图保存数组
  imgSaveArray = [[NSMutableArray alloc] initWithCapacity:loopLength];
  
  //图片页面加载保存字典
  imgLoadCompletedDic = [[NSMutableDictionary alloc] initWithCapacity:loopLength];
  
  UProductVideoModel *videoModel;
  
  if([productVideoArray count] > 0){
     videoModel = productVideoArray[0];
    if(videoModel.mp4) {
      pageIndicatorView.hasVideo = true;
    }
  }
  
  //创建视频页
  if (pageIndicatorView.hasVideo) {
  
    loopLength = [productImagesArray count] + [productVideoArray count];
    
    videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, imgScrollView.frame.size.height)];
    [imgScrollView addSubview:videoView];
    
    videoUrl = [UComUtil videoUrlAppendString:videoModel.mp4 withSuffix:@"mmorigin"];
    
    playBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 70)/2, (imgScrollView.frame.size.height - 70)/2, 70, 70)];
    [videoView addSubview:playBtn];
    [playBtn setImage:[UIImage imageNamed:@"play_button"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(videoPlay) forControlEvents:UIControlEventTouchUpInside];
  }
  
  //控制轮换页面个数
  if(loopLength > 6) loopLength = 6;
  
  //创建图片页
  for (NSInteger i = 0; i < loopLength - (pageIndicatorView.hasVideo?1:0); i++) {
    //创建视图
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(((pageIndicatorView.hasVideo?1:0)+i)*SCREEN_WIDTH, 0, SCREEN_WIDTH, imgScrollView.frame.size.height)];
    [imgScrollView addSubview:imgView];
    
    if (i==0) {
        UProductImageModel *imgModel = productImagesArray[0];
      [imgView sd_setImageWithURL:[UComUtil imageUrlAppendString:imgModel.imageUrl withSize:225] placeholderImage:nil];
        
        [imgLoadCompletedDic setObject:imgView forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:pageIndex]]];
    }
    
    //保存视图
    [imgSaveArray addObject:imgView];
    
  }
  
  pageIndicatorView.numberOfPages = loopLength;
  pageIndicatorView.currentPage = 0;
  
  imgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*loopLength, 1);
  
  if(pageIndicatorView.hasVideo){
    [imgScrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, imgScrollView.frame.size.height) animated:NO];
  }
  
}

-(void)createVideoPlayer
{
   moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
  [[UIApplication sharedApplication].keyWindow addSubview:moviePlayer.view];
  [moviePlayer.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
  [moviePlayer.view setBackgroundColor:[UIColor whiteColor]];
  [moviePlayer.backgroundView setBackgroundColor:[UIColor whiteColor]];
   moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
  [moviePlayer play];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
}

//播放
-(void)videoPlay
{
  [self createVideoPlayer];

  playBtn.hidden = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  pageIndex = floor((scrollView.contentOffset.x - SCREEN_WIDTH)/SCREEN_WIDTH) + 1;
  
  pageIndicatorView.currentPage = pageIndex;
  
  if(pageIndicatorView.hasVideo) pageIndex--;
  
  if (pageIndex>(loopLength - 1)) {
      pageIndex = loopLength - 1;
  }
  else if(pageIndex<0){
      pageIndex = 0;
  }
  
  if (![imgLoadCompletedDic objectForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:pageIndex]]]) {
    
    UIImageView *currentImgView = imgSaveArray[pageIndex];
    
    UProductImageModel *imgModel = productImagesArray[pageIndex];
    
    [currentImgView sd_setImageWithURL:[UComUtil imageUrlAppendString:imgModel.imageUrl withSize:225] placeholderImage:nil];
    
    [imgLoadCompletedDic setObject:currentImgView forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:pageIndex]]];
  };
  
}

//监听播放完成
-(void)movieFinishedCallBack:(NSNotification *)notification
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
  [moviePlayer stop];
  [moviePlayer.view removeFromSuperview];
  moviePlayer = nil;
  
  playBtn.hidden = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
