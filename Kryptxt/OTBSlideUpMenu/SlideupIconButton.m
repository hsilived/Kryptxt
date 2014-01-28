//
//  SlideUpIconButton.m
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-03.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "SlideUpIconButton.h"

@implementation SlideUpIconButton

//@synthesize delegate;

+ (SlideUpIconButton *)slideUpIconButton:(SlideUpIconButtonStyle)style andTarget:(id)target onDoneSelector:(SEL)done {
    
    SlideUpIconButton *iconButton = [SlideUpIconButton buttonWithType:UIButtonTypeCustom];
    [iconButton addTarget:target action:done forControlEvents:UIControlEventTouchUpInside];
    iconButton.frame = CGRectMake(0, 15, 60, 60);
    iconButton.buttonStyle = style;
    [iconButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    iconButton.titleEdgeInsets = UIEdgeInsetsMake(90, -60, 0, 0);
    [iconButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    iconButton.backgroundColor = [UIColor clearColor];
    iconButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    if (style == SlideUpIconButtonStyleMessage) {
        
        [iconButton setImage:[UIImage imageNamed:@"messages-icon"] forState:UIControlStateNormal];
    }
    else if (style == SlideUpIconButtonStyleEmail) {
        
        [iconButton setImage:[UIImage imageNamed:@"email-icon"] forState:UIControlStateNormal];
    }
    else if (style == SlideUpIconButtonStyleFacebook) {
        
        [iconButton setImage:[UIImage imageNamed:@"facebook-icon"] forState:UIControlStateNormal];
    }
    else if (style == SlideUpIconButtonStyleTwitter) {
        
        [iconButton setImage:[UIImage imageNamed:@"twitter-icon"] forState:UIControlStateNormal];
    }
    else if (style == SlideUpIconButtonStyleWhatsApp) {
        
        [iconButton setImage:[UIImage imageNamed:@"whatsapp-icon"] forState:UIControlStateNormal];
    }
    else if (style == SlideUpIconButtonStyleInstagram) {
        
        [iconButton setImage:[UIImage imageNamed:@"instagram-icon"] forState:UIControlStateNormal];
    }
    else if (style == SlideUpIconButtonStylePinterest) {
        
        [iconButton setImage:[UIImage imageNamed:@"pinterest-icon"] forState:UIControlStateNormal];
    }
    else {
        
    }

    return iconButton;
}

@end
