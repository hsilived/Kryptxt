//
//  SlideUpHandleButton.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "SlideUpHandleButton.h"


@implementation SlideUpHandleButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        self.buttonStyle = SlideUpHandleButtonStyleOpen;
        [self setButtonNormalColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:0.85]];
        [self setButtonHighlightedColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:0.85]];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTarget:(id)target andAction:(SEL)action {
    
    self = [self initWithFrame:frame];
    
    if (self)
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

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
    
    //// Color Declarations
    UIColor* fillColor = [self buttonColorForState:self.state];
    
    if (self.buttonStyle == SlideUpHandleButtonStyleClose) {
        
        //// Rounded Rectangle Drawing
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPath];
        [roundedRectanglePath moveToPoint: CGPointMake(10, 15)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(15, 20) controlPoint1: CGPointMake(10, 17.76) controlPoint2: CGPointMake(12.24, 20)];
        [roundedRectanglePath addLineToPoint: CGPointMake(30.08, 24)];
        [roundedRectanglePath addLineToPoint: CGPointMake(45, 20)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(50, 15) controlPoint1: CGPointMake(47.76, 20) controlPoint2: CGPointMake(50, 17.76)];
        [roundedRectanglePath addLineToPoint: CGPointMake(50, 15)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(45, 10) controlPoint1: CGPointMake(50, 12.24) controlPoint2: CGPointMake(47.76, 10)];
        [roundedRectanglePath addLineToPoint: CGPointMake(30.04, 14)];
        [roundedRectanglePath addLineToPoint: CGPointMake(15, 10)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(10, 15) controlPoint1: CGPointMake(12.24, 10) controlPoint2: CGPointMake(10, 12.24)];
        [roundedRectanglePath closePath];
        [fillColor setFill];
        [roundedRectanglePath fill];
    }
    else {
        
        //// Rounded Rectangle Drawing
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(10, 10, 40, 10) cornerRadius: 5];
        [fillColor setFill];
        [roundedRectanglePath fill];
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
