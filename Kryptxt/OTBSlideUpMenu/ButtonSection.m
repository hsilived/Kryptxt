//
//  ButtonSection.m
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-07.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "ButtonSection.h"

@implementation ButtonSection

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
  
    }
    
    return self;
}

- (id)initWithType:(ButtonSectionType)buttonSectionType {
    
    self = [self initWithFrame:CGRectZero];
    
    self.buttonSectionType = buttonSectionType;
    self.scrollEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    if (self.buttonSectionType == ButtonSectionTypeIcon) {
        
        self.buttonSectionHeight = 110;
        self.buttonSectionPadding = 15;
        self.buttonSectionIconWidth = 60;
    }
    else {
        
        self.buttonSectionHeight = 90;
        self.buttonSectionPadding = 15;
        self.buttonSectionIconWidth = 45;
    }
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.buttonSectionHeight, self.buttonSectionHeight)];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:self.contentView];
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.dragging)
        [[self nextResponder] touchesEnded:touches withEvent:event];
    
    [super touchesEnded:touches withEvent:event];
}

@end
