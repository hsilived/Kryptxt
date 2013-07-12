//
//  OTBView1.m
//  pageView
//
//  Created by DeviL on 2012-12-24.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBView1.h"

@implementation OTBView1

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

//[super touchesEnded:touches withEvent:event];

    if (self) {
// Initialization code
    }
    return self;
}


- (IBAction)rate:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HEY HEY" message:@"You pushed the RATE button" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)support:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HEY HEY" message:@"You pushed the SUPPORT button" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)facebook:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HEY HEY" message:@"You pushed the FACEBOOK button" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)tweet:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"HEY HEY" message:@"You pushed the TWEET button" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
@end
