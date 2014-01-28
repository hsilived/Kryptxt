//
//  HorizontalLine.m
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-02.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "HorizontalLine.h"

@implementation HorizontalLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setLineColor:[UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:0.7]];
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* fillColor = self.lineColor;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.origin.x + 10, 0, self.frame.size.width - 20, self.frame.size.height) cornerRadius: 2];
    [fillColor setFill];
    [roundedRectanglePath fill];
    
//    //// Color Declarations
//    UIColor* strokeColor = self.lineColor;
//    
//    //// Bezier Drawing
//    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
//    [bezierPath moveToPoint: CGPointMake(10, 0)];
//    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width - 20, 0)];
//    [strokeColor setStroke];
//    bezierPath.lineWidth = 2;
//    [bezierPath stroke];
}

@end
