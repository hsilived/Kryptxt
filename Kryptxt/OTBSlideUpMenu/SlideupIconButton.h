//
//  SlideUpIconButton.h
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-03.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    SlideUpIconButtonStyleMessage,
    SlideUpIconButtonStyleEmail,
    SlideUpIconButtonStyleFacebook,
    SlideUpIconButtonStyleTwitter,
    SlideUpIconButtonStylePinterest,
    SlideUpIconButtonStyleWhatsApp,
    SlideUpIconButtonStyleInstagram,
} SlideUpIconButtonStyle;


@interface SlideUpIconButton : UIButton { }

@property (nonatomic, assign) NSUInteger buttonStyle;

+ (SlideUpIconButton *)slideUpIconButton:(SlideUpIconButtonStyle)style andTarget:(id)target onDoneSelector:(SEL)done;

@end
