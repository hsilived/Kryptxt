//
//  TagCell.m
//  Kryptxt
//
//  Created by DeviL on 2013-01-25.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell

@synthesize profileLabel;

- (void)setFrame:(CGRect)frame {

    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {

        int inset = IS_IPAD ? 44 : 10;
        frame.origin.x -= inset;
        frame.size.width += 2 * inset;
    }

    CGRect adjustedFrame = self.accessoryView.frame;
    adjustedFrame.origin.x += 20.0f;
    self.accessoryView.frame = adjustedFrame;
    
    [super setFrame:frame];
}

@end
