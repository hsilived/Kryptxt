//
//  OTBProfilesViewController.m
//  Profiles
//

#import "OTBProfilesViewController.h"
#import "OTBIAPHelper.h"
#import <StoreKit/StoreKit.h>

@implementation OTBProfilesViewController

#define IS_IPAD UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

@synthesize peekLeftAmount, profiles;

#pragma mark - View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    appModel = [AppModel sharedManager];
    
    self.peekLeftAmount = 40.0f;
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [self setupCloseButton];
    [self setupAddButton];
    
    [appModel loadProducts];
    
    //add the logo image to the navigation bar
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kryptxt-profiles-title"]];
    [navItem setTitleView:imageView];
    //self.title = @"Profiles";
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    profiles = [ProfileDatabase loadProfileDocs];

    [tableView reloadData];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    //editProfileViewController = nil;
}

- (void)viewDidUnload {
    
    navBar = nil;
    tableView = nil;
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    
    profiles = nil;
    //editProfileViewController = nil;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

    return YES;
}

#pragma mark - Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView {

    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section {

    return profiles.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TagCell *cell = (TagCell *) [_tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    
    if (cell == nil)
        cell = [[TagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileCell"];
    
    cell.profileLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:IS_IPAD?48:24.0];
    cell.profileLabel.backgroundColor = [UIColor clearColor];
    
    // Configure the cell.
    ProfileDoc *doc = [profiles objectAtIndex:(NSUInteger)indexPath.row];
    cell.profileLabel.text = doc.data.profileAlias;
    cell.imageView.hidden = NO;

    cell.profileSelected.hidden = !doc.data.profileSelected;
    
    return cell;
}

- (void)tableView:(UITableView *)_tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    ProfileDoc *doc = [profiles objectAtIndex:(NSUInteger)indexPath.row];

    [self performSegueWithIdentifier:@"EditProfile" sender:doc];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"EditProfile"]) {
    
        OTBEditProfilesViewController *controller = segue.destinationViewController;
        controller.profile = sender;
    }
    else if ([segue.identifier isEqualToString:@"AddProfile"]) {
        
        //[self showAlertWarning];
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        ProfileDoc *doc = [profiles objectAtIndex:(NSUInteger)indexPath.row];
        [doc deleteDoc];
        [profiles removeObjectAtIndex:(NSUInteger)indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //some code to make this profile the selected one
    ProfileDoc *selectedProfile = [profiles objectAtIndex:(NSUInteger)indexPath.row];

    if (!selectedProfile.data.profileSelected) {

        for (NSUInteger i = 0; i < profiles.count; i++) {
    
            ProfileDoc *clear = [profiles objectAtIndex:i];

            if (clear.data.profileSelected) {
            
                clear.data.profileSelected = NO;
                [clear saveData];
            }
        }

        selectedProfile.data.profileSelected = YES;
    }

    [selectedProfile saveData];

    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    //go back to main view now
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECLeft animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];  
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return IS_IPAD ? 88 : 66;
}

#pragma mark - nav bar buttons

- (void)setupCloseButton {
    
    closeButton = [[LineBarButtonItem alloc] initWithTarget:self andAction:@selector(closeButton) andStyle:LineBarButtonItemStyleClose];
    closeButton.buttonColor = [UIColor colorWithRed:128/255.0 green:0/255.0 blue:128/255.0 alpha:1.0];
    closeButton.buttonHighlightColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    [navItem setLeftBarButtonItem:closeButton animated:YES];
}

- (void)closeButton {
    
    [self.slidingViewController resetTopView];
}

- (void)setupAddButton {
    
    addButton = [[LineBarButtonItem alloc] initWithTarget:self andAction:@selector(addProfile) andStyle:LineBarButtonItemStyleAdd];
    addButton.buttonColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:160/255.0 alpha:1.0];
    addButton.buttonHighlightColor = [UIColor colorWithRed:1 green:0.705 blue:0.114 alpha:1.0];
    [navItem setRightBarButtonItem:addButton animated:YES];
    //the following is for a page with a Navigation Controller
    //[self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

- (IBAction)editProfile:(id)sender forEvent:(UIEvent *)event {
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath != nil)
        [self tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (void)addProfile {
    
    //spinner.hidden = NO;
    //[spinner startAnimating];
    
    //[self performSegueWithIdentifier:@"EditProfile" sender:nil];
    
    if (profiles.count > 1) {
        
        if ([appModel validatePurchase])
            [self performSegueWithIdentifier:@"EditProfile" sender:nil];
    }
    else
        [self performSegueWithIdentifier:@"EditProfile" sender:nil];
}

@end

