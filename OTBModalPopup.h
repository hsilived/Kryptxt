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

#import <QuartzCore/QuartzCore.h>
#import "OTBCustomScrollView.h"

@protocol OTBModalPopupDelegate;

@interface OTBModalPopup : UIView <UIScrollViewDelegate>
{
BOOL pageControlUsed_;
NSInteger pageIndex_;
}

@property (nonatomic, assign) id<OTBModalPopupDelegate> delegate;
@property (nonatomic, strong) OTBCustomScrollView *pageScroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIColor *backgroundColor; // r17 g25 b68 a0.8
@property (nonatomic) BOOL shouldDrawShadow; // YES
@property (nonatomic) BOOL dismissAfterwards; // NO
@property (nonatomic) float pageHeight;

+ (id)modalPopupWithDelegate:(id<OTBModalPopupDelegate>)dlg;
- (void)setPagesInArray:(NSArray*)pages;
- (void)presentInView:(UIView*)parentview;
- (void)dismiss;
@end

@protocol OTBModalPopupDelegate <NSObject>

@optional
- (void)modalPopupFinished:(OTBModalPopup*)ac;
@end