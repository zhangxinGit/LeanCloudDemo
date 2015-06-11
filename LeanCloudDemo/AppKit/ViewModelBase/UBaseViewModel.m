//
//  UBaseViewModel.m
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/16.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import "UBaseViewModel.h"

@implementation UBaseViewModel

#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (SuccessValueBlock) successBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
  _successBlock = successBlock;
  _errorBlock = errorBlock;
  _failureBlock = failureBlock;
}

@end
