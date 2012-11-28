//
//  OTBFlipsideViewController.h
//  Cryptext
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OTBFlipsideViewController;

@protocol OTBFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(OTBFlipsideViewController *)controller;
@end

@interface OTBFlipsideViewController : UIViewController

@property (weak, nonatomic) id <OTBFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
