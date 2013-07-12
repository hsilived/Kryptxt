//
//  OTBAppDelegate.h
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTBMainViewController.h"

@interface OTBAppDelegate : UIResponder <UIApplicationDelegate> {
    
    OTBMainViewController *main;
    UIImageView *imageView;
}

@property(strong, nonatomic) UIWindow *window;

@end
