//
//  ModalPopup.m
//  Kryptxt
//
//  Created by DeviL on 2013-09-06.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "ModalPopup.h"


@interface ModalPopup ()

- (void)finishCloseAnimation;

@end



#pragma mark - Main Controller

@implementation ModalPopup

@synthesize parentView;

- (id)initWithFrame:(CGRect)frame {
    
    appModel = [AppModel sharedManager];
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code.
        
        screen = [appModel currentSize];
        
        if (IS_IPAD) {
            
            headerWidth = 520;
            pageWidth = 520;
            containerWidth = 520;
            pagesControlWidth = 300;
        }
        else {
            
            headerWidth = 290;
            pageWidth = 290;
            containerWidth = 290;
            pagesControlWidth = 200;
        }
        
        headerHeight = 44;
        footerHeight = 44;
        pagesControlHeight = 20;
        
        //iphone 4 height == 480 - popup 447.5
        //iphone 5 height == 568 - popup 535.5
        if (!IS_IPAD)
            height = screen.height;
        else
            height = 720;
        
        popupHeight = height - 20;
        pageHeight = popupHeight - (headerHeight + footerHeight);
        
        if (![UIApplication sharedApplication].isStatusBarHidden)
            statusBarHeight = 20;
        
        [self setNeedsDisplay];
    }
    return self;
}

- (void)loadInfo {

    NSString *version = [[UIDevice currentDevice] systemVersion];
    int ver = [version intValue];

    if (ver < 7) {
        
        offset = 0;
    }
    else {
        
        if (!IS_IPAD)
            offset = 20;
        else
            offset = 0;
    }
    
    //create the container to hold the popup
    infoView = [[UIView alloc] initWithFrame:CGRectMake((screen.width - containerWidth) / 2 - 1, (screen.height - popupHeight) / 2, containerWidth, popupHeight)];
    infoView.backgroundColor = [UIColor whiteColor];
    
    DLogRect(infoView.frame);
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        infoView.frame = CGRectOffset(infoView.frame, 0, 20);
    
    infoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [infoView.layer setCornerRadius:4.5];
    [infoView.layer setMasksToBounds:YES];
    
    //DLogRect(infoView.frame);
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoView.frame.size.width, 44)];
    
    //Header Image
    UIImage *image = [UIImage imageNamed:@"kryptxt-title"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = CGPointMake(header.frame.size.width / 2, header.frame.size.height / 2);
    [header addSubview:imageView];
    
    // Close Button
    closeButton = [[CloseButton alloc] initWithFrame:CGRectMake(2, 2, 44, 44)];
    [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    closeButton.showsTouchWhenHighlighted = YES;
    [header addSubview:closeButton];
    [infoView addSubview:header];
    
    // Scroll View
    //int scrollHeight = self.background.bounds.size.height - footerHeight - (HeaderSize + 10 + 2);
    pageScroll = [[OTBCustomScrollView alloc] initWithFrame:CGRectMake(0, 44, pageWidth, pageHeight)];
    pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    pageScroll.backgroundColor = [UIColor clearColor];
    pageScroll.pagingEnabled = YES;
    pageScroll.showsHorizontalScrollIndicator = NO;
    pageScroll.delegate = self;
    //pageScroll.backgroundColor = [UIColor greenColor];
    //[infoView addSubview:pageScroll];
    
    
    
    
    // footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(1, popupHeight - footerHeight - 1, infoView.frame.size.width, footerHeight)];
    [infoView addSubview:footer];
    
    // Page Control
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, infoView.frame.size.width, footerHeight)];
    pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    pageControl.hidesForSinglePage = YES;
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:167/255.0 green:80/255.0 blue:10/255.0 alpha:1.0];
    [footer addSubview:pageControl];

    [infoView addSubview:pageScroll];
    
    [self addSubview:infoView];
    infoView.alpha = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [infoView setAlpha:1.0];
    [UIView commitAnimations];
    //[self addSubview:infoView];
    //[UIView transitionWithView:self duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^ { [self addSubview:infoView]; } completion:nil];
}

#pragma mark - Opening and Closing

+ (id)modalPopupWithDelegate:(id <ModalPopupDelegate>)dlg {
    
    ModalPopup *info = [[ModalPopup alloc] init];
    info.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    info.delegate = dlg;
    
    return info;
}

- (void)presentInView:(UIView *)_parentview {

    self.frame = CGRectMake(0, 0, screen.width, screen.height);
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.opaque = NO;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        self.frame = CGRectMake(0, 0, screen.width, screen.height + 20);
    
    parentView = _parentview;
    
    [self loadInfo];
    
    NSString *infoXib;
    
    if (IS_IPAD)
        infoXib = @"info_iPad";
    else
        infoXib = @"info_iPhone";
    
    NSArray *views;
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v1 = [views objectAtIndex:0];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v2 = [views objectAtIndex:1];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v3 = [views objectAtIndex:2];

    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v4 = [views objectAtIndex:3];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v5 = [views objectAtIndex:4];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v6 = [views objectAtIndex:5];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v7 = [views objectAtIndex:6];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v8 = [views objectAtIndex:7];
    
    views = [[NSBundle mainBundle] loadNibNamed:infoXib owner:self options:nil];
    UIView *v9 = [views objectAtIndex:8];
    
    // Put the views inside an NSArray:
    NSArray *pages = [NSArray arrayWithObjects:v1, v2, v3, v4, v5, v6, v7, v8, v9, nil];
    
    [self setPagesInArray:pages]; // next page
}

- (void)dismiss {

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishCloseAnimation)];
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)finishCloseAnimation {

    if ([_delegate respondsToSelector:@selector(modalPopupFinished)])
        [_delegate modalPopupFinished];
    
    [self removeFromSuperview];
}

#pragma mark - Custom Methods

- (void)setPagesInArray:(NSArray *)pages {

    if (pages) {
        
        int numberOfPages = pages.count;

        [pageScroll setContentSize:CGSizeMake(pageScroll.frame.size.width * numberOfPages, pageHeight)];
        pageControl.numberOfPages = numberOfPages;

        NSUInteger i = 0;

        while (i < numberOfPages) {
            
            UIView *page = [pages objectAtIndex:i];
       
//            for(UIView *v in [page allSubViews]) {
//
//                if([v isKindOfClass:[UILabel class]]) {
//                    
//                    UILabel *info = (UILabel *)v;
//                    info.font = [UIFont fontWithName:@"Miso-Light" size:info.font.pointSize];
//                }
//            }
            
            page.frame = CGRectMake(pageWidth * i, offset, pageWidth, pageHeight);
            [pageScroll addSubview:page];

            i++;
        }
    }
}

#pragma mark - Delegates and Page Control

- (void)pageControlChanged:(id)sender {

    if (sender == pageControl) {
        
        CGSize scrSize = pageScroll.frame.size;
        CGRect scrRect = CGRectMake(pageControl.currentPage * scrSize.width, 0, scrSize.width, scrSize.height);
        [pageScroll scrollRectToVisible:scrRect animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (pageControl)
        pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

#pragma mark - infoView Methods

- (IBAction)rate:(id)sender {
    
    [[iRate sharedInstance] openRatingsPageInAppStore];
}

- (IBAction)facebook:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(sendLikeFacebook)])
        [_delegate sendLikeFacebook];
}

- (IBAction)tweet:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(sendLikeTweet)])
        [_delegate sendLikeTweet];
}

- (IBAction)gotoOrangeThinkBox:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://orangethinkbox.com"]];
}

- (IBAction)gotoOrangeThinkBoxFacebook:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/Piggie-Latin/176597132544742"]];
}

- (IBAction)gotoOrangeThinkBoxTwitter:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/orangethinkbox"]];
}

@end
