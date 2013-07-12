//
//  GeneralHelpers.m
//  Piggie
//
//  Created by DeviL on 2013-01-19.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "GeneralHelpers.h"

#pragma mark - View Methods

@implementation GeneralHelpers

- (void)createBackgroundLayerWithView:(UIView *)view {

    [self addDesignToView:(UIView *)view BorderWidth:2 CornerRadius:23 BackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:(1.0)] BorderColor:[UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:(1.0)]];
}

- (void)createBackgroundLayerWithView:(UIView *)view BorderWidth:(int)bw CornerRadius:(int)cr BackgroundColor:(UIColor *)bkc BorderColor:(UIColor *)bc {
    
    view.layer.borderColor = [bc CGColor];
    view.layer.backgroundColor = [bkc CGColor];
    view.layer.borderWidth = bw;
    view.layer.cornerRadius = cr;
    
    view.layer.shadowRadius = 5;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    //view.layer.shadowOffset = CGSizeMake(-10, 0.0);
    view.layer.shadowColor = [[UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:150 / 255.0 alpha:(0.9)] CGColor];
    view.layer.masksToBounds = NO;
    view.layer.shadowOpacity = 0.5;
}

#pragma mark - NSString Methods

- (NSString *)removeCrap:(NSString *)item {

    NSString *tempValue = [item stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    tempValue = [tempValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    return tempValue;
}

#pragma mark - TextView Methods


//center text in a textview

//add the following in .h
//#import "GeneralHelpers.h"
//@property (nonatomic, strong) GeneralHelpers* generalHelpers;

//add the following line per textView in .m DidLoad
//self.generalHelpers = [[GeneralHelpers alloc] init];

//Add an observer for the contentSize key value of the UITextView when the view is loaded
//[outputView addObserver:_generalHelpers forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    UITextView *tv = object;

    int tvBoundsHeight = tv.bounds.size.height;
    int tvContentSizeHeight = tv.contentSize.height;
    int tvZoomScale = tv.zoomScale;

    CGFloat topCorrect = (tvBoundsHeight - tvContentSizeHeight * tvZoomScale) / 2.0;
    topCorrect = (topCorrect < 0.0 ? 0.0 : topCorrect);

    tv.contentOffset = (CGPoint) {.x = 0, .y = -topCorrect};

    tv.textAlignment = UITextAlignmentCenter;
}


#pragma mark - Navigation Methods

- (void)setNavigationTitle:(NSString *)title WithViewController:(UIViewController *)vc {
    //[vc.super setTitle:title];

    UILabel *titleView = (UILabel *) vc.navigationItem.titleView;

    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];

        titleView.textColor = [UIColor colorWithRed:12 / 255.0 green:81 / 255.0 blue:137 / 255.0 alpha:(1.0)]; // Change to desired color

        vc.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (void)SetNavButtonColors:(UIColor *)color {
    //self.navigationItem.leftBarButtonItem.tintColor = color;
    [[UIBarButtonItem appearance] setTintColor:color];
}

#pragma mark - View Methods

- (void)addDesignToView:(UIView *)view BorderWidth:(int)bw CornerRadius:(int)cr BorderColor:(UIColor *)bc {

    view.layer.borderColor = [bc CGColor];
    view.layer.borderWidth = bw;
    view.layer.cornerRadius = cr;
    [self addDesignToView:view BorderWidth:bw CornerRadius:cr BackgroundColor:NULL BorderColor:bc];
}

- (void)addDesignToView:(UIView *)view BorderWidth:(int)bw CornerRadius:(int)cr BackgroundColor:(UIColor *)bkc BorderColor:(UIColor *)bc {

    view.layer.borderColor = [bc CGColor];
    if (bkc)
        view.layer.backgroundColor = [bkc CGColor];
    view.layer.borderWidth = bw;
    view.layer.cornerRadius = cr;
}

#pragma mark - Info Button

- (void)enlargeInfoButton:(UIButton *)infoButton {
    //update info button to give more clikable space
    CGRect infoRect = CGRectMake(infoButton.frame.origin.x - 20, infoButton.frame.origin.y - 20, infoButton.frame.size.width + 40, infoButton.frame.size.height + 40);
    infoButton.frame = infoRect;
    //infoButton.layer.borderColor = [[UIColor greenColor] CGColor];
    //infoButton.layer.borderWidth = 1;
}
@end
