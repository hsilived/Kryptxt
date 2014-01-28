//
//  SlideUpCancelButton.m
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-02.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "SlideUpCancelButton.h"

@implementation SlideUpCancelButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

- (void)setBackgroundColor:(UIColor *) _backgroundColor forState:(UIControlState) _state {
    
    if (backgroundStates == nil)
        backgroundStates = [[NSMutableDictionary alloc] init];
    
    [backgroundStates setObject:_backgroundColor forKey:[NSNumber numberWithInt:_state]];
    
    if (self.backgroundColor == nil)
        [self setBackgroundColor:_backgroundColor];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UIColor *selectedColor = [backgroundStates objectForKey:[NSNumber numberWithInt:UIControlStateHighlighted]];
    
    if (selectedColor) {
        
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setDuration:0.15];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.layer addAnimation:animation forKey:@"EaseOut"];
        self.backgroundColor = selectedColor;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesCancelled:touches withEvent:event];
    
    UIColor *normalColor = [backgroundStates objectForKey:[NSNumber numberWithInt:UIControlStateNormal]];
    
    if (normalColor) {
        
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.layer addAnimation:animation forKey:@"EaseOut"];
        self.backgroundColor = normalColor;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    UIColor *normalColor = [backgroundStates objectForKey:[NSNumber numberWithInt:UIControlStateNormal]];
    
    if (normalColor) {
        
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.layer addAnimation:animation forKey:@"EaseOut"];
        self.backgroundColor = normalColor;
    }
}

@end
