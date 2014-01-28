//
//  ValidationMethods.m
//  whatchoo
//
//  Created by DeviL on 2013-01-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "ValidationMethods.h"

@implementation ValidationMethods

- (void)validationPopupForBarButtonItem:(UIBarButtonItem *)barButtonItem withContent:(NSString *)content {
    
	UIView *targetView = (UIView *)[barButtonItem performSelector:@selector(view)];
	UIView *targetSuperview = [targetView superview];
	UIView *containerView = nil;
    
    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:content];
    
    RLog(@"%@", targetSuperview.class);
    
	if ([targetSuperview isKindOfClass:[UINavigationBar class]]) {
        
		UINavigationController *navController = [(UINavigationBar *)targetSuperview delegate];
		containerView = [[navController topViewController] view];
	}
	else if ([targetSuperview isKindOfClass:[UIToolbar class]]) {
        
		containerView = [targetSuperview superview];
	}
	
	if (nil == containerView) {
        
		RLog(@"Cannot determine container view from UIBarButtonItem: %@", barButtonItem);
		//popTipView.targetObject = nil;
		return;
	}
	
	self.currentPopTipViewTarget = barButtonItem;
	
    popTipView.animation = 0.5;
    
    popTipView.dismissTapAnywhere = NO;
    [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
    
	[popTipView presentPointingAtView:targetView inView:containerView animated:YES];
}

- (void)validationPopupForBarButtonItem:(UIBarButtonItem *)barButtonItem withContent:(NSString *)content withContainerView:(UIView*)containerView {
    
	UIView *targetView = (UIView *)[barButtonItem performSelector:@selector(view)];
    
    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:content];
    popTipView.borderWidth = 0;
    
	if (nil == containerView) {
        
		RLog(@"Cannot determine container view from UIBarButtonItem: %@", barButtonItem);
		return;
	}
	
	self.currentPopTipViewTarget = barButtonItem;
	
    popTipView.animation = 0.5;
    
    popTipView.dismissTapAnywhere = NO;
    [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
    
	[popTipView presentPointingAtView:targetView inView:containerView animated:YES];
}

- (void)validationPopupForObject:(id)someObject withContent:(NSString *)content withView:(UIView*)view {
    
    return [self validationPopupForObject:someObject withContent:content withView:view withTime:3.0];
}

- (void)validationPopupForObject:(id)someObject withContent:(NSString *)content withView:(UIView*)view withTime:(float)time {
    
    if (!_visiblePopTipViews)
        _visiblePopTipViews = [NSMutableArray new];
    
	[self dismissAllPopTipViews];
	
    UIColor *backgroundColor = [UIColor redColor];
    UIColor *textColor = [UIColor whiteColor];
    
    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:content];
    popTipView._delegate = self;
    popTipView.borderWidth = 0;
    
    if (backgroundColor && ![backgroundColor isEqual:[NSNull null]])
        popTipView.backgroundColor = backgroundColor;
    
    if (textColor && ![textColor isEqual:[NSNull null]])
        popTipView.textColor = textColor;
    
    popTipView.animation = 0.5;
    
    popTipView.dismissTapAnywhere = NO;
    [popTipView autoDismissAnimated:YES atTimeInterval:time];
    
    [popTipView presentPointingAtView:someObject inView:view animated:YES];
    
    [_visiblePopTipViews addObject:popTipView];
    self.currentPopTipViewTarget = someObject;
}

- (void)dismissAllPopTipViews {
    
	while (_visiblePopTipViews.count > 0) {
        
		CMPopTipView *popTipView = [_visiblePopTipViews objectAtIndex:0];
		[popTipView dismissAnimated:YES];
		[_visiblePopTipViews removeObjectAtIndex:0];
	}
}

@end
