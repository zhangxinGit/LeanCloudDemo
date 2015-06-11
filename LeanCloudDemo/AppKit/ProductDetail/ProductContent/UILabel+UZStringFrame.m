//
//  UILabel+StringFrame.m
//  Udemo
//
//  Created by Mac on 15-3-23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "UILabel+UZStringFrame.h"

@implementation UILabel (UZStringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:NSStringDrawingTruncatesLastVisibleLine |
                                                     NSStringDrawingUsesLineFragmentOrigin |
                                                     NSStringDrawingUsesFontLeading
                                             attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
@end
