//
//  ModalPopup.h
//  Kryptxt
//
//  Created by DeviL on 2013-09-06.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "OTBCustomScrollView.h"
#import "CloseButton.h"
#import "AppModel.h"
#import "UIView+viewRecursion.h"
#import "iRate.h"

@protocol ModalPopupDelegate <NSObject>

@optional

- (void)sendLikeFacebook;
- (void)sendLikeTweet;
- (void)modalPopupFinished;

@end

@interface ModalPopup : UIView <UIScrollViewDelegate> {

    AppModel *appModel;
    CloseButton *closeButton;
    float pageHeight;
    int popupHeight;
    UIPageControl *pageControl;
    OTBCustomScrollView *pageScroll;
    UIView *infoView;
    //IBOutlet UIView *buttonsView;
    int height;
    int screenWidth;
    int screenHeight;
    int statusBarHeight;
    CGSize screen;
    int headerWidth, pageWidth, containerWidth, pagesControlWidth, headerHeight, footerHeight, pagesControlHeight, offset;
}

@property (nonatomic, assign) id<ModalPopupDelegate> delegate;
//@property (strong, nonatomic) UIViewController *parentVC;
@property (nonatomic) BOOL shouldDrawShadow; // YES
@property (strong, nonatomic) UIView *parentView;

- (IBAction)rate:(id)sender;
//- (IBAction)support:(id)sender;
- (IBAction)facebook:(id)sender;
- (IBAction)tweet:(id)sender;
- (IBAction)gotoOrangeThinkBox:(id)sender;
- (IBAction)gotoOrangeThinkBoxFacebook:(id)sender;
- (IBAction)gotoOrangeThinkBoxTwitter:(id)sender;

- (void)loadInfo;

- (void)setPagesInArray:(NSArray*)pages;

#pragma mark - Opening and Closing

+ (id)modalPopupWithDelegate:(id <ModalPopupDelegate>)dlg;
- (void)presentInView:(UIView *)_parentview;
- (void)dismiss;
- (void)finishCloseAnimation;

@end
