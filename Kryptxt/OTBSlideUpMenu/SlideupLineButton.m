//
//  SlideUpLineButtonItem.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "SlideUpLineButton.h"

@implementation SlideUpLineButton

+ (SlideUpLineButton *)slideUpLineButton:(SlideUpLineButtonStyle)style andTarget:(id)target onDoneSelector:(SEL)done {
    
    SlideUpLineButton *iconButton = [SlideUpLineButton buttonWithType:UIButtonTypeCustom];
    [iconButton addTarget:target action:done forControlEvents:UIControlEventTouchUpInside];
    
    iconButton.frame = CGRectMake(0, 15, 50, 50);
    iconButton.buttonStyle = style;
    [iconButton setButtonNormalColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0]];
    [iconButton setButtonHighlightedColor:[UIColor colorWithRed:252/255.0 green:154/255.0 blue:54/255.0 alpha:1.0]];
    [iconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    iconButton.titleEdgeInsets = UIEdgeInsetsMake(65, 0, 0, 0);
    [iconButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    iconButton.backgroundColor = [UIColor clearColor];
    iconButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return iconButton;
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
    
    [self setTitleColor:[self buttonColorForState:self.state] forState:UIControlStateNormal];
    
    //// Color Declarations
    UIColor* fillColor = [self buttonColorForState:self.state];
    
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
    
    if (self.buttonStyle == SlideUpLineButtonStyleCopy) {
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier 5 Drawing
        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66622 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18889 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44133 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18889 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41874 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18889 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20432 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30618 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30843 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30618 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30618 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.32408 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30631 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27777 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35581 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29278 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30606 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27770 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32965 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27777 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73461 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38198 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27742 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70335 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31866 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27811 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76586 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.29774 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76758 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62533 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33957 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76798 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59555 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76717 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67733 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73033 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65511 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76839 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.67701 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75509 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67733 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64813 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.67765 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70557 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.67733 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64813 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74800 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64808 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59952 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.77058 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64808 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.78889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62020 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31729 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66622 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18889 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [highlightedColor setFill];
        [bezier5Path fill];
        
        
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59021 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72933 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62479 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.76667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60931 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.74995 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62479 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62479 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44820 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57999 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44820 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44820 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.60560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44755 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54265 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40869 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55438 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44886 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54236 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43263 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54265 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54295 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38475 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54265 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41198 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41198 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24445 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21111 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41198 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22536 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.42870 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21111 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21111 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29014 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21111 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65496 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26620 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69200 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65436 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31408 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.66639 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33031 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.71760 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32900 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.76667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21111 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path closePath];
        [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54265 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44820 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62484 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71098 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65466 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62484 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.65495 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68812 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61733 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65437 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73384 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64452 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74612 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33731 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59013 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74500 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35641 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74575 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29998 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71493 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.31821 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74537 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74379 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29998 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36522 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29966 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68608 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30004 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38938 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32798 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29991 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34107 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31369 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32954 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41198 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34227 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32977 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41198 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54265 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32966 * CGRectGetHeight(frame))];
        [bezier4Path closePath];
        bezier4Path.lineJoinStyle = kCGLineJoinBevel;
        
        [normalColor setStroke];
        bezier4Path.lineWidth = 2;
        [bezier4Path stroke];
    }
    else if (self.buttonStyle == SlideUpLineButtonStylePaste) {
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier 5 Drawing
        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51355 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38455 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32926 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24827 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35919 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33578 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22389 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31083 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24827 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25548 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32550 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.26546 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24709 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25541 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27584 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25554 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67304 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25548 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32550 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.25554 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.61512 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31083 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75027 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25554 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73097 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27397 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75027 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.39390 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75027 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43065 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78889 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39396 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77923 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40308 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78889 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68792 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78889 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72468 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75027 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.71549 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78889 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72441 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77261 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72468 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49927 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64255 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40273 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64255 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32550 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64256 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38875 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33601 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58610 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24827 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64171 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29438 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.63452 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24817 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56884 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24827 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58030 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24827 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56884 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24827 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51355 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56219 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22270 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53904 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [highlightedColor setFill];
        [bezier5Path fill];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62757 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40965 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70246 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49891 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64423 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49891 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61096 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46321 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61927 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49895 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61096 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48998 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61096 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62757 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40965 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61096 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70246 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49891 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70246 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73097 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76667 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.70222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75162 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69414 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76667 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43628 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76667 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40301 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73097 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76667 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40307 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75774 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40300 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43643 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42796 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40301 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40965 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40301 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61096 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32781 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34846 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28712 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34535 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27590 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34858 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28757 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35916 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31206 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35069 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29517 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35408 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30433 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35970 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31287 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38620 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32933 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36594 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32198 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37446 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32882 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51133 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32933 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55683 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32883 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56120 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26943 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57701 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56138 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26676 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57169 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62811 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33825 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62084 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26676 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62734 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30948 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62811 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40965 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62837 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34797 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62811 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39672 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61143 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42791 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60075 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.42791 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39176 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43643 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39180 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40965 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73097 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32781 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73097 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27776 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65956 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73097 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27776 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71311 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27770 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33825 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27776 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60601 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27770 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33825 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32781 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27764 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29234 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.28674 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26575 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34846 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28712 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.34441 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26717 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34535 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27610 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35916 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31206 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35073 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29517 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35415 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30433 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.36009 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31345 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38620 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32933 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36599 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32218 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37454 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32910 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51133 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32933 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56138 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32937 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56138 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51133 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55536 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24321 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.39454 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26685 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37159 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35039 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24431 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        bezierPath.lineJoinStyle = kCGLineJoinBevel;
        
        [normalColor setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleTrash) {

        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.41516 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23721 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31111 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31111 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70000 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.28889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73927 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33297 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77778 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.62222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77778 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.66703 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77778 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.71111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73927 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31111 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31111 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23721 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.58484 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20000 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [highlightedColor setFill];
        [bezier3Path fill];
        
        
        //// Bezier 5 Drawing
        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36444 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36444 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36444 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50006 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36444 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36444 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36444 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27556 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27959 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27957 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54424 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59726 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24610 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57352 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45588 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42660 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22222 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40287 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24610 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30736 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30736 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38850 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30736 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72372 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.34369 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75556 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75556 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69276 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68444 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65644 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75556 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69276 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72372 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69276 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.73333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69276 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.65736 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38850 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26767 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30736 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29333 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [normalColor setStroke];
        bezier5Path.lineWidth = 2;
        [bezier5Path stroke];

    }
    else if (self.buttonStyle == SlideUpLineButtonStyleTags) {
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49933 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41248 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54542 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36165 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49994 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41243 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50938 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37288 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56649 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35871 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35972 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55862 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35862 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41384 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61101 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35812 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.63455 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37942 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59026 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.63092 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48492 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59026 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.36586 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41384 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59026 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.36766 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48233 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43274 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35871 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36496 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37942 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38809 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35812 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41380 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.48809 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35739 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49927 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41210 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49933 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41248 * CGRectGetHeight(frame))];
        [bezier4Path closePath];
        [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71568 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16824 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78335 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22355 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75170 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18304 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.78335 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22355 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78335 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78608 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.94005 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37889 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.94005 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63074 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21589 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78608 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62665 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94141 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37259 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94141 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21589 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22355 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.05919 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63074 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.05919 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37889 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30014 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15957 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.24163 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19803 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27001 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17670 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29899 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81079 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30367 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67382 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.29899 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81079 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65551 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70024 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80913 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19139 * CGRectGetHeight(frame))];
        [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69915 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16162 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.71568 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16824 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69915 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16162 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69826 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16063 * CGRectGetHeight(frame))];
        [bezier4Path closePath];
        [highlightedColor setFill];
        [bezier4Path fill];
        
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69972 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14427 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80137 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65251 * CGRectGetHeight(frame))];
        [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80297 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29947 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.80297 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30387 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64060 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09140 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.29938 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13383 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.39900 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09094 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.69972 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09183 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69972 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14427 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43306 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36490 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.36612 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41833 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38837 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36433 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.36522 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38498 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58928 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.36792 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48470 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58928 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63388 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41833 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58928 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.63143 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48721 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56694 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36490 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.63507 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38498 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36433 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54585 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36775 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.55906 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36482 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55206 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36588 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50001 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41829 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50978 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37864 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50033 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41696 * CGRectGetHeight(frame))];
        [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43306 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36490 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49966 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41664 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.48846 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36363 * CGRectGetHeight(frame))];
        [bezier3Path closePath];
        [normalColor setFill];
        [bezier3Path fill];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleDef) {

        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(33.44, 4.09)];
        [bezier3Path addLineToPoint: CGPointMake(33.5, 36.42)];
        [bezier3Path addLineToPoint: CGPointMake(22.5, 28.78)];
        [bezier3Path addLineToPoint: CGPointMake(11.5, 36.5)];
        [bezier3Path addCurveToPoint: CGPointMake(11.51, 4.04) controlPoint1: CGPointMake(11.5, 36.5) controlPoint2: CGPointMake(11.76, 29.66)];
        [bezier3Path addCurveToPoint: CGPointMake(22.5, 1) controlPoint1: CGPointMake(11.51, 3.56) controlPoint2: CGPointMake(17.02, 0.98)];
        [bezier3Path addCurveToPoint: CGPointMake(33.44, 4.09) controlPoint1: CGPointMake(27.75, 1.02) controlPoint2: CGPointMake(33.44, 4.09)];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(22.5, 12.09)];
        [bezier3Path addLineToPoint: CGPointMake(20.09, 16.02)];
        [bezier3Path addLineToPoint: CGPointMake(15.14, 16.85)];
        [bezier3Path addLineToPoint: CGPointMake(18.6, 20.1)];
        [bezier3Path addLineToPoint: CGPointMake(17.95, 24.54)];
        [bezier3Path addLineToPoint: CGPointMake(22.5, 22.62)];
        [bezier3Path addLineToPoint: CGPointMake(27.05, 24.54)];
        [bezier3Path addLineToPoint: CGPointMake(26.4, 20.1)];
        [bezier3Path addLineToPoint: CGPointMake(29.86, 16.85)];
        [bezier3Path addLineToPoint: CGPointMake(24.91, 16.02)];
        [bezier3Path addLineToPoint: CGPointMake(22.5, 12.09)];
        [bezier3Path closePath];
        [fillColor setFill];
        [bezier3Path fill];
        [fillColor setStroke];
        bezier3Path.lineWidth = 0.5;
        [bezier3Path stroke];
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleAcro) {
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(33.44, 4.21)];
        [bezier2Path addLineToPoint: CGPointMake(33.5, 36.42)];
        [bezier2Path addLineToPoint: CGPointMake(22.5, 28.78)];
        [bezier2Path addLineToPoint: CGPointMake(11.5, 36.5)];
        [bezier2Path addCurveToPoint: CGPointMake(11.52, 4.21) controlPoint1: CGPointMake(11.5, 36.5) controlPoint2: CGPointMake(11.76, 29.69)];
        [bezier2Path addCurveToPoint: CGPointMake(22.5, 1.5) controlPoint1: CGPointMake(11.51, 3.68) controlPoint2: CGPointMake(16.97, 1.48)];
        [bezier2Path addCurveToPoint: CGPointMake(33.44, 4.21) controlPoint1: CGPointMake(27.7, 1.52) controlPoint2: CGPointMake(33.44, 4.21)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(18.83, 14.02)];
        [bezier2Path addCurveToPoint: CGPointMake(15.17, 16.76) controlPoint1: CGPointMake(16.39, 13.99) controlPoint2: CGPointMake(15.12, 15.05)];
        [bezier2Path addCurveToPoint: CGPointMake(22.5, 25.53) controlPoint1: CGPointMake(15.27, 20.16) controlPoint2: CGPointMake(22.5, 25.53)];
        [bezier2Path addCurveToPoint: CGPointMake(29.83, 16.76) controlPoint1: CGPointMake(22.5, 25.53) controlPoint2: CGPointMake(29.7, 20.29)];
        [bezier2Path addCurveToPoint: CGPointMake(26.17, 14.02) controlPoint1: CGPointMake(29.9, 15.05) controlPoint2: CGPointMake(28.61, 13.99)];
        [bezier2Path addCurveToPoint: CGPointMake(25.01, 14.16) controlPoint1: CGPointMake(25.74, 14.01) controlPoint2: CGPointMake(25.35, 14.07)];
        [bezier2Path addCurveToPoint: CGPointMake(22.5, 16.76) controlPoint1: CGPointMake(23.04, 14.72) controlPoint2: CGPointMake(22.52, 16.69)];
        [bezier2Path addCurveToPoint: CGPointMake(18.83, 14.02) controlPoint1: CGPointMake(22.48, 16.67) controlPoint2: CGPointMake(21.87, 13.95)];
        [bezier2Path closePath];
        [fillColor setFill];
        [bezier2Path fill];
        [fillColor setStroke];
        bezier2Path.lineWidth = 0.5;
        [bezier2Path stroke];
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleHints) {
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63031 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27193 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63031 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56557 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.70842 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35302 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.70842 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48448 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61933 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57616 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62675 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56927 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62308 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57280 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68056 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75278 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61932 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72044 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.58818 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75278 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54629 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75278 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53193 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77302 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54336 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76017 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53857 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76711 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44585 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77302 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50816 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79418 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79418 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43149 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75278 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76711 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43442 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76017 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42802 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75278 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35845 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68056 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.38960 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75278 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35845 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72044 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35845 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57616 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34747 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56557 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35469 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57280 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35103 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56927 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34747 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27193 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.26936 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48448 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26936 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35302 * CGRectGetHeight(frame))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.63031 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.27193 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42557 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19084 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55221 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19084 * CGRectGetHeight(frame))];
        [bezierPath closePath];
        [normalColor setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
        
        
        //// Text Drawing
        UIBezierPath* textPath = [UIBezierPath bezierPath];
        [textPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40258 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34722 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38437 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37494 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36592 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42810 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30079 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39472 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32853 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40914 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31306 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28238 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44706 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28852 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28238 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55670 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29777 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51797 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28238 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53871 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28751 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59839 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33961 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57469 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30802 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.58859 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32197 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61310 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39711 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60820 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35724 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61310 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37641 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60471 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43996 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61310 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41341 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61030 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42769 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58478 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47173 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59912 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45223 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59248 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46282 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51673 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57708 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48065 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56326 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49565 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53008 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53240 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53782 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52267 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52790 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52267 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54477 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52676 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53691 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52429 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54103 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51890 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55598 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52105 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54851 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.51979 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55224 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51489 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57568 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51801 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55972 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.51667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56629 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60558 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51181 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59561 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60558 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46469 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59581 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47753 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60558 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47044 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60232 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45606 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56676 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45893 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58929 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45606 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57961 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52493 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45606 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55066 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45816 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53672 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.47915 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49387 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46659 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51314 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47218 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50279 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46210 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.48612 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48496 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49552 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47437 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52984 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43780 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51772 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45136 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52522 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44326 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54151 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41954 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53446 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43234 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53835 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42625 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39769 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54467 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41283 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40555 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53178 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35887 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38235 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54143 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36941 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34306 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52214 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34833 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50970 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34306 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45508 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35901 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34306 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46351 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34838 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43369 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40603 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44666 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36965 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43953 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38532 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40233 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43852 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42818 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42769 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41773 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43852 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37936 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39326 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43852 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43473 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40258 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37312 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41959 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41140 * CGRectGetHeight(frame))];
        [textPath closePath];
        [textPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48863 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46274 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70637 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47875 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47012 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71394 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67459 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45537 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69879 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68820 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64411 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66252 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45525 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65236 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48863 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63175 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46951 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63587 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47826 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63175 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64411 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49884 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63175 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50743 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63587 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67459 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65236 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66252 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51391 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70622 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68801 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52121 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69855 * CGRectGetHeight(frame))];
        [textPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48863 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50662 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71389 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49819 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame))];
        [textPath closePath];
        [normalColor setFill];
        [textPath fill];
        
        
        //// Text 2 Drawing
        UIBezierPath* text2Path = [UIBezierPath bezierPath];
        [text2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40258 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38483 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34722 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38437 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37494 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36592 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42810 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30079 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39472 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32853 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.40914 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31306 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28238 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44706 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28852 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46918 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28238 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.55670 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29777 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51797 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28238 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53871 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28751 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.59839 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33961 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57469 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30802 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.58859 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32197 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.61310 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39711 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60820 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35724 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61310 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37641 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.60471 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43996 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.61310 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41341 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61030 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42769 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58478 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47173 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59912 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45223 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59248 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46282 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51673 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57708 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48065 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56326 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49565 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53008 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53240 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53782 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52267 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52790 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52267 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54477 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52676 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53691 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52429 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54103 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51890 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55598 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52105 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54851 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.51979 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55224 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51489 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57568 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51801 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55972 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.51667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56629 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48596 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60558 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51181 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59561 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60558 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46469 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59581 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47753 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60558 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47044 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60232 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45606 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56676 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45893 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58929 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45606 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57961 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52493 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45606 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55066 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45816 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53672 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.47915 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49387 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46659 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51314 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47218 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50279 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46210 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.48612 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48496 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49552 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47437 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52984 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43780 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.51772 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45136 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52522 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44326 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54151 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41954 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53446 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43234 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53835 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42625 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39769 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54467 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41283 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40555 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53178 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35887 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54625 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38235 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54143 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36941 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34306 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52214 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34833 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50970 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34306 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45508 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35901 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34306 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46351 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34838 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43369 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40603 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.44666 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36965 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43953 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38532 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40233 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43852 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42818 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42769 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.41773 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43852 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37936 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.39326 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43852 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38560 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43473 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40258 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37312 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41959 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41140 * CGRectGetHeight(frame))];
        [text2Path closePath];
        [text2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48863 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46274 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70637 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47875 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47012 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71394 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67459 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45537 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69879 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68820 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46238 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64411 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.45168 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66252 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.45525 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65236 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48863 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63175 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46951 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63587 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47826 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63175 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51440 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64411 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.49884 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63175 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50743 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63587 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.52485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.67459 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52137 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65236 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66252 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.51391 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70622 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68801 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52121 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69855 * CGRectGetHeight(frame))];
        [text2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48863 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50662 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71389 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.49819 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71772 * CGRectGetHeight(frame))];
        [text2Path closePath];
        [highlightedColor setFill];
        [text2Path fill];
        
        
        //// Bezier 6 Drawing
        UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
        [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32525 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56557 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.24837 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34824 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.24714 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48448 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33623 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57616 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32881 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56927 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33247 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57280 * CGRectGetHeight(frame))];
        [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68889 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42802 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72878 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38960 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77500 * CGRectGetHeight(frame))];
        [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43149 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77500 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.44585 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79525 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43442 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78239 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43920 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78933 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.53193 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.79525 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46962 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81640 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.50816 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81640 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54629 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77500 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53857 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78933 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54336 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78239 * CGRectGetHeight(frame))];
        [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54976 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77500 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68889 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58797 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77500 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64412 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72848 * CGRectGetHeight(frame))];
        [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64155 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57616 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65253 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56557 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64531 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57280 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64897 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.56927 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.73064 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48448 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.74340 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37260 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26667 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.54886 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12815 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.39608 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18510 * CGRectGetHeight(frame))];
        [bezier6Path closePath];
        [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame))];
        [bezier6Path closePath];
        [highlightedColor setFill];
        [bezier6Path fill];
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleHintsLight) {
        
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(1, 1, 43, 43)];
        [fillColor setStroke];
        ovalPath.lineWidth = 2;
        [ovalPath stroke];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(22.7, 9.71)];
        [bezierPath addCurveToPoint: CGPointMake(18.06, 10.79) controlPoint1: CGPointMake(20.94, 9.71) controlPoint2: CGPointMake(19.39, 10.07)];
        [bezierPath addCurveToPoint: CGPointMake(15.04, 13.52) controlPoint1: CGPointMake(16.74, 11.51) controlPoint2: CGPointMake(15.73, 12.42)];
        [bezierPath addCurveToPoint: CGPointMake(14, 16.77) controlPoint1: CGPointMake(14.35, 14.62) controlPoint2: CGPointMake(14, 15.7)];
        [bezierPath addCurveToPoint: CGPointMake(14.65, 18.22) controlPoint1: CGPointMake(14, 17.29) controlPoint2: CGPointMake(14.22, 17.77)];
        [bezierPath addCurveToPoint: CGPointMake(16.26, 18.89) controlPoint1: CGPointMake(15.09, 18.66) controlPoint2: CGPointMake(15.63, 18.89)];
        [bezierPath addCurveToPoint: CGPointMake(18.45, 16.98) controlPoint1: CGPointMake(17.34, 18.89) controlPoint2: CGPointMake(18.07, 18.25)];
        [bezierPath addCurveToPoint: CGPointMake(19.95, 14.21) controlPoint1: CGPointMake(18.86, 15.76) controlPoint2: CGPointMake(19.36, 14.84)];
        [bezierPath addCurveToPoint: CGPointMake(22.7, 13.27) controlPoint1: CGPointMake(20.54, 13.59) controlPoint2: CGPointMake(21.46, 13.27)];
        [bezierPath addCurveToPoint: CGPointMake(25.31, 14.2) controlPoint1: CGPointMake(23.77, 13.27) controlPoint2: CGPointMake(24.64, 13.58)];
        [bezierPath addCurveToPoint: CGPointMake(26.33, 16.49) controlPoint1: CGPointMake(25.99, 14.82) controlPoint2: CGPointMake(26.33, 15.58)];
        [bezierPath addCurveToPoint: CGPointMake(26.25, 17.11) controlPoint1: CGPointMake(26.33, 16.7) controlPoint2: CGPointMake(26.3, 16.91)];
        [bezierPath addCurveToPoint: CGPointMake(25.99, 17.77) controlPoint1: CGPointMake(26.2, 17.34) controlPoint2: CGPointMake(26.11, 17.56)];
        [bezierPath addCurveToPoint: CGPointMake(25.18, 18.84) controlPoint1: CGPointMake(25.77, 18.16) controlPoint2: CGPointMake(25.5, 18.52)];
        [bezierPath addCurveToPoint: CGPointMake(23.6, 20.27) controlPoint1: CGPointMake(24.85, 19.16) controlPoint2: CGPointMake(24.33, 19.64)];
        [bezierPath addCurveToPoint: CGPointMake(21.63, 22.14) controlPoint1: CGPointMake(22.78, 20.99) controlPoint2: CGPointMake(22.12, 21.62)];
        [bezierPath addCurveToPoint: CGPointMake(20.46, 23.96) controlPoint1: CGPointMake(21.15, 22.66) controlPoint2: CGPointMake(20.75, 23.27)];
        [bezierPath addCurveToPoint: CGPointMake(20.02, 26.42) controlPoint1: CGPointMake(20.17, 24.66) controlPoint2: CGPointMake(20.02, 25.48)];
        [bezierPath addCurveToPoint: CGPointMake(20.13, 27.31) controlPoint1: CGPointMake(20.02, 26.75) controlPoint2: CGPointMake(20.06, 27.05)];
        [bezierPath addCurveToPoint: CGPointMake(20.62, 28.13) controlPoint1: CGPointMake(20.23, 27.64) controlPoint2: CGPointMake(20.4, 27.92)];
        [bezierPath addCurveToPoint: CGPointMake(22.11, 28.71) controlPoint1: CGPointMake(21.02, 28.51) controlPoint2: CGPointMake(21.52, 28.71)];
        [bezierPath addCurveToPoint: CGPointMake(24.13, 26.95) controlPoint1: CGPointMake(23.24, 28.71) controlPoint2: CGPointMake(23.92, 28.12)];
        [bezierPath addCurveToPoint: CGPointMake(24.41, 25.79) controlPoint1: CGPointMake(24.26, 26.4) controlPoint2: CGPointMake(24.35, 26.01)];
        [bezierPath addCurveToPoint: CGPointMake(24.68, 25.13) controlPoint1: CGPointMake(24.47, 25.57) controlPoint2: CGPointMake(24.56, 25.35)];
        [bezierPath addCurveToPoint: CGPointMake(25.19, 24.4) controlPoint1: CGPointMake(24.79, 24.91) controlPoint2: CGPointMake(24.96, 24.67)];
        [bezierPath addCurveToPoint: CGPointMake(26.12, 23.48) controlPoint1: CGPointMake(25.43, 24.14) controlPoint2: CGPointMake(25.74, 23.83)];
        [bezierPath addCurveToPoint: CGPointMake(29.02, 20.84) controlPoint1: CGPointMake(27.52, 22.24) controlPoint2: CGPointMake(28.48, 21.36)];
        [bezierPath addCurveToPoint: CGPointMake(30.41, 18.97) controlPoint1: CGPointMake(29.56, 20.31) controlPoint2: CGPointMake(30.02, 19.69)];
        [bezierPath addCurveToPoint: CGPointMake(31, 16.45) controlPoint1: CGPointMake(30.8, 18.25) controlPoint2: CGPointMake(31, 17.41)];
        [bezierPath addCurveToPoint: CGPointMake(29.97, 13.07) controlPoint1: CGPointMake(31, 15.23) controlPoint2: CGPointMake(30.66, 14.11)];
        [bezierPath addCurveToPoint: CGPointMake(27.06, 10.61) controlPoint1: CGPointMake(29.29, 12.03) controlPoint2: CGPointMake(28.31, 11.21)];
        [bezierPath addCurveToPoint: CGPointMake(22.7, 9.71) controlPoint1: CGPointMake(25.8, 10.01) controlPoint2: CGPointMake(24.35, 9.71)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(22.3, 30.24)];
        [bezierPath addCurveToPoint: CGPointMake(20.46, 30.97) controlPoint1: CGPointMake(21.57, 30.24) controlPoint2: CGPointMake(20.96, 30.49)];
        [bezierPath addCurveToPoint: CGPointMake(19.71, 32.76) controlPoint1: CGPointMake(19.96, 31.46) controlPoint2: CGPointMake(19.71, 32.05)];
        [bezierPath addCurveToPoint: CGPointMake(20.49, 34.63) controlPoint1: CGPointMake(19.71, 33.56) controlPoint2: CGPointMake(19.97, 34.18)];
        [bezierPath addCurveToPoint: CGPointMake(22.3, 35.3) controlPoint1: CGPointMake(21, 35.08) controlPoint2: CGPointMake(21.6, 35.3)];
        [bezierPath addCurveToPoint: CGPointMake(24.06, 34.62) controlPoint1: CGPointMake(22.96, 35.3) controlPoint2: CGPointMake(23.55, 35.07)];
        [bezierPath addCurveToPoint: CGPointMake(24.83, 32.76) controlPoint1: CGPointMake(24.57, 34.17) controlPoint2: CGPointMake(24.83, 33.55)];
        [bezierPath addCurveToPoint: CGPointMake(24.1, 30.97) controlPoint1: CGPointMake(24.83, 32.05) controlPoint2: CGPointMake(24.59, 31.46)];
        [bezierPath addCurveToPoint: CGPointMake(22.3, 30.24) controlPoint1: CGPointMake(23.61, 30.49) controlPoint2: CGPointMake(23.01, 30.24)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(30.63, 9.87)];
        [bezierPath addCurveToPoint: CGPointMake(30.63, 26.13) controlPoint1: CGPointMake(35.12, 14.36) controlPoint2: CGPointMake(35.12, 21.64)];
        [bezierPath addCurveToPoint: CGPointMake(30, 26.72) controlPoint1: CGPointMake(30.43, 26.34) controlPoint2: CGPointMake(30.22, 26.53)];
        [bezierPath addLineToPoint: CGPointMake(30, 32.5)];
        [bezierPath addCurveToPoint: CGPointMake(25, 36.5) controlPoint1: CGPointMake(29.98, 34.73) controlPoint2: CGPointMake(27.2, 36.5)];
        [bezierPath addLineToPoint: CGPointMake(24.8, 36.5)];
        [bezierPath addCurveToPoint: CGPointMake(23.97, 37.62) controlPoint1: CGPointMake(24.63, 36.91) controlPoint2: CGPointMake(24.36, 37.29)];
        [bezierPath addCurveToPoint: CGPointMake(21.03, 37.62) controlPoint1: CGPointMake(23.32, 38.18) controlPoint2: CGPointMake(21.74, 38.23)];
        [bezierPath addCurveToPoint: CGPointMake(20.2, 36.5) controlPoint1: CGPointMake(20.64, 37.29) controlPoint2: CGPointMake(20.37, 36.91)];
        [bezierPath addLineToPoint: CGPointMake(20, 36.5)];
        [bezierPath addCurveToPoint: CGPointMake(15, 32.5) controlPoint1: CGPointMake(17.79, 36.5) controlPoint2: CGPointMake(15, 34.71)];
        [bezierPath addLineToPoint: CGPointMake(15, 26.72)];
        [bezierPath addCurveToPoint: CGPointMake(14.37, 26.13) controlPoint1: CGPointMake(14.78, 26.53) controlPoint2: CGPointMake(14.57, 26.34)];
        [bezierPath addCurveToPoint: CGPointMake(14.37, 9.87) controlPoint1: CGPointMake(9.88, 21.64) controlPoint2: CGPointMake(9.88, 14.36)];
        [bezierPath addCurveToPoint: CGPointMake(30.63, 9.87) controlPoint1: CGPointMake(18.86, 5.38) controlPoint2: CGPointMake(26.14, 5.38)];
        [bezierPath closePath];
        [fillColor setFill];
        [bezierPath fill];
        [fillColor setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleInfo) {
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier 5 Drawing
        UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54714 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29168 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54714 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20653 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26817 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23004 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45286 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20653 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18301 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18301 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45286 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29168 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23004 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.42682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26817 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54714 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29168 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31520 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31520 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74086 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81111 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77966 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81111 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74086 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81111 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77966 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41971 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38091 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame))];
        [bezier5Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41971 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38091 * CGRectGetHeight(frame))];
        [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74086 * CGRectGetHeight(frame))];
        [bezier5Path closePath];
        [normalColor setFill];
        [bezier5Path fill];
        
        
        //// Bezier 6 Drawing
        UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
        [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45286 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20653 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45286 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29168 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23004 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.42682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26817 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54714 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29168 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.47889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31520 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.52111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.31520 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54714 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20653 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26817 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23004 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.45286 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20653 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18301 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.47889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18301 * CGRectGetHeight(frame))];
        [bezier6Path closePath];
        [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41971 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38091 * CGRectGetHeight(frame))];
        [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74086 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81111 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77966 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.46318 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81111 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74086 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81111 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77966 * CGRectGetHeight(frame))];
        [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41971 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.56667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38091 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.53682 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34946 * CGRectGetHeight(frame))];
        [bezier6Path closePath];
        [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame))];
        [bezier6Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame))];
        [bezier6Path closePath];
        [highlightedColor setFill];
        [bezier6Path fill];
        
    }
    else if (self.buttonStyle == SlideUpLineButtonStyleReset) {
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.07778) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.07778) + 0.5, floor(CGRectGetWidth(frame) * 0.92222) - floor(CGRectGetWidth(frame) * 0.07778), floor(CGRectGetHeight(frame) * 0.92222) - floor(CGRectGetHeight(frame) * 0.07778))];
        [normalColor setStroke];
        oval2Path.lineWidth = 2;
        [oval2Path stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.01216 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81427 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.98784 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81427 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64070 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.98784 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35930 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18573 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18573 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64070 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.35930 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.01216 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00029 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95473 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00082 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87778 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.04473 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.99918 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96515 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.12222 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + -0.00150 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04444 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04664 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00001 * CGRectGetHeight(frame))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.87778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000 * CGRectGetHeight(frame))];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.12222 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + -0.00082 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99937 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04362 * CGRectGetHeight(frame))];
        [bezier2Path closePath];
        [highlightedColor setFill];
        [bezier2Path fill];
        
        
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
        [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.23904 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52167 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41111 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25556 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.23401 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40888 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.29799 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29630 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41111 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.52294 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21528 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69928 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.26472 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58889 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74444 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.80298 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60087 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.69619 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70928 * CGRectGetHeight(frame))];
        [bezier4Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.28132 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64092 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.48007 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77979 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33831 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.73749 * CGRectGetHeight(frame))];
        bezier4Path.lineCapStyle = kCGLineCapRound;
        
        bezier4Path.lineJoinStyle = kCGLineJoinBevel;
        
        [normalColor setStroke];
        bezier4Path.lineWidth = 3;
        [bezier4Path stroke];
        
        
        //// Rounded Rectangle 2 Drawing
        UIBezierPath* roundedRectangle2Path = [UIBezierPath bezierPath];
        [roundedRectangle2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55556 * CGRectGetHeight(frame))];
        [roundedRectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35556 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46667 * CGRectGetHeight(frame))];
        [roundedRectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55556 * CGRectGetHeight(frame))];
        [roundedRectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46667 * CGRectGetHeight(frame))];
        [roundedRectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46667 * CGRectGetHeight(frame))];
        [roundedRectangle2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55556 * CGRectGetHeight(frame))];
        [roundedRectangle2Path closePath];
        roundedRectangle2Path.lineCapStyle = kCGLineCapRound;
        
        roundedRectangle2Path.lineJoinStyle = kCGLineJoinBevel;
        
        [normalColor setStroke];
        roundedRectangle2Path.lineWidth = 3;
        [roundedRectangle2Path stroke];
        
        
        //// Bezier 7 Drawing
        UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
        [bezier7Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29572 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21116 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49454 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.20696 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40920 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.21252 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42244 * CGRectGetHeight(frame))];
        [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15778 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44824 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.14958 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44567 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.15522 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44603 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.15240 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44522 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13358 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46462 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.14236 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.44782 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.13686 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45449 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13891 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50660 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.12837 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48074 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.13076 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49953 * CGRectGetHeight(frame))];
        [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.22197 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57864 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24444 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60000 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.22288 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58186 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.24342 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59681 * CGRectGetHeight(frame))];
        [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30527 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54547 * CGRectGetHeight(frame))];
        [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.36737 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48910 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35398 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46313 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37536 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48185 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.36936 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47022 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31167 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46342 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.33860 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45604 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31966 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.45617 * CGRectGetHeight(frame))];
        [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27786 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49411 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34287 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27934 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43922 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30155 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38476 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66662 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34287 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43345 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25608 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57767 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25608 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66662 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65713 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.75557 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42965 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.75557 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57035 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.65713 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57767 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74392 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.43345 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.74392 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.30403 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60370 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32792 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64096 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.31443 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62292 * CGRectGetHeight(frame))];
        [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.24467 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63530 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70428 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.25782 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66010 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27484 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68339 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70428 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70428 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40854 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81709 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59146 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81709 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70428 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29572 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.81709 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59146 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.80641 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39786 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29572 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.29572 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.60214 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19359 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38449 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.18225 * CGRectGetHeight(frame))];
        [bezier7Path closePath];
        [bezier7Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.93905 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78284 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93905 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21716 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62663 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37337 * CGRectGetHeight(frame))];
        [bezier7Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78284 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21716 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37337 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.62663 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06095 * CGRectGetHeight(frame))];
        [bezier7Path closePath];
        [highlightedColor setFill];
        [bezier7Path fill];
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
