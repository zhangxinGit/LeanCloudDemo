//
//  UProductVideoModel.h
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBaseModel.h"

@interface UProductVideoModel : UBaseModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber *videoId;           //视频ID

@property (strong, nonatomic) NSString *swf;               //视频SWF地址

@property (strong, nonatomic) NSString *flv;               //视频FLV地址

@property (strong, nonatomic) NSString *mp4;               //视频MP4地址

@property (strong, nonatomic) NSString *hd;                //视频hd

@property (strong, nonatomic) NSString *has_audio;         //视频是否有声

@property (strong, nonatomic) NSString *videoDescription;  //视频描述

@end
