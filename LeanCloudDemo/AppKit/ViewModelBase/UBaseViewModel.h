//
//  UBaseViewModel.h
//  UZhongDemo
//
//  Created by Hanran Liu on 15/1/16.
//  Copyright (c) 2015年 ran. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ULoadingState) {
  ULoadingStateBegin = 1,
  ULoadingStateSuccess,
  ULoadingStateFailure
};

@interface UBaseViewModel : NSObject

@property (strong, nonatomic) SuccessValueBlock successBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailureBlock failureBlock;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (SuccessValueBlock) successBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

@end
