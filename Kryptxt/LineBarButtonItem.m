//
//  LineBarButtonItem.m
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//


#import "LineBarButtonItem.h"

@interface LineBarButton : UIButton

@property (nonatomic) LineBarButtonItemStyle buttonStyle;
@property (nonatomic,strong) UIColor * buttonNormalColor;
@property (nonatomic,strong) UIColor * buttonHighlightedColor;

- (UIColor *)buttonColorForState:(UIControlState)state;
- (void)setButtonColor:(UIColor *)color forState:(UIControlState)state;

@end

@implementation LineBarButton

@synthesize buttonStyle;

- (id)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame andButtonStyle:LineBarButtonItemStyleSave];
}

- (id)initWithFrame:(CGRect)frame andButtonStyle:(LineBarButtonItemStyle)_buttonStyle {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setButtonNormalColor:[[UIColor whiteColor] colorWithAlphaComponent:0.9f]];
        [self setButtonHighlightedColor:[UIColor colorWithRed:139.0/255.0 green:135.0/255.0 blue:136.0/255.0 alpha:0.9f]];
        [self setButtonStyle:_buttonStyle];
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
    
    if (buttonStyle == LineBarButtonItemStyleList) {

        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.17798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24048 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33750 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30952 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33750 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33750 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.82202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33750 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30952 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24048 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43750 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43750 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.17798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43750 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46548 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53452 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56250 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56250 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.82202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56250 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53452 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43750 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46548 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43750 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66250 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66250 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.17798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66250 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69048 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78750 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75952 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78750 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78750 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.82202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78750 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75952 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.85000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69048 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82202 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66250 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [highlightedColor setFill];
        [bezierPath fill];
        
        
        //// Rounded Rectangle 4 Drawing
        UIBezierPath* roundedRectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.15000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.21250) + 0.5, floor(CGRectGetWidth(frame) * 0.85000 + 0.5) - floor(CGRectGetWidth(frame) * 0.15000 + 0.5), floor(CGRectGetHeight(frame) * 0.33750) - floor(CGRectGetHeight(frame) * 0.21250)) cornerRadius: 2.5];
        [normalColor setFill];
        [roundedRectangle4Path fill];
        
        
        //// Rounded Rectangle 5 Drawing
        UIBezierPath* roundedRectangle5Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.15000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.43750) + 0.5, floor(CGRectGetWidth(frame) * 0.85000 + 0.5) - floor(CGRectGetWidth(frame) * 0.15000 + 0.5), floor(CGRectGetHeight(frame) * 0.56250) - floor(CGRectGetHeight(frame) * 0.43750)) cornerRadius: 2.5];
        [normalColor setFill];
        [roundedRectangle5Path fill];
        
        
        //// Rounded Rectangle 6 Drawing
        UIBezierPath* roundedRectangle6Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.15000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.66250) + 0.5, floor(CGRectGetWidth(frame) * 0.85000 + 0.5) - floor(CGRectGetWidth(frame) * 0.15000 + 0.5), floor(CGRectGetHeight(frame) * 0.78750) - floor(CGRectGetHeight(frame) * 0.66250)) cornerRadius: 2.5];
        [normalColor setFill];
        [roundedRectangle6Path fill];
    }
    else if (buttonStyle == LineBarButtonItemStyleSave) {
        
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPath];
        [ovalPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74749 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25251 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.88417 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61080 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.88417 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38920 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25251 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25251 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61080 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11583 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11583 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25251 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74749 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.11583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38920 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.11583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61080 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74749 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88417 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61080 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88417 * CGRectGetHeight(frame))];
        [ovalPath closePath];
        [normalColor setStroke];
        ovalPath.lineWidth = 2;
        [ovalPath stroke];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23483 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76516 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.08839 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38128 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.08839 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61872 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76516 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76516 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38128 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91161 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61872 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91161 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76516 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23483 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.91161 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61872 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.91161 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38128 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23483 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61872 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08839 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38128 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08839 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [highlightedColor setFill];
        [bezierPath fill];
        
        
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40652 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37456 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71530 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24078 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57904 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24121 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51374 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.22287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56089 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.22306 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53165 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30652 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51418 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49583 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.28860 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49602 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37544 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58470 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34078 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71126 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34121 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.66411 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32287 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69335 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32306 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40652 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72917 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35937 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72898 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38860 * CGRectGetHeight(frame))];
        [bezier4Path closePath];
        [normalColor setFill];
        [bezier4Path fill];
        
        
        //// Bezier 5 Drawing
        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34078 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37544 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58470 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30652 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51418 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24121 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51374 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.28860 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49602 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49583 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24078 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57904 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.22306 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53165 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.22287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56089 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37456 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71530 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40652 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71126 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34121 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72898 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38860 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72917 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35937 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34078 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69335 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32306 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.66411 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32287 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.82500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49820 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50180 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.82599 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67769 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.68129 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82400 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.17500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50180 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32231 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82599 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17600 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68129 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49820 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.17401 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32231 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31871 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17600 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.82500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49820 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.67769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17401 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82400 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31871 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [highlightedColor setFill];
        [bezier5Path fill];
    }
    else if (buttonStyle == LineBarButtonItemStyleEdit) {
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78060 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21940 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32583 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.16036 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.11250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26324 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63750 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21940 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.11250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70009 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.16036 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58184 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79060 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84997 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58048 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75515 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.79180 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85125 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75743 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.78909 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84735 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.75743 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78060 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63750 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.83964 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75083 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.88750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70009 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32583 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78060 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.88750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26324 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.83964 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21250 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [highlightedColor setFill];
        [bezier3Path fill];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34194 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62916 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.86250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68684 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.81773 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.77185 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82497 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.74082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.77053 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82284 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57656 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.77298 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82615 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57529 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73759 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62916 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.18227 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73360 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.13750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68684 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34194 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23750 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.13750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28426 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.18227 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23750 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23750 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34194 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.81773 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23750 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28426 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [normalColor setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
        
        
        //// Bezier 5 Drawing
        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65343 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41566 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64141 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41939 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.63085 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42558 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59268 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46376 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59268 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51124 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72803 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65126 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56982 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69874 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56982 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72803 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51124 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.75732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46376 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65365 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41559 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.70790 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41433 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.67916 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40804 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65343 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41566 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44697 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44697 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46376 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51124 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55303 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47626 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56982 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52374 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56982 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55303 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51124 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.58232 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46376 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44697 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52374 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40518 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47626 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40518 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.24268 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46376 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.24268 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51124 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37803 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30126 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56982 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34874 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56982 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37803 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51124 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46376 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43447 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34874 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40518 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30126 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40518 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35583 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61249 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70583 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66404 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.79582 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70583 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72422 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70583 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.75309 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78744 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72422 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70583 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.75164 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78489 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57128 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70582 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75415 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78853 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57010 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70939 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70583 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61249 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.20418 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70583 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66404 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35583 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26250 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.16250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30429 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.20418 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26250 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26250 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35583 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.79582 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26250 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.83750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30429 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [highlightedColor setFill];
        [bezier5Path fill];
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.25000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.41250) + 0.5, floor(CGRectGetWidth(frame) * 0.40000 + 0.5) - floor(CGRectGetWidth(frame) * 0.25000 + 0.5), floor(CGRectGetHeight(frame) * 0.56250) - floor(CGRectGetHeight(frame) * 0.41250))];
        [normalColor setFill];
        [oval3Path fill];
        
        
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.42500 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.41250) + 0.5, floor(CGRectGetWidth(frame) * 0.57500 + 0.5) - floor(CGRectGetWidth(frame) * 0.42500 + 0.5), floor(CGRectGetHeight(frame) * 0.56250) - floor(CGRectGetHeight(frame) * 0.41250))];
        [normalColor setFill];
        [ovalPath fill];
        
        
        //// Oval 5 Drawing
        UIBezierPath* oval5Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.60000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.41250) + 0.5, floor(CGRectGetWidth(frame) * 0.75000 + 0.5) - floor(CGRectGetWidth(frame) * 0.60000 + 0.5), floor(CGRectGetHeight(frame) * 0.56250) - floor(CGRectGetHeight(frame) * 0.41250))];
        [normalColor setFill];
        [oval5Path fill];
    }
    else if (buttonStyle == LineBarButtonItemStyleAdd) {
        
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPath];
        [ovalPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74749 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25251 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.88417 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61080 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.88417 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38920 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25251 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25251 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61080 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11583 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11583 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25251 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74749 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.11583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38920 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.11583 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61080 * CGRectGetHeight(frame))];
        [ovalPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74749 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74749 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88417 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61080 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88417 * CGRectGetHeight(frame))];
        [ovalPath closePath];
        [normalColor setStroke];
        ovalPath.lineWidth = 2;
        [ovalPath stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54588 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28444 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54611 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45376 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71543 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45353 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76167 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49964 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.74093 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45349 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47414 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54588 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.76170 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52514 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.74106 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54585 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54624 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54611 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54647 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71543 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50036 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76167 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54651 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74093 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52586 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76163 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45412 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47486 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76170 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45415 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74106 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45389 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54624 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28457 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54647 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23833 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50036 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25907 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54651 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.23837 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52586 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45412 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.23830 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47486 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25894 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45415 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45376 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45389 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45353 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28457 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49964 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23833 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45349 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25907 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47414 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23837 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54588 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28444 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52514 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23830 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54585 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25894 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [normalColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23833 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49970 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28445 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54593 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.23830 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52520 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25895 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54590 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45377 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54612 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45357 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71544 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49970 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76167 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45354 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74094 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47419 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76164 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54593 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71555 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52520 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76170 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54590 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74105 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54612 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54623 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71544 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54643 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76167 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50030 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.74094 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54646 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76164 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52581 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71555 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45407 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.76170 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47480 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.74105 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45410 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45388 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54643 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28456 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50030 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23833 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54646 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25906 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52581 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23836 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45407 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28445 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47480 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23830 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45410 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25895 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45388 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45377 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28456 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45357 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23833 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49970 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25906 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45354 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.23836 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47419 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49820 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17500 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.82500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49820 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.67769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17401 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82400 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31871 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50180 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.82599 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67769 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.68129 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82400 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.17500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50180 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32231 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82599 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.17600 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68129 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49820 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.17401 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32231 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31871 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17600 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [highlightedColor setFill];
        [bezier3Path fill];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23483 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76516 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.08839 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38128 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.08839 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61872 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76516 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76516 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38128 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91161 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61872 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91161 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76516 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23483 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.91161 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61872 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.91161 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38128 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23483 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61872 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08839 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38128 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08839 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95523 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04477 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.10000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95523 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04477 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [highlightedColor setFill];
        [bezierPath fill];
    }
    else if (buttonStyle == LineBarButtonItemStyleClose) {
        
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

@interface LineBarButtonItem ()

@property (nonatomic,strong) LineBarButton *lineButton;

@end

@implementation LineBarButtonItem

@synthesize buttonStyle, lineButton, buttonColor, buttonHighlightColor;;

- (id)initWithTarget:(id)target andAction:(SEL)action andStyle:(LineBarButtonItemStyle)style {
    
    lineButton = [[LineBarButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40) andButtonStyle:style];
    [lineButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self = [self initWithCustomView:lineButton];
    
    if (self)
        [self setLineButton:lineButton];

    return self;
}

- (void)setButtonColor:(UIColor *)color {
    
    [self.lineButton setButtonColor:color forState:UIControlStateNormal];
}

- (void)setButtonHighlightColor:(UIColor *)color {
    
    [self.lineButton setButtonColor:color forState:UIControlStateHighlighted];
}

@end