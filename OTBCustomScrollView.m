//
//  OTBCustomScrollView.m
//  pageView
//
//  Created by DeviL on 2012-12-25.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBCustomScrollView.h"

@implementation OTBCustomScrollView

- (id)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
if (self) {
// Initialization code
}
return self;
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesMoved:touches withEvent:event];
}
*/

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
if (!self.dragging)
{
[[self nextResponder] touchesEnded:touches withEvent:event];
}
[super touchesEnded:touches withEvent:event];
}

@end
