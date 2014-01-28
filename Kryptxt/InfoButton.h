//
//  InfoButton.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface InfoButton : UIButton

@property (nonatomic,strong) UIColor * buttonNormalColor;
@property (nonatomic,strong) UIColor * buttonHighlightedColor;

- (UIColor *)buttonColorForState:(UIControlState)state;
- (void)setButtonColor:(UIColor *)color forState:(UIControlState)state;

@end
