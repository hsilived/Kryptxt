//
//  OTBProfilesViewController.h
//  Profiles
//

#import <UIKit/UIKit.h>
#import "OTBEditProfilesViewController.h"

@class Profiles;

@interface OTBProfilesViewController : UITableViewController

@property(retain) NSMutableArray *profiles;
@property(retain) OTBEditProfilesViewController *editProfileViewController;

@end
