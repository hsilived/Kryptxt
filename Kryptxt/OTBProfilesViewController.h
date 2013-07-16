//
//  OTBProfilesViewController.h
//  Profiles
//

#import <UIKit/UIKit.h>
#import "OTBEditProfilesViewController.h"
#import "ECSlidingViewController.h"
//#import "UIViewController+MMDrawerController.h"
//#import "OTBMainViewController.h"

@class Profiles;

@interface OTBProfilesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
    //OTBMainViewController *main;
    IBOutlet UITableView *tableView;
    OTBEditProfilesViewController *editProfileViewController;
    IBOutlet UINavigationBar *navBar;
}

@property(retain) NSMutableArray *profiles;
@property (nonatomic, assign) CGFloat peekLeftAmount;

- (IBAction)cancelButton:(id)sender;
- (IBAction)addButton:(id)sender;

@end
