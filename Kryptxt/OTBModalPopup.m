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

#define HeaderSize 60
#define FooterSize 30
#define pageWidth 280
//#define pageHeight 336




@interface OGCloseButton : UIButton {
}
@end


@interface OGAlertSheetBackground : UIView
@property(nonatomic, retain) UIColor *fillColor;
@end


@interface OTBModalPopup ()

@property(nonatomic, retain) OGAlertSheetBackground *background;

- (void)finishCloseAnimation;
@end


#pragma mark - Main Controller

@implementation OTBModalPopup

@synthesize delegate = _delegate, shouldDrawShadow = _shouldDrawShadow, pageScroll = _pageScroll, pageControl = _pageControl, background = _background;

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


        self.background = [[OGAlertSheetBackground alloc] initWithFrame:CGRectMake(-1, 10, 302, height - 45)];
        _background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _background.backgroundColor = [UIColor clearColor];
        [chooserView addSubview:_background];

        _pageHeight = height - (176 - HeaderSize + FooterSize) - 1;

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
        UIImage *image = [UIImage imageNamed:@"kryptxt-logo-a.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
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
        int scrollHeight = _pageHeight;
        self.pageScroll = [[OTBCustomScrollView alloc] initWithFrame:CGRectMake(10, HeaderSize + 10 + 1, 280, scrollHeight)];
        _pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _pageScroll.backgroundColor = [UIColor clearColor];
        _pageScroll.pagingEnabled = YES;
        _pageScroll.showsHorizontalScrollIndicator = NO;
        _pageScroll.delegate = self;
//_pageScroll.backgroundColor = [UIColor greenColor];
        [chooserView addSubview:_pageScroll];

// Page Control
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, height - 45 - FooterSize - 3, 260, 36)];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
        _pageControl.hidesForSinglePage = YES;
        [chooserView addSubview:_pageControl];

// Close Button
        OGCloseButton *closeButton = [[OGCloseButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        closeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];

        closeButton.layer.shadowColor = [UIColor blackColor].CGColor;
        closeButton.layer.shadowOffset = CGSizeMake(0, 3);
        closeButton.layer.shadowOpacity = 0.6;
        [chooserView addSubview:closeButton];

        [self addSubview:chooserView];

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


#pragma mark - Getter / Setter

- (UIColor *)backgroundColor {

    return _background.fillColor;
}

- (void)setBackgroundColor:(UIColor *)bg {

    _background.fillColor = bg;
}

- (void)setShouldDrawShadow:(BOOL)value {

    if (_shouldDrawShadow != value) {
        _shouldDrawShadow = value;
        [self setNeedsDisplay];
    }
}


#pragma mark - Custom Methods

- (void)setPagesInArray:(NSArray *)pages {

    int numberOfPages = pages.count;

    [_pageScroll setContentSize:CGSizeMake(_pageScroll.frame.size.width * numberOfPages, _pageHeight)];
    _pageControl.numberOfPages = numberOfPages;

    int i = 0;

    while (i < numberOfPages) {
        UIView *page = [pages objectAtIndex:i];
        page.frame = CGRectMake(pageWidth * i, 0, pageWidth, _pageHeight);
        [_pageScroll addSubview:page];

        i++;
    }
}


#pragma mark - Delegates and Page Control

- (void)pageControlChanged:(id)sender {

    if (sender == _pageControl) {
        CGSize scrSize = _pageScroll.frame.size;
        CGRect scrRect = CGRectMake(_pageControl.currentPage * scrSize.width, 0, scrSize.width, scrSize.height);
        [_pageScroll scrollRectToVisible:scrRect animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (_pageControl)
        _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}


#pragma mark - draw shadow / radial gradient

- (void)drawRect:(CGRect)rect {

    if (!_shouldDrawShadow) return;

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();

    CGFloat colors[] = {
            0.1176f, 0.2235f, 0.3098f, 0.9f,
            0.0f, 0.0f, 0.0f, 0.4f,
            0.0f, 0.0f, 0.0f, 0.0f
    };

    CGFloat locations[3] = {
            0.0f, 0.3f, 1.0f
    };

    CGGradientRef radGradient = CGGradientCreateWithColorComponents(rgb, colors, locations, 3);
    CGColorSpaceRelease(rgb);

    CGContextDrawRadialGradient(c, radGradient, CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), MAX(CGRectGetWidth(rect), CGRectGetHeight(rect)), CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), 0, 0);

    CGGradientRelease(radGradient);
}

@end


#pragma mark - Close-Button

@implementation OGCloseButton

- (void)drawRect:(CGRect)rect {

    float radius = MIN(rect.size.width, rect.size.height) / 2;
    float hWidth = CGRectGetMidX(rect);
    float hHeight = CGRectGetMidY(rect);
    float outerLineWidth = 1.0f;
    float x = radius * 0.35;

    CGContextRef c = UIGraphicsGetCurrentContext();

    CGColorRef whiteColor = [(self.highlighted ? [UIColor lightGrayColor] : [UIColor whiteColor]) CGColor];
    CGColorRef blackColor = CGColorRetain([[UIColor colorWithRed:178 / 255.0 green:84 / 255.0 blue:178 / 255.0 alpha:1.000] CGColor]);

    CGContextSetFillColorWithColor(c, whiteColor);
    CGContextSetStrokeColorWithColor(c, blackColor);
    CGContextSetLineWidth(c, outerLineWidth);
    CGContextMoveToPoint(c, hWidth + radius - outerLineWidth, hHeight);
    CGContextAddArc(c, hWidth, hHeight, radius - outerLineWidth, 0, 2 * M_PI, false);
    CGContextDrawPath(c, kCGPathFillStroke);

    CGContextSetFillColorWithColor(c, blackColor);
    CGContextMoveToPoint(c, hWidth + (radius * 0.75), hHeight);
    CGContextAddArc(c, hWidth, hHeight, radius * 0.75, 0, 2 * M_PI, false);
    CGContextDrawPath(c, kCGPathFill);

    CGContextSetStrokeColorWithColor(c, whiteColor);
    CGContextSetLineWidth(c, radius * 0.2);
    CGContextMoveToPoint(c, hWidth - x, hHeight - x); // x.
    CGContextAddLineToPoint(c, hWidth + x, hHeight + x); // .x
    CGContextMoveToPoint(c, hWidth + x, hHeight - x); // .x
    CGContextAddLineToPoint(c, hWidth - x, hHeight + x); // x.
    CGContextDrawPath(c, kCGPathStroke);
}

- (void)setHighlighted:(BOOL)highlighted {

    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

@end


#pragma mark - Alert Sheet Background

@implementation OGAlertSheetBackground

#define OGEdgeRadius 16.0f
#define OGEdgePadding 6.0f
#define OGEdgeButtomPad 9.0f
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
    CGPoint p3 = CGPointMake(width - OGEdgePadding - padEdge, height - OGEdgeButtomPad - padEdge);
    CGPoint p4 = CGPointMake(OGEdgePadding + padEdge, height - OGEdgeButtomPad - padEdge);


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
