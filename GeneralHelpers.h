//
//  GeneralHelpers.h
//  Piggie
//
//  Created by DeviL on 2013-01-19.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface GeneralHelpers : NSObject

- (void)createBackgroundLayerWithView:(UIView *)view;
- (void)createBackgroundLayerWithView:(UIView *)view BorderWidth:(int)bw CornerRadius:(int)cr BackgroundColor:(UIColor *)bkc BorderColor:(UIColor *)bc;

- (NSString *)removeCrap:(NSString *)item;

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

- (void)setNavigationTitle:(NSString *)title WithViewController:(UIViewController *)vc;
- (void)SetNavButtonColors:(UIColor *)color;

- (void)addDesignToView:(UIView *)view BorderWidth:(int)bw CornerRadius:(int)cr BorderColor: (UIColor *)bc;
- (void)addDesignToView:(UIView *)view BorderWidth:(int)bw CornerRadius:(int)cr BackgroundColor:(UIColor *)bkc BorderColor: (UIColor *)bc;

- (void)enlargeInfoButton: (UIButton *)infoButton;
@end
