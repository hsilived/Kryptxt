//
//  Arrow.m
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow

@synthesize arrowBackgroundColor, arrowBorderColor, arrowHighlightColor, arrowDirection;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setArrowBackgroundColor:[UIColor colorWithRed: 1 green: 0.705 blue: 0.114 alpha: 1]];
        [self setArrowBorderColor:[UIColor colorWithRed: 0.2 green: 0 blue: 0 alpha: 1]];
        [self setArrowHighlightColor:[UIColor colorWithWhite:0.3 alpha: 0.509]];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    //self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setArrowBackgroundColor:[UIColor colorWithRed: 1 green: 0.705 blue: 0.114 alpha: 1]];
        [self setArrowBorderColor:[UIColor colorWithRed: 0.2 green: 0 blue: 0 alpha: 1]];
        [self setArrowHighlightColor:[UIColor colorWithWhite:0.3 alpha: 0.509]];
    }
    
    return [self initWithCoder:aDecoder andStyle:ArrowDirectionDown];
}

- (id)initWithCoder:(NSCoder *)aDecoder andStyle:(ArrowDirection)direction {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self setArrowBackgroundColor:[UIColor colorWithRed:1 green:0.705 blue:0.114 alpha: 1]];
        
        if (direction == ArrowDirectionDown) {
            
            [self setArrowBorderColor:[UIColor colorWithWhite:0.2 alpha: 1]];
            [self setArrowHighlightColor:[UIColor colorWithWhite:0.3 alpha: 0.5]];
        }
        else {
            
            [self setArrowBorderColor:[UIColor colorWithWhite: 1.0 alpha: 1]];
            [self setArrowHighlightColor:[UIColor colorWithWhite:1.0 alpha: 0.5]];
        }
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *subview = [super hitTest:point withEvent:event];
    return subview == self.inputTextView ? subview : nil;
    return subview == self.outputTextView ? subview : nil;
    return subview == self.outputTextView ? subview : nil;
}

- (void)setArrowDirection:(ArrowDirection)_arrowDirection {
    
    arrowDirection = _arrowDirection;
    [self setNeedsDisplay];
}

//- (void)setArrowBackgroundColor:(UIColor *)color {
//    
//    arrowBackgroundColor = color;
//    [self setNeedsDisplay];
//}
//
//- (void)setArrowBorderColor:(UIColor *)color {
//    
//    arrowBorderColor = color;
//    [self setNeedsDisplay];
//}
//
//- (void)setArrowHighlightColor:(UIColor *)color {
//    
//    arrowHighlightColor = color;
//    [self setNeedsDisplay];
//}

- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor clearColor];
    [self setArrowBackgroundColor:[UIColor colorWithRed:0.835 green:0.255 blue:0.5 alpha: 1]];
    
    if (arrowDirection == ArrowDirectionDown) {
        
        [self setArrowBorderColor:[UIColor colorWithWhite:0.2 alpha: 1]];
        [self setArrowHighlightColor:[UIColor colorWithWhite:0.3 alpha: 0.5]];
    }
    else {
        
        [self setArrowBorderColor:[UIColor colorWithWhite: 1.0 alpha: 1]];
        [self setArrowHighlightColor:[UIColor colorWithWhite:1.0 alpha: 0.5]];
    }
    
    //// Color Declarations
    UIColor* fillColor = arrowBackgroundColor;
    UIColor* borderColor = arrowBorderColor;
    UIColor* shadow = arrowHighlightColor;
    
    //// Frames
    CGRect frame = rect;
    
    if (arrowDirection == ArrowDirectionDown) {

        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPath];
        [ovalPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95220 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.91194 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97795 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.91608 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89097 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98585 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98246 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89668 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59038 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87511 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68182 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01613 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.12892 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54732 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.01145 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12765 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33835 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74241 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.68290 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01666 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38273 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28601 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55921 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14490 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57384 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.24462 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50677 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.12589 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51842 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95220 * CGRectGetHeight(frame))];
        [ovalPath closePath];
        ovalPath.lineCapStyle = kCGLineCapSquare;
        
        ovalPath.lineJoinStyle = kCGLineJoinRound;
        
        [fillColor setFill];
        [ovalPath fill];
        [borderColor setStroke];
        ovalPath.lineWidth = 5;
        [ovalPath stroke];
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPath];
        [oval3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22928 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95083 * CGRectGetHeight(frame))];
        [oval3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.91093 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97849 * CGRectGetHeight(frame))];
        [oval3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.91583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89153 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98479 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98321 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98859 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.89744 * CGRectGetHeight(frame))];
        [oval3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59028 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87476 * CGRectGetHeight(frame))];
        [oval3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68929 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01604 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.13170 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54848 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.01793 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12849 * CGRectGetHeight(frame))];
        [oval3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22928 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95083 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69037 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01658 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.26503 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43673 * CGRectGetHeight(frame))];
        [oval3Path closePath];
        oval3Path.lineCapStyle = kCGLineCapSquare;
        
        oval3Path.lineJoinStyle = kCGLineJoinRound;
        
        [shadow setFill];
        [oval3Path fill];
    }
    else {

        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPath];
        [ovalPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04355 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.08598 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01631 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.08124 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10328 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01210 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01164 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00847 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09741 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40683 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11984 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30953 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97862 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.13394 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44646 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.01934 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86639 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65795 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25310 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97809 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01464 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61138 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70904 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43641 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42208 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75007 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48894 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86887 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47755 * CGRectGetHeight(frame))];
        [ovalPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04355 * CGRectGetHeight(frame))];
        [ovalPath closePath];
        ovalPath.lineCapStyle = kCGLineCapSquare;
        
        ovalPath.lineJoinStyle = kCGLineJoinRound;
        
        [fillColor setFill];
        [ovalPath fill];
        [borderColor setStroke];
        ovalPath.lineWidth = 5;
        [ovalPath stroke];
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPath];
        [oval3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04622 * CGRectGetHeight(frame))];
        [oval3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.08997 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01634 * CGRectGetHeight(frame))];
        [oval3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.08418 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10328 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01615 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01137 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01148 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09713 * CGRectGetHeight(frame))];
        [oval3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40955 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12111 * CGRectGetHeight(frame))];
        [oval3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30177 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97949 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.13519 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44562 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.02572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86598 * CGRectGetHeight(frame))];
        [oval3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04622 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30069 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97895 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + -0.26967 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55694 * CGRectGetHeight(frame))];
        [oval3Path closePath];
        oval3Path.lineCapStyle = kCGLineCapSquare;
        
        oval3Path.lineJoinStyle = kCGLineJoinRound;
        
        [shadow setFill];
        [oval3Path fill];
    }
}

@end
