//
//  UProductMallModel.h
//  UZhong
//
//  Created by jack on 15-3-23.
//  Copyright (c) 2015年 ihaveu. All rights reserved.
//

#import "UBaseModel.h"

@interface UProductMallModel : UBaseModel<MTLJSONSerializing>

@property (strong, nonatomic) NSNumber *mallId;    //卖场ID

@property (strong, nonatomic) NSString *mallName;  //卖场名称

@end
