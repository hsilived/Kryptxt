//
//  ValidationMethods.m
//  Kryptxt
//
//  Created by DeviL on 2013-01-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "ValidationMethods.h"

@implementation ValidationMethods

- (void)validationPopupForObject:(id)someObject withContent:(NSString *)content withView:(UIView *)view {

    [self dismissAllPopTipViews];

    UIColor *backgroundColor = [UIColor redColor];
    UIColor *textColor = [UIColor whiteColor];

    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:content];

    popTipView._delegate = self;

    if (backgroundColor && ![backgroundColor isEqual:[NSNull null]])
        popTipView.backgroundColor = backgroundColor;

    if (textColor && ![textColor isEqual:[NSNull null]])
        popTipView.textColor = textColor;

    popTipView.animation = 0.5;

    popTipView.dismissTapAnywhere = YES;
    [popTipView autoDismissAnimated:YES atTimeInterval:3.0];

    [popTipView presentPointingAtView:someObject inView:view animated:YES];

    [_visiblePopTipViews addObject:popTipView];
    self.currentPopTipViewTarget = someObject;
}

- (void)dismissAllPopTipViews {

    while ([_visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [_visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [_visiblePopTipViews removeObjectAtIndex:0];
    }
}

@end
