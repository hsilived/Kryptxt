//
//  OTBView1.h
//  pageView
//
//  Created by DeviL on 2012-12-24.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTBView1 : UIView

@property(strong, nonatomic) IBOutlet UIButton *tweetButton;
@property(strong, nonatomic) IBOutlet UIButton *postFacebookButton;
@property(strong, nonatomic) IBOutlet UIButton *rateButton;
@property(strong, nonatomic) IBOutlet UIButton *supportButton;

- (IBAction)rate:(id)sender;

- (IBAction)support:(id)sender;

- (IBAction)facebook:(id)sender;

- (IBAction)tweet:(id)sender;

@end
