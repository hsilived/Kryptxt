//
//  CloseButton.m
//  GoWithTheFlow
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "CloseButton.h"

@implementation CloseButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 3);
        self.layer.shadowOpacity = 0.6;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
	float radius = MIN(rect.size.width, rect.size.height) / 2;
	float hWidth = CGRectGetMidX(rect);
	float hHeight = CGRectGetMidY(rect);
	float outerLineWidth = 1.0f;
	float x = radius * 0.35;
	
	CGContextRef c = UIGraphicsGetCurrentContext();

    CGColorRef lightColor = [(self.highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor]) CGColor];
    CGColorRef darkColor = CGColorRetain([[UIColor colorWithRed:154/255.0 green:2/255.0 blue:28/255.0 alpha:1.0] CGColor]);
    
	CGContextSetFillColorWithColor(c, lightColor);
	CGContextSetStrokeColorWithColor(c, darkColor);
	CGContextSetLineWidth(c, outerLineWidth);
	CGContextMoveToPoint(c, hWidth + radius - outerLineWidth, hHeight);
	CGContextAddArc(c, hWidth, hHeight, radius - outerLineWidth, 0, 2 * M_PI, false);
	CGContextDrawPath(c, kCGPathFillStroke);
	
	CGContextSetFillColorWithColor(c, darkColor);
	CGContextMoveToPoint(c, hWidth + (radius * 0.75), hHeight);
	CGContextAddArc(c, hWidth, hHeight, radius * 0.75, 0, 2 * M_PI, false);
	CGContextDrawPath(c, kCGPathFill);
	
	CGContextSetStrokeColorWithColor (c, lightColor);
	CGContextSetLineWidth (c, radius * 0.2);
	CGContextMoveToPoint (c, hWidth - x, hHeight - x);
	CGContextAddLineToPoint (c, hWidth + x, hHeight + x);
	CGContextMoveToPoint (c, hWidth + x, hHeight - x);
	CGContextAddLineToPoint (c, hWidth - x, hHeight + x);
	CGContextDrawPath(c, kCGPathStroke);
}

@end
