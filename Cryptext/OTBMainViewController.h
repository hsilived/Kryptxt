//
//  OTBMainViewController.h
//  Cryptext
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBFlipsideViewController.h"

@interface OTBMainViewController : UIViewController <OTBFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
