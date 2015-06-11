//
//  UProductRefreshControl.h
//  UZhong
//
//  Created by Hanran Liu on 15/3/25.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define REFRESH_JUDGE_VALUE (0.8)

@interface UProductRefreshControl : UIView
@property (weak, nonatomic) IBOutlet UIImageView *controlImage;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, assign) CGFloat rate;

@end
