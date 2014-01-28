//
//  OTBProfilesViewController.h
//  Profiles
//

#import <UIKit/UIKit.h>
#import "OTBEditProfilesViewController.h"
#import "ECSlidingViewController.h"
#import "lineBarButtonItem.h"
#import "InfoButton.h"
#import "TagCell.h"

@class Profiles;

@interface OTBProfilesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    
    AppModel *appModel;
    LineBarButtonItem *closeButton;
    LineBarButtonItem *addButton;
    
    IBOutlet UITableView *tableView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UIButton *editButton;
}

@property(retain) NSMutableArray *profiles;
@property (nonatomic, assign) CGFloat peekLeftAmount;

- (IBAction)editProfile:(id)sender forEvent:(UIEvent *)event;

@end
