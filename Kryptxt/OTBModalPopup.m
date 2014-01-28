//
//  Copyright (c) 2011 Oleg Geier
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "OTBModalPopup.h"
//#import "OTBNavigationTitle.h"

#define IS_IPAD UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad


#define HeaderHeight 60
#define HeaderWidth 288
#define FooterSize 30
#define PageWidth 280
#define ContainerWidth 294
#define PagesControlWidth 200   
#define PagesControlHeight 20



    
@interface OTBModalPopup ()

- (void)finishCloseAnimation;

@end





#pragma mark - Main Controller

@implementation OTBModalPopup

@synthesize shouldDrawShadow;

- (id)init {
    
    //find height of screen to setup where the popup ends
    int statusBarHeight = 0;
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    Height = (screenHeight > 535) ? 535 : screenHeight;    
    PageHeight = Height - (176 - HeaderHeight + FooterSize) - 1;
    
    if (![UIApplication sharedApplication].isStatusBarHidden) {
        
        CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
        statusBarHeight = rect.size.height;
    }
    
    //self is the whole screen
    self = [super initWithFrame:CGRectMake(0, 0, ContainerWidth, Height)];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    if (self) {
        
        //self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        
        //iphone 4 height == 480 - popup 447.5
        //iphone 5 height == 568 - popup 535.5
        //creat the container to hold the popup
        infoView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - ContainerWidth) / 2 - 3, (screenHeight - Height  + statusBarHeight) / 2 + statusBarHeight, ContainerWidth, Height - 45)];
        //infoView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(5, HeaderHeight + 10, ContainerWidth - 4, PageHeight + 2)];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.borderWidth = 1;
        backgroundView.layer.borderColor = [UIColor blackColor].CGColor;
        [infoView addSubview:backgroundView];
        
        // Header
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(6, 10, HeaderWidth, HeaderHeight)];
        
        UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:header.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15.0, 15.0)];
        
        //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
        UIColor *highColor = [UIColor colorWithWhite:255.000 alpha:1];
        UIColor *lowColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.000];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.colors = [NSArray arrayWithObjects:(id) [highColor CGColor], (id) [lowColor CGColor], nil];
        gradient.frame = header.bounds;
        gradient.needsDisplayOnBoundsChange = YES;
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillRule = kCAFillRuleEvenOdd;
        maskLayer.path = shapePath.CGPath;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = header.bounds;
        shapeLayer.path = shapePath.CGPath;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineWidth = 1;
        
        [shapeLayer addSublayer:gradient];
        [gradient setMask:maskLayer];
        [gradient setNeedsDisplay];
        
        [header.layer addSublayer:shapeLayer];
        [infoView addSubview:header];
        
        //Header Image
       // OTBNavigationTitle *imageView = [[OTBNavigationTitle alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];
        //imageView.center = CGPointMake((header.frame.size.width / 2 + 10), (header.frame.size.height / 2 + 10 + 1));
        //[infoView addSubview:imageView];
        
        // footer
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(6, Height - 45 - FooterSize, HeaderWidth, FooterSize)];
        
        shapePath = [UIBezierPath bezierPathWithRoundedRect:footer.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15.0, 15.0)];
        
        //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
        highColor = [UIColor colorWithWhite:255.000 alpha:1];
        lowColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.000];
        gradient = [CAGradientLayer layer];
        gradient.colors = [NSArray arrayWithObjects:(id) [highColor CGColor], (id) [lowColor CGColor], nil];
        gradient.frame = footer.bounds;
        gradient.needsDisplayOnBoundsChange = YES;
        
        maskLayer = [CAShapeLayer layer];
        maskLayer.fillRule = kCAFillRuleEvenOdd;
        maskLayer.path = shapePath.CGPath;
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = footer.bounds;
        shapeLayer.path = shapePath.CGPath;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineWidth = 1;
        
        [shapeLayer addSublayer:gradient];
        [gradient setMask:maskLayer];
        [gradient setNeedsDisplay];
        
        [footer.layer addSublayer:shapeLayer];
        [infoView addSubview:footer];
        
        
        //this is the black circle around the pages dots in the footer
        shapePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((HeaderWidth - PagesControlWidth) / 2, 5, PagesControlWidth, PagesControlHeight) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15.0, 15.0)];
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = footer.bounds;
        shapeLayer.path = shapePath.CGPath;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineWidth = 1;
        [footer.layer addSublayer:shapeLayer];
        
        
        
        // Scroll View
        //int scrollHeight = self.background.bounds.size.height - FooterSize - (HeaderSize + 10 + 2);
        pageScroll = [[OTBCustomScrollView alloc] initWithFrame:CGRectMake(10, HeaderHeight + 10 + 1, PageWidth, PageHeight)];
        pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        pageScroll.backgroundColor = [UIColor clearColor];
        pageScroll.pagingEnabled = YES;
        pageScroll.showsHorizontalScrollIndicator = NO;
        pageScroll.delegate = self;
        //pageScroll.backgroundColor = [UIColor greenColor];
        [infoView addSubview:pageScroll];
        
        // Page Control
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(6, Height - 45 - FooterSize, HeaderWidth, FooterSize)];
        pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
        pageControl.hidesForSinglePage = YES;
        [infoView addSubview:pageControl];
        
        // Close Button
        closeButton = [[CloseButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [infoView addSubview:closeButton];
        
        [self addSubview:infoView];
        
        self.shouldDrawShadow = YES;
    }
    
    return self;
}

+ (id)modalPopupWithDelegate:(id <OTBModalPopupDelegate>)dlg {
    
    OTBModalPopup *ogac = [[OTBModalPopup alloc] init];
    ogac.delegate = dlg;
    [ogac setPagesInArray:nil];
    
    return ogac;
}



#pragma mark - Opening and Closing

- (void)presentInView:(UIView *)parentView {
    
    self.frame = parentView.bounds;
    self.alpha = 0.0f;
    
    [parentView addSubview:self];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15f];
    self.alpha = 1.0f;
    [UIView commitAnimations];
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
    
    if ([_delegate respondsToSelector:@selector(modalPopupFinished:)])
        [_delegate modalPopupFinished:self];
    
    [self removeFromSuperview];
}

- (CGSize)currentSize {

    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];

    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        size = CGSizeMake(size.height, size.width);

    if (application.statusBarHidden == NO)
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    
    return size;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    
//	//if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
//    return YES;
//	
//	//return NO;
//}

- (void)changeTheViewToPortrait:(BOOL)portrait andDuration:(NSTimeInterval)duration {
    
    //int height = [UIScreen mainScreen].bounds.size.height;
    //int width = [UIScreen mainScreen].bounds.size.width;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    int width = CGRectGetWidth(screenBounds);
    int height = CGRectGetHeight(screenBounds);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    
    NSLog(@"width %d", width);
    NSLog(@"height %d", height);
    
    self.frame = CGRectMake(0, 0, width, height);
    
    if (portrait) {
        
        infoView.frame = CGRectMake((width - ContainerWidth) / 2 - 3, (height - Height + 20) / 2 + 20, ContainerWidth, Height - 45);
        NSLog(@"portrait");
}
    else {
        
        infoView.frame = CGRectMake((height - ContainerWidth) / 2 - 3, (width - Height + 20) / 2 + 20, ContainerWidth, Height - 45);
        NSLog(@"landscape");
    }
    
    
    
    
    //self.frame = parentView.bounds;
    NSLog(@"self.frame (%f, %f) (%f x %f)", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

#pragma mark - Getter / Setter

- (void)setShouldDrawShadow:(BOOL)value {
    
    if (shouldDrawShadow != value) {
        
        shouldDrawShadow = value;
        [self setNeedsDisplay];
    }
}



#pragma mark - Custom Methods

- (void)setPagesInArray:(NSArray *)pages {
    
    if (pages) {
        
        int numberOfPages = pages.count;
        
        [pageScroll setContentSize:CGSizeMake(pageScroll.frame.size.width * numberOfPages, PageHeight)];
        pageControl.numberOfPages = numberOfPages;

        NSUInteger i = 0;
        
        while (i < numberOfPages) {
            
            UIView *page = [pages objectAtIndex:i];
            page.frame = CGRectMake(PageWidth * i, 0, PageWidth, PageHeight);
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




#pragma mark - draw shadow / radial gradient

- (void)drawRect:(CGRect)rect {
    
    if (!shouldDrawShadow) return;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] = {0.1176f, 0.2235f, 0.3098f, 0.9f, 0.0f, 0.0f, 0.0f, 0.4f, 0.0f, 0.0f, 0.0f, 0.0f};
    
    CGFloat locations[3] = {0.0f, 0.3f, 1.0f};
    
    CGGradientRef radGradient = CGGradientCreateWithColorComponents(rgb, colors, locations, 3);
    CGColorSpaceRelease(rgb);
    
    CGContextDrawRadialGradient(c, radGradient, CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), MAX(CGRectGetWidth(rect), CGRectGetHeight(rect)), CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), 0, 0);
    
    CGGradientRelease(radGradient);
}

@end
