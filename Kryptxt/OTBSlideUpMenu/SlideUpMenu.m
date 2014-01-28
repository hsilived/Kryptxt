//
//  SlideUpMenu.m
//  SlideUpMenu
//
//  Created by DeviL on 2013-09-06.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "SlideUpMenu.h"

#define IS_IPAD UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

#ifdef __IPHONE_7_0
# define ALIGN_CENTER NSTextAlignmentCenter
#else
# define ALIGN_CENTER NSTextAlignmentCenter
#endif

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#pragma mark - Main Controller

@implementation SlideUpMenu

@synthesize delegate, isOpen, dragged, showHighlights, startY, screen, testMode, blur, blurType;
@synthesize lineButtonSection,  iconButtonSection, sections, menuTransparency, menuBackgroundColor, contentWidth;

#pragma mark - Opening and Closing

+ (id)SlideUpMenuWithDelegate:(id <SlideUpMenuDelegate>)dlg {
    
    SlideUpMenu *menu = [[SlideUpMenu alloc] init];
    menu.backgroundColor = [UIColor clearColor];
    menu.delegate = dlg;
    
    return menu;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        screen = [self currentSize];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            offSet = 20;

        startY = 0;
        openSize = CGSizeMake(60, 30);
        cancelButtonHeight = 53;
        handleHeight = 30;
        closedPosition = offSet + screen.height + 1 - handleHeight;
        
        iconButtonSection = [[ButtonSection alloc] initWithType:ButtonSectionTypeIcon];
        lineButtonSection = [[ButtonSection alloc] initWithType:ButtonSectionTypeLine];
        
        testMode = NO;
        showHighlights = NO;
        dividerHeight = 4;
        slideUpHeight = handleHeight + iconButtonSection.buttonSectionHeight + dividerHeight + lineButtonSection.buttonSectionHeight + cancelButtonHeight;
        isOpen = NO;
        blur = NO;
        menuTransparency = 0.95f;
        menuBackgroundColor = 0.96f;
        contentWidth = screen.width;
        
        [self setNeedsDisplay];
    }
    return self;
}

- (void)presentInView:(UIView *)_parentview {
    
    screen = [self currentSize];

    self.frame = CGRectMake(0, offSet + screen.height + 1 - handleHeight, screen.width, offSet + screen.height);
    //self.backgroundColor = testMode ? [UIColor magentaColor] : [UIColor colorWithWhite:.95 alpha:0.3];
    //DLogRect(self.frame);
    //self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;// | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [self setNeedsDisplay];
    parentView = _parentview;
    
    [self loadSlideUpMenu];
    
    if (sections) {
        
        [self createButtonsFromArray:[sections objectAtIndex:0] inSection:iconButtonSection];
        [self createButtonsFromArray:[sections objectAtIndex:1] inSection:lineButtonSection];
    }
    
    if (blur)
        [self captureBlur];
}

- (void)captureBlur {
    
    blurView.alpha = 0;
    slideUpMenu.hidden = YES;
    
    UIGraphicsBeginImageContext(screen);
    [parentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    slideUpMenu.hidden = NO;
    UIImage *resultImage;

    resultImage = blurType == BlurTypeLight ? [sourceImage applyLightEffect] : [sourceImage applyDarkEffect];

    blurImageView.image = resultImage;//[UIImage imageWithCGImage:imageRef];

    blurView.alpha = 1.0;
}

- (void)reloadMenu {
    
    //this is for after the screen has rotated so it that it can get the new dimensions
    screen = [self currentSize];
    closedPosition = offSet + screen.height + 1 - handleHeight;
    
    if (isOpen) {
        
        self.frame = CGRectMake(0, 0, screen.width, offSet + screen.height);
        slideUpMenu.frame = CGRectMake(0, offSet + screen.height - slideUpHeight, screen.width, slideUpHeight);
        
        backgroundButton.hidden = NO;
        backgroundButton.frame = CGRectMake(0, 0, self.frame.size.width, slideUpMenu.frame.origin.y);
    }
    else {
        
        self.frame = CGRectMake(0, closedPosition, screen.width, offSet + screen.height);
        slideUpMenu.frame = CGRectMake(0, 0, screen.width, slideUpHeight);
    }

    if (blur)
        [self captureBlur];
    
    contentWidth = screen.width;
    startY = 0;
    [self stopHighlights];
    [self adjustSlidingContentInSection:iconButtonSection];
    [self adjustSlidingContentInSection:lineButtonSection];
    [self setNeedsDisplay];
}

- (CGSize)currentSize {
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        size = CGSizeMake(size.height, size.width);
    
    if (!application.statusBarHidden)
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    
    return size;
}

- (void)loadSlideUpMenu {

    //[menu addTarget:self action:@selector(wasDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - slideUpMenu.frame.origin.y)];
    backgroundButton.backgroundColor = testMode ? [UIColor blueColor] : [UIColor clearColor];
    [backgroundButton addTarget:self action:@selector(wasDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [backgroundButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    backgroundButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    backgroundButton.hidden = YES;
    [self addSubview:backgroundButton];
    
    slideUpMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.width, screen.height)];
    slideUpMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    slideUpMenu.backgroundColor = [UIColor colorWithWhite:menuBackgroundColor alpha:testMode ? 0.8 : 0.3];
    slideUpMenu.clipsToBounds = YES;
    [self addSubview:slideUpMenu];
 
    if (blur) {
        
        blurView = [[UIView alloc] initWithFrame:CGRectMake(0, -screen.height + handleHeight, screen.width, offSet + screen.height)];
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [slideUpMenu addSubview:blurView];
        blurView.hidden = YES;
        
        blurImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen.width, offSet + screen.height)];
        blurImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [blurView addSubview:blurImageView];
        
        blanco = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.width, offSet + screen.height)];
        blanco.backgroundColor = [UIColor colorWithWhite:menuBackgroundColor alpha:0.10];
        blanco.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [blurView addSubview:blanco];
    }
    
    //buttons and handle
    openSlideUpHandleButton = [[SlideUpHandleButton alloc] initWithFrame:CGRectMake((screen.width / 2) - (openSize.width / 2), 0, openSize.width, openSize.height)];
    openSlideUpHandleButton.buttonStyle = SlideUpHandleButtonStyleOpen;
    [openSlideUpHandleButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchDragExit];
    openSlideUpHandleButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    openSlideUpHandleButton.buttonNormalColor = [UIColor colorWithRed:(1.0 - menuBackgroundColor) * 255/255.0 green:(1.0 - menuBackgroundColor) * 255/255.0 blue:(1.0 - menuBackgroundColor) * 255/255.0 alpha:.7];
    openSlideUpHandleButton.showsTouchWhenHighlighted = showHighlights;
    [slideUpMenu addSubview:openSlideUpHandleButton];
    
    closeSlideUpHandleButton = [[SlideUpHandleButton alloc] initWithFrame:CGRectMake((screen.width / 2) - (openSize.width / 2), 0, openSize.width, openSize.height)];
    closeSlideUpHandleButton.buttonStyle = SlideUpHandleButtonStyleClose;
    [closeSlideUpHandleButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchDragExit];
    closeSlideUpHandleButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    closeSlideUpHandleButton.showsTouchWhenHighlighted = showHighlights;
    closeSlideUpHandleButton.buttonNormalColor = [UIColor colorWithRed:(1.0 - menuBackgroundColor) * 255/255.0 green:(1.0 - menuBackgroundColor) * 255/255.0 blue:(1.0 - menuBackgroundColor) * 255/255.0 alpha:.7];
    [slideUpMenu addSubview:closeSlideUpHandleButton];
    closeSlideUpHandleButton.hidden = YES;

    handle = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screen.width, handleHeight)];
    [handle addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [handle addTarget:self action:@selector(wasDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    handle.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    handle.showsTouchWhenHighlighted = showHighlights;
    [slideUpMenu addSubview:handle];
    
    iconButtonSection.frame = CGRectMake(0, handleHeight, contentWidth, iconButtonSection.buttonSectionHeight);
    iconButtonSection.hidden = YES;
    [slideUpMenu addSubview:iconButtonSection];
    
    divider = [[HorizontalLine alloc] initWithFrame:CGRectMake(0, handleHeight + iconButtonSection.buttonSectionHeight, contentWidth, dividerHeight)];
    [slideUpMenu addSubview:divider];
    
    lineButtonSection.frame = CGRectMake(0, handleHeight + iconButtonSection.buttonSectionHeight + divider.frame.size.height, contentWidth, lineButtonSection.buttonSectionHeight);
    lineButtonSection.hidden = YES;
    [slideUpMenu addSubview:lineButtonSection];
    
    cancelSlideUpLineButton = [[SlideUpCancelButton alloc] initWithFrame:CGRectMake(0, slideUpHeight - cancelButtonHeight, screen.width, cancelButtonHeight)];
    [cancelSlideUpLineButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelSlideUpLineButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [slideUpMenu addSubview:cancelSlideUpLineButton];
}

- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event {
    
    openSlideUpHandleButton.highlighted = YES;
    
    slideUpMenu.backgroundColor = [UIColor colorWithWhite:menuBackgroundColor alpha:menuTransparency];
    //TODO: should probably make this dynamic so that I could add button rows
    iconButtonSection.hidden = NO;
    lineButtonSection.hidden = NO;
    
    openSlideUpHandleButton.hidden = NO;
    closeSlideUpHandleButton.hidden = YES;
    
	// get the touch
	UITouch *touch = [[event touchesForView:button] anyObject];
    
    if ([touch view] == handle) {

        dragged = YES;
        
        if (blur)
            blurView.hidden = NO;
        
        if (!isOpen) {
           
            if ([delegate respondsToSelector:@selector(slideUpMenuOpened)])
                [delegate slideUpMenuOpened];
            
            self.frame = CGRectMake(0, 0, screen.width, offSet + screen.height);
            slideUpMenu.frame = CGRectMake(0, closedPosition, screen.width, slideUpHeight);
        }
        
        CGPoint previousLocation = [touch previousLocationInView:self];
        CGPoint location = [touch locationInView:self];
        CGFloat delta_y = location.y - previousLocation.y;

        if (startY == 0)
            startY = slideUpMenu.frame.origin.y;

        startY = startY + delta_y;

        slideUpMenu.frame = CGRectMake(0, startY, slideUpMenu.frame.size.width, screen.height);
        blurView.frame = CGRectMake(0, -startY, blurView.frame.size.width, offSet + screen.height);
    }
    else if ([touch view] == backgroundButton) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGPoint previousLocation = [touch previousLocationInView:self];
        CGPoint location = [touch locationInView:self];
        CGFloat delta_y = location.y - previousLocation.y;
        
        if (startY == 0)
            startY = self.frame.origin.y;
        
        startY = startY + delta_y;

        self.frame = CGRectMake(0, startY, self.frame.size.width, offSet + screen.height);
        blurView.frame = CGRectMake(0, blurView.frame.origin.y - delta_y, screen.width, offSet + screen.height);
    }
}

- (void)openMenu {
    
    if (!isOpen) {
        
        if ([delegate respondsToSelector:@selector(slideUpMenuOpened)])
            [delegate slideUpMenuOpened];
        
        //opening menu
        isOpen = YES;
        slideUpMenu.backgroundColor = [UIColor colorWithWhite:menuBackgroundColor alpha:menuTransparency];
        
        //TODO: should probably make this dynamic so that I could add button rows
        iconButtonSection.hidden = NO;
        lineButtonSection.hidden = NO;
        
        openSlideUpHandleButton.highlighted = YES;

        if (blur)
            blurView.hidden = NO;
        
        if (!dragged) {
            
            self.frame = CGRectMake(0, 0, screen.width, offSet + screen.height);

            slideUpMenu.frame = CGRectMake(0, closedPosition, screen.width, slideUpHeight);
            blurView.frame = CGRectMake(0, [parentView convertPoint:blurView.frame.origin toView:parentView].y, screen.width, offSet + screen.height);
        }
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            // animation code
            slideUpMenu.frame = CGRectMake(0, offSet + screen.height - slideUpHeight, screen.width, offSet + screen.height);
            blurView.frame = CGRectMake(0, -(offSet + screen.height - slideUpHeight), screen.width, offSet + screen.height);
            self.backgroundColor = testMode ? [UIColor magentaColor] : [UIColor colorWithWhite:0 alpha:0.2];
            
            backgroundButton.hidden = NO;
            backgroundButton.frame = CGRectMake(0, 0, self.frame.size.width, slideUpMenu.frame.origin.y);
        }
             completion:^(BOOL finished){
                 
                 // completion code
                 backgroundButton.hidden = NO;
                 closeSlideUpHandleButton.hidden = NO;
                 openSlideUpHandleButton.hidden = YES;
             }];
    }
    else {
        
        //closing menu
        [self closeMenu];
    }
    
    startY = 0;
    dragged = NO;
    [self stopHighlights];
}

- (void)closeMenu {
    
   //closing menu
    isOpen = NO;
    
    backgroundButton.hidden = YES;
    openSlideUpHandleButton.hidden = NO;
    closeSlideUpHandleButton.hidden = YES;
    closeSlideUpHandleButton.highlighted = NO;
    openSlideUpHandleButton.highlighted = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        // animation code
        self.frame = CGRectMake(0, closedPosition, screen.width, offSet + screen.height);
        slideUpMenu.frame = CGRectMake(0, 0, screen.width, screen.height);
        blurView.frame = CGRectMake(0, -closedPosition, screen.width, offSet + screen.height);
    }
         completion:^(BOOL finished){
             
             //TODO: should probably make this dynamic so that I could add button rows
             if (!isOpen) {
                 
                 slideUpMenu.backgroundColor = [UIColor colorWithWhite:menuBackgroundColor alpha:testMode ? 0.5 : 0.3];
                 
                 iconButtonSection.hidden = YES;
                 lineButtonSection.hidden = YES;
                 blurView.hidden = YES;
             }
         }];
    
    if ([delegate respondsToSelector:@selector(slideUpMenuClosed)])
        [delegate performSelector:@selector(slideUpMenuClosed) withObject:nil afterDelay:0.0];
    
    startY = 0;
    dragged = NO;
    [self stopHighlights];
}


- (void)stopHighlights {

    handle.highlighted = NO;
    openSlideUpHandleButton.highlighted = NO;
    closeSlideUpHandleButton.highlighted = NO;
}

#pragma mark - Load Icons

- (void)createButtonsFromArray:(NSArray *)buttons inSection:(ButtonSection *)section {
    
    if (buttons) {
        
        int numberOfButtons = buttons.count;
        
        int _contentWidth = (section.buttonSectionIconWidth + section.buttonSectionPadding) * numberOfButtons + section.buttonSectionPadding;
        
        section.contentView.frame = CGRectMake(0, 0, _contentWidth, section.buttonSectionHeight);
        
        //[section addSubview:section.contentView];
        
        NSUInteger i = 0;
        
        while (i < numberOfButtons) {
            
            int buttonTotalWidth = section.buttonSectionPadding + ((section.buttonSectionIconWidth + section.buttonSectionPadding) * i);
            
            if (section.buttonSectionType == ButtonSectionTypeIcon) {
                
                SlideUpIconButton *button = [SlideUpIconButton slideUpIconButton:((SlideUpIconButtonStyle)[[[buttons objectAtIndex:i] objectAtIndex:0] integerValue]) andTarget:delegate onDoneSelector:((SEL) NSSelectorFromString([[buttons objectAtIndex:i] objectAtIndex:2]))];
                button.frame = CGRectOffset(button.frame, buttonTotalWidth, 0);
                button.backgroundColor = [UIColor clearColor];
                [button setTitle:[[buttons objectAtIndex:i] objectAtIndex:1] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:(1.0 - menuBackgroundColor) * 255/255.0 green:(1.0 - menuBackgroundColor) * 255/255.0 blue:(1.0 - menuBackgroundColor) * 255/255.0 alpha:.95] forState:UIControlStateNormal];
                [section.contentView addSubview:button];
            }
            else {
                
                SlideUpLineButton *button = [SlideUpLineButton slideUpLineButton:((SlideUpLineButtonStyle)[[[buttons objectAtIndex:i] objectAtIndex:0] integerValue]) andTarget:delegate onDoneSelector:((SEL) NSSelectorFromString([[buttons objectAtIndex:i] objectAtIndex:2]))];
                button.frame = CGRectOffset(button.frame, buttonTotalWidth, 0);
                button.backgroundColor = [UIColor clearColor];
                button.buttonNormalColor = [UIColor colorWithRed:(1.0 - menuBackgroundColor) * 255/255.0 green:(1.0 - menuBackgroundColor) * 255/255.0 blue:(1.0 - menuBackgroundColor) * 255/255.0 alpha:.95];
                [button setTitle:[[buttons objectAtIndex:i] objectAtIndex:1] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithRed:(1.0 - menuBackgroundColor) * 255/255.0 green:(1.0 - menuBackgroundColor) * 255/255.0 blue:(1.0 - menuBackgroundColor) * 255/255.0 alpha:.95] forState:UIControlStateHighlighted];
                [section.contentView addSubview:button];
            }
            
            i++;
        }
        
        [section setContentSize:CGSizeMake(_contentWidth, section.buttonSectionHeight)];
        
        if (_contentWidth < section.frame.size.width)
            [self adjustSlidingContentInSection:section];
    }
}

- (void)adjustSlidingContentInSection:(ButtonSection *)section {
    
    // center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = section.bounds.size;
    CGRect frameToCenter = section.contentView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    section.contentView.frame = frameToCenter;
}


@end
