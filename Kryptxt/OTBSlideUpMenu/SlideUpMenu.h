//
//  SlideUpMenu.h
//  SlideUpMenu
//
//  Created by DeviL on 2013-09-06.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SlideUpHandleButton.h"
#import "SlideUpCancelButton.h"
#import "HorizontalLine.h"
#import "SlideUpLineButton.h"
#import "SlideUpIconButton.h"
#import "ButtonSection.h"
#import "UIImage+ImageEffects.h"

@protocol SlideUpMenuDelegate<NSObject>;

@optional

- (void)slideUpMenuOpened;
- (void)slideUpMenuClosed;

@end

typedef enum {
    
    BlurTypeLight, // Default
    BlurTypeDark,
} BlurType;

@interface SlideUpMenu : UIView <UIScrollViewDelegate> {

    UIButton *backgroundButton;
    UIView *slideUpMenu;
    UIView *blurView;
    UIImageView *blurImageView;
    UIView *blanco;
    SlideUpHandleButton *openSlideUpHandleButton;
    SlideUpHandleButton *closeSlideUpHandleButton;
    UIButton *handle;
    SlideUpCancelButton *cancelSlideUpLineButton;
    HorizontalLine *divider;

    float slideUpHeight;
    int offSet;
    CGSize openSize;
    int cancelButtonHeight;
    int handleHeight;
    CGFloat closedPosition;
    int dividerHeight;
    UIView *parentView;
}

@property (nonatomic, assign) NSObject<SlideUpMenuDelegate> *delegate;
@property (nonatomic) BOOL isOpen;
@property (nonatomic) BOOL dragged;
@property (nonatomic) BOOL showHighlights;
@property (nonatomic) BOOL testMode;
@property (nonatomic) BOOL blur;
@property (nonatomic) BlurType blurType;
@property (nonatomic) float startY;
@property (nonatomic) float menuTransparency;
@property (nonatomic) CGSize screen;
@property (nonatomic) CGFloat menuBackgroundColor;
@property (strong, nonatomic) NSArray *sections;
@property (nonatomic) float contentWidth;
@property (strong, nonatomic) ButtonSection *iconButtonSection;
@property (strong, nonatomic) ButtonSection *lineButtonSection;


#pragma mark - Opening and Closing

+ (id)SlideUpMenuWithDelegate:(id <SlideUpMenuDelegate>)dlg;
- (void)presentInView:(UIView *)_parentview;
- (void)reloadMenu;
- (CGSize)currentSize;

- (void)openMenu;
- (void)closeMenu;

@end
