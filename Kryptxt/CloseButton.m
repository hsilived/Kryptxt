//
//  CloseButton.m
//  Kryptxt
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "CloseButton.h"

@implementation CloseButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setButtonNormalColor:[UIColor colorWithWhite:0.2 alpha:1.0]];
        [self setButtonHighlightedColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
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

- (void)drawRect:(CGRect)rect {
    
    UIColor* highlightedColor;
    UIColor* normalColor;
    
    if (self.state == UIControlStateNormal) {
        
        highlightedColor = [UIColor clearColor];
        normalColor = [self buttonColorForState:self.state];
    }
    else {
        
        highlightedColor = [self buttonColorForState:UIControlStateNormal];
        normalColor = [UIColor clearColor];
    }
    
    //// Frames
    CGRect frame = rect;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73570 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73570 * CGRectGetHeight(frame))];
    [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73570 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26430 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.86588 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60553 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86588 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39447 * CGRectGetHeight(frame))];
    [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26430 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26430 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60553 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13412 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.39447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13412 * CGRectGetHeight(frame))];
    [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26430 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73570 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.13412 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39447 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.13412 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60553 * CGRectGetHeight(frame))];
    [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73570 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73570 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86588 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.60553 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86588 * CGRectGetHeight(frame))];
    [ovalPath closePath];
    [normalColor setStroke];
    ovalPath.lineWidth = 2;
    [ovalPath stroke];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67698 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38716 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56219 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50042 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67545 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61520 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67503 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67739 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69251 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63249 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66033 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67698 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65775 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69445 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62990 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69426 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49958 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56219 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38480 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67545 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32261 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67503 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36751 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69251 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33967 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69232 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32302 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30555 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65775 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30574 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62990 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43781 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49958 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32455 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38480 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32497 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32261 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36751 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33967 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32302 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34225 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30555 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37010 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30574 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50042 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43781 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61520 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32455 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67739 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32497 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.63249 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30749 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.66033 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30768 * CGRectGetHeight(frame))];
    [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67698 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69445 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34225 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69426 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37010 * CGRectGetHeight(frame))];
    [bezier2Path closePath];
    [normalColor setFill];
    [bezier2Path fill];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32497 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32261 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32455 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38480 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33967 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36751 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43781 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49958 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32302 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61284 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32261 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67503 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30574 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62990 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30555 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65775 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38480 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67545 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33967 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69232 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.36751 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69251 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49958 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56219 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67698 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67503 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67739 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62990 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69426 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65775 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69445 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67545 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61520 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66033 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69251 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63249 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56219 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50042 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67698 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38716 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67739 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32497 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69426 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37010 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69445 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34225 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61520 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32455 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.66033 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30768 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.63249 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30749 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50042 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43781 * CGRectGetHeight(frame))];
    [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32302 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32497 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32261 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37010 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30574 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34225 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30555 * CGRectGetHeight(frame))];
    [bezier3Path closePath];
    [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71887 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28113 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71887 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71887 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.83974 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40201 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.83974 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59799 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28113 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71887 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59799 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.83974 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40201 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.83974 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28113 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28113 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.16026 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59799 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.16026 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40201 * CGRectGetHeight(frame))];
    [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71887 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28113 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40201 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16026 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59799 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16026 * CGRectGetHeight(frame))];
    [bezier3Path closePath];
    [highlightedColor setFill];
    [bezier3Path fill];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24746 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24746 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24746 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75254 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.10799 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38693 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.10799 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61307 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75254 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75254 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38693 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89201 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61307 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89201 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75254 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24746 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.89201 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61307 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.89201 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38693 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24746 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24746 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61307 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10799 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38693 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10799 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11905 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88095 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97619 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.97619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93355 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93355 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97619 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97619 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02381 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88095 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06645 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97619 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.02381 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93355 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02381 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11905 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02381 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.02381 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06645 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06645 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02381 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02381 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11905 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93355 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02381 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06645 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    [highlightedColor setFill];
    [bezierPath fill];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

@end
