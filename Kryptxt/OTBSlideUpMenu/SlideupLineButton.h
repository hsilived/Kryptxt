//
//  SlideUpLineButton.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {

    SlideUpLineButtonStyleTrash,
    SlideUpLineButtonStyleCopy,
    SlideUpLineButtonStylePaste,
    SlideUpLineButtonStyleTags,
    SlideUpLineButtonStyleAcro,
    SlideUpLineButtonStyleDef,
    SlideUpLineButtonStyleInfo,
    SlideUpLineButtonStyleHints,
    SlideUpLineButtonStyleHintsLight,
    SlideUpLineButtonStyleReset
} SlideUpLineButtonStyle;

@interface SlideUpLineButton : UIButton {
    
}

@property (nonatomic, assign) NSUInteger buttonStyle;
@property (nonatomic,strong) UIColor * buttonNormalColor;
@property (nonatomic,strong) UIColor * buttonHighlightedColor;

+ (SlideUpLineButton *)slideUpLineButton:(SlideUpLineButtonStyle)style andTarget:(id)target onDoneSelector:(SEL)done;

- (UIColor *)buttonColorForState:(UIControlState)state;
- (void)setButtonColor:(UIColor *)color forState:(UIControlState)state;

@end
