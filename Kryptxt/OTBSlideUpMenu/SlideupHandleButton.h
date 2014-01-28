//
//  SlideUpHandleButton.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    
    SlideUpHandleButtonStyleOpen, // Default
    SlideUpHandleButtonStyleClose,

} SlideUpHandleButtonStyle;

@interface SlideUpHandleButton : UIButton {
    
}

@property (nonatomic, assign) NSUInteger buttonStyle;
@property (nonatomic,strong) UIColor *buttonNormalColor;
@property (nonatomic,strong) UIColor *buttonHighlightedColor;

- (id)initWithFrame:(CGRect)frame andTarget:(id)target andAction:(SEL)action;

- (UIColor *)buttonColorForState:(UIControlState)state;
- (void)setButtonColor:(UIColor *)color forState:(UIControlState)state;

@end
