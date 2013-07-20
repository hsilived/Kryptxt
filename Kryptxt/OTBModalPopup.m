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
#import "OTBNavigationTitle.h"

#define HeaderSize 60
#define FooterSize 30
#define pageWidth 280
//#define pageHeight 336


@interface OGAlertSheetBackground : UIView
@property(nonatomic, retain) UIColor *fillColor;
@end


@interface OTBModalPopup () {
    
    OGAlertSheetBackground *background;
}

- (void)finishCloseAnimation;

@end





#pragma mark - Main Controller

@implementation OTBModalPopup

@synthesize shouldDrawShadow;

- (id)init {
    
    //find height of screen to setup where the popup ends
    int height = [UIScreen mainScreen].bounds.size.height;
    int statusBarHeight = 0;
    
    if (![UIApplication sharedApplication].isStatusBarHidden) {
        
        CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
        statusBarHeight = rect.size.height;
    }
    
    self = [super initWithFrame:CGRectMake(0, 0, 300, height)];
    
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        
        //iphone 4 height == 480
        //create the container to hold the popup
        UIView *chooserView = [[UIView alloc] initWithFrame:CGRectMake(0, 25 / 2 + statusBarHeight, 300, height - 25)];
        chooserView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        
        background = [[OGAlertSheetBackground alloc] initWithFrame:CGRectMake(-1, 10, 302, height - 45)];
        background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        background.backgroundColor = [UIColor clearColor];
        [chooserView addSubview:background];
        
        pageHeight = height - (176 - HeaderSize + FooterSize) - 1;
        
        // Header
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(6, 10, 288, HeaderSize)];
        
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
        [chooserView addSubview:header];
        
        //Header Image
        OTBNavigationTitle *imageView = [[OTBNavigationTitle alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];
        imageView.center = CGPointMake((header.frame.size.width / 2 + 10), (header.frame.size.height / 2 + 10 + 1));
        [chooserView addSubview:imageView];
        
        // footer
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(6, height - 45 - FooterSize, 288, FooterSize)];
        
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
        [chooserView addSubview:footer];
        
        
        shapePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(44, 5, 200, 20) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15.0, 15.0)];
        
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = footer.bounds;
        shapeLayer.path = shapePath.CGPath;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        shapeLayer.lineWidth = 1;
        
        [footer.layer addSublayer:shapeLayer];
        
        
        
        // Scroll View
        //int scrollHeight = self.background.bounds.size.height - FooterSize - (HeaderSize + 10 + 2);
        pageScroll = [[OTBCustomScrollView alloc] initWithFrame:CGRectMake(10, HeaderSize + 10 + 1, 280, pageHeight)];
        pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        pageScroll.backgroundColor = [UIColor clearColor];
        pageScroll.pagingEnabled = YES;
        pageScroll.showsHorizontalScrollIndicator = NO;
        pageScroll.delegate = self;
        //pageScroll.backgroundColor = [UIColor greenColor];
        [chooserView addSubview:pageScroll];
        
        // Page Control
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, height - 45 - FooterSize - 3, 260, 36)];
        pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
        pageControl.hidesForSinglePage = YES;
        [chooserView addSubview:pageControl];
        
        // Close Button
        closeButton = [[CloseButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [chooserView addSubview:closeButton];
        
        [self addSubview:chooserView];
        
        self.shouldDrawShadow = YES;
        //self.dismissAfterwards = NO;
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



#pragma mark - Getter / Setter

- (UIColor *)backgroundColor {
    
    return background.fillColor;
}

- (void)setBackgroundColor:(UIColor *)bg {
    
    background.fillColor = bg;
}

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
        
        [pageScroll setContentSize:CGSizeMake(pageScroll.frame.size.width * numberOfPages, pageHeight)];
        pageControl.numberOfPages = numberOfPages;

        NSUInteger i = 0;
        
        while (i < numberOfPages) {
            
            UIView *page = [pages objectAtIndex:i];
            page.frame = CGRectMake(pageWidth * i, 0, pageWidth, pageHeight);
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



#pragma mark - Alert Sheet Background

@implementation OGAlertSheetBackground

#define OGEdgeRadius 16.0f
#define OGEdgePadding 6.0f
#define OGEdgeBottomPad 9.0f
#define OGLineWidth 1.0f

@synthesize fillColor = _fillColor;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self)
        self.fillColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:1.0];
    
    return self;
}

- (void)setFillColor:(UIColor *)fillColor {
    
    if (fillColor != _fillColor) {
        
        _fillColor = fillColor;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    float width = rect.size.width;
    float height = rect.size.height;
    float padEdge = OGEdgeRadius + (OGLineWidth / 2);
    CGPoint p1 = CGPointMake(OGEdgePadding + padEdge, padEdge);// p1 p2
    CGPoint p2 = CGPointMake(width - OGEdgePadding - padEdge, padEdge);// p4 p3
    CGPoint p3 = CGPointMake(width - OGEdgePadding - padEdge, height - OGEdgeBottomPad - padEdge);
    CGPoint p4 = CGPointMake(OGEdgePadding + padEdge, height - OGEdgeBottomPad - padEdge);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p1.x, p1.y - OGEdgeRadius);
    CGPathAddArcToPoint(path, NULL, p2.x + OGEdgeRadius, p2.y - OGEdgeRadius, p2.x + OGEdgeRadius, p2.y, OGEdgeRadius);
    CGPathAddArcToPoint(path, NULL, p3.x + OGEdgeRadius, p3.y + OGEdgeRadius, p3.x, p3.y + OGEdgeRadius, OGEdgeRadius);
    CGPathAddArcToPoint(path, NULL, p4.x - OGEdgeRadius, p4.y + OGEdgeRadius, p4.x - OGEdgeRadius, p4.y, OGEdgeRadius);
    CGPathAddArcToPoint(path, NULL, p1.x - OGEdgeRadius, p1.y - OGEdgeRadius, p1.x, p1.y - OGEdgeRadius, OGEdgeRadius);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(c);
    CGContextSetShadowWithColor(c, CGSizeMake(0, 5), 5.0, [[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor]);
    
    CGContextSetLineWidth(c, OGLineWidth);
    CGContextSetStrokeColorWithColor(c, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(c, [_fillColor CGColor]);
    
    CGContextBeginTransparencyLayer(c, NULL);
    CGContextAddPath(c, path);
    CGContextDrawPath(c, kCGPathFillStroke);
    CGContextEndTransparencyLayer(c);
    CGContextRestoreGState(c);
    
    CGPathRelease(path);
}

@end
