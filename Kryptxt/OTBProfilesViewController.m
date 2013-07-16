//
//  OTBProfilesViewController.m
//  Profiles
//

#import "OTBProfilesViewController.h"
#import "ProfileDoc.h"
#import "ProfileData.h"
#import "ProfileDatabase.h"
#import "MFSideMenuContainerViewController.h"

@implementation OTBProfilesViewController

@synthesize peekLeftAmount;

@synthesize profiles = _profiles;

#pragma mark - View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    self.peekLeftAmount = 40.0f;
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    //tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    self.title = @"Profiles";
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor colorWithRed:128/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], UITextAttributeTextColor,
                                [UIColor whiteColor], UITextAttributeTextShadowColor,
                                [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset,
                                nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    _profiles = [ProfileDatabase loadProfileDocs];

    [tableView reloadData];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

    return YES;
}

#pragma mark - Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _profiles.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.textLabel.font = [UIFont systemFontOfSize:24.0];

// Configure the cell.
    ProfileDoc *doc = [_profiles objectAtIndex:indexPath.row];
    cell.textLabel.text = doc.data.title;
    cell.imageView.hidden = NO;

    if (!doc.data.selected)
        cell.imageView.image = [UIImage imageNamed:@"checkmark2.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"checkmark.png"];

    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    ProfileDoc *doc = [_profiles objectAtIndex:indexPath.row];
    editProfileViewController.profileDoc = doc;

    [self performSegueWithIdentifier:@"EditItem" sender:doc];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"EditItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        OTBEditProfilesViewController *controller = (OTBEditProfilesViewController *) navigationController.topViewController;
        controller.profileDoc = sender;
        //[segue.destinationViewController editProfileViewController];
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ProfileDoc *doc = [_profiles objectAtIndex:indexPath.row];
        [doc deleteDoc];
        [_profiles removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //some code to make this profile the seleted one
    ProfileDoc *selectedProfile = [_profiles objectAtIndex:indexPath.row];

    if (!selectedProfile.data.selected) {
        
        for (int i = 0; i < _profiles.count; i++) {
            
            ProfileDoc *clear = [_profiles objectAtIndex:i];

            if (clear.data.selected) {
                
                clear.data.selected = NO;
                [clear saveData];
            }
        }

        selectedProfile.data.selected = YES;
    }

    [selectedProfile saveData];

    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
    //NSString *identifier = [NSString stringWithFormat:@"%@Top", [self.menuItems objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECLeft animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
    
    
    //go back to main view now
    
//    main = [[OTBMainViewController alloc] init];
//    
//    //DemoViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoViewController"];
//    //demoViewController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:[NSBundle mainBundle]];
//    
//    //OTBMainViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
//    
//    //UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    NSArray *controllers = [NSArray arrayWithObject:main];
//    navigationController.viewControllers = controllers;
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
    //DemoViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoViewController"];
    //demoViewController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
    
    //UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    //NSArray *controllers = [NSArray arrayWithObject:demoViewController];
    //navigationController.viewControllers = controllers;
    //[self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
    
    //MMExampleCenterTableViewController * center = [[MMExampleCenterTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:center];
    //[self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    //main = (OTBMainViewController *)[self.navigationController.viewControllers objectAtIndex:0];
    
    //main = [[OTBMainViewController alloc] init];
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main.parentViewController.navigationController];
    
    //[self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
    //[self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

- (MFSideMenuContainerViewController *)menuContainerViewController {
    
    return (MFSideMenuContainerViewController *)self.navigationController.parentViewController;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    editProfileViewController = nil;
}

- (void)viewDidUnload {
    navBar = nil;
    
    tableView = nil;
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {

    _profiles = nil;
    editProfileViewController = nil;
}

- (IBAction)cancelButton:(id)sender {
    
    [self.slidingViewController resetTopView];
}

- (IBAction)addButton:(id)sender {
}
@end

