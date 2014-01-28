//
//  InfoButton.m
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "InfoButton.h"

@implementation InfoButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setButtonNormalColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:0.9f]];
        [self setButtonHighlightedColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.9f]];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {

    self = [super initWithCoder:coder];
    
    if (self) {
        
        [self setButtonNormalColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:0.9f]];
        [self setButtonHighlightedColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.9f]];
    }
    
    return self;
}

- (UIColor *)buttonColorForState:(UIControlState)state {
    
    UIColor * color;
    
    switch (state) {
            
        case UIControlStateNormal:
            color = self.buttonNormalColor;
            break;
        case UIControlStateHighlighted:
            color = self.buttonHighlightedColor;
            break;
        default:
            break;
    }
    return color;
}

- (void)setButtonColor:(UIColor *)color forState:(UIControlState)state {
    
    switch (state) {
            
        case UIControlStateNormal:
            [self setButtonNormalColor:color];
            break;
        case UIControlStateHighlighted:
            [self setButtonHighlightedColor:color];
            break;
        default:
            break;
    }
    
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    UIColor* fillColor = [self buttonColorForState:self.state];

    //// Frames
    CGRect frame = rect;
    
    /// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48545 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24966 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64362 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37305 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79486 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49105 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79942 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49460 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.79657 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49223 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.79809 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49342 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80177 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49644 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80601 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50485 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.80500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49895 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.80635 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50180 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.80177 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51326 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.80635 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50790 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.80500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51075 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79941 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51510 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79487 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51865 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.79809 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51628 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.79657 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51746 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64362 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63664 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48545 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76004 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37901 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75984 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47083 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77138 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.42317 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77129 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32550 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71856 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33484 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74838 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31088 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72990 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59460 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59943 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50485 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41510 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32550 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29114 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37901 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24986 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.31088 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27979 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33484 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26132 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48545 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42317 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23841 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47083 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23832 * CGRectGetHeight(frame))];
    [bezierPath closePath];

    [fillColor setFill];
    [bezierPath fill];
}

@end
