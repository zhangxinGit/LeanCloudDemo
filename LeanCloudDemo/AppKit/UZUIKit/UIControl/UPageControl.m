//
//  UPageControl.m
//  UZhong
//
//  Created by jack on 15-3-22.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UPageControl.h"

@implementation UPageControl
@synthesize hasVideo;

-(id)init
{
  self = [super init];
  
  _activeImage = [UIImage imageNamed:@"page_indicator_focused.png"];
  
  _inactiveImage = [UIImage imageNamed:@"page_indicator_unfocused.png"];

  _specialActiveImage =[UIImage imageNamed:@"play_video_pressed.png"];
  
  _specialInactiveImage = [UIImage imageNamed:@"play_video.png"];
  
  return self;
}

-(void)setCurrentPage:(NSInteger)currentPage
{
  [super setCurrentPage:currentPage];
  
  [self updateDots];
}

-(void)updateDots
{
  for (int i = 0; i < [self.subviews count]; i++) {
    
    UIView *dotView = [self.subviews objectAtIndex:i];
    [dotView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *dot = nil;
  
    for (UIView *subView in dotView.subviews) {
      if ([subView isKindOfClass:[UIImageView class]]) {
        dot = (UIImageView*)subView;
        break;
      }
    }
    
    if (dot==nil) {
        dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
       [dotView addSubview:dot];
    }
    
    if(hasVideo){
      
      if (i==self.currentPage) {
        if (i==0) {
          dot.image = _specialActiveImage;
        }
        else{
          dot.image = _activeImage;
        }
      }
      else{
        if (i==0) {
          dot.image = _specialInactiveImage;
        }
        else{
          dot.image = _inactiveImage;
        }
      }
    }
    else{
       if (i==self.currentPage) {
          dot.image = _activeImage;
       }
       else{
          dot.image = _inactiveImage;
       }
    }
    
  }
    
}

//for (int i = 0; i < [self.subviews count]; i++) {
//  UIView *dotView = [self.subviews objectAtIndex:i];
//  if ([dotView isKindOfClass:[UIImageView class]]) {
//    UIImageView* dot = (UIImageView*)dotView;
//    dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, _activeImage.size.width, _activeImage.size.height);
//    if (i == self.currentPage)
//      dot.image = _activeImage;
//    else
//      dot.image = _inactiveImage;
//  }
//  else {
//    dotView.frame = CGRectMake(dotView.frame.origin.x, dotView.frame.origin.y, _activeImage.size.width, _activeImage.size.height);
//    if (i == self.currentPage)
//      [dotView setBackgroundColor:[UIColor colorWithPatternImage:_activeImage]];
//    else
//      [dotView setBackgroundColor:[UIColor colorWithPatternImage:_inactiveImage]];
//  }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
