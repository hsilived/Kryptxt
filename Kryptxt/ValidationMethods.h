//
//  ValidationMethods.h
//  Kryptxt
//
//  Created by DeviL on 2013-01-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMPopTipView.h"


@interface ValidationMethods : NSObject <CMPopTipViewDelegate>

@property(nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property(nonatomic, retain) id currentPopTipViewTarget;

- (void) validationPopupForBarButtonItem:(UIBarButtonItem *)barButtonItem withContent:(NSString *)content;
- (void)validationPopupForObject:(id)someObject withContent:(NSString *)content withView:(UIView *)view;
- (void)validationPopupForBarButtonItem:(UIBarButtonItem *)barButtonItem withContent:(NSString *)content withContainerView:(UIView*)containerView;
- (void)dismissAllPopTipViews;

@end
