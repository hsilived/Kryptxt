//
//  OTBNavigationTitle.m
//  Kryptxt
//
//  Created by DeviL on 2013-07-15.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "OTBNavigationTitle.h"

@implementation OTBNavigationTitle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 0.657 green: 0 blue: 0 alpha: 1];
    
    //// Abstracted Attributes
    NSString* textContent = @"Kryptxt";
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(0, 0, 129, 59);
    [color2 setFill];
    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Capture it" size: 32] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
    
    

}


@end
