//
//  OTBProfilesViewController.m
//  Profiles
//

#import "OTBProfilesViewController.h"

@implementation OTBProfilesViewController

@synthesize peekLeftAmount, profiles;

#pragma mark - View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    self.peekLeftAmount = 40.0f;
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];

    self.title = @"Profiles";
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    profiles = [ProfileDatabase loadProfileDocs];

    [tableView reloadData];
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

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.textLabel.font = [UIFont systemFontOfSize:24.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    // Configure the cell.
    ProfileDoc *doc = [profiles objectAtIndex:(NSUInteger)indexPath.row];
    cell.textLabel.text = doc.data.title;
    cell.imageView.hidden = NO;

    if (!doc.data.selected)
        cell.imageView.image = [UIImage imageNamed:@"checkmark2.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"checkmark.png"];

    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    return cell;
}

- (void)tableView:(UITableView *)_tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    ProfileDoc *doc = [profiles objectAtIndex:(NSUInteger)indexPath.row];
    //editProfileViewController.profile = doc;

    [self performSegueWithIdentifier:@"EditItem" sender:doc];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"EditItem"]) {
        
        OTBEditProfilesViewController *controller = segue.destinationViewController;
        controller.profile = sender;
        
        //UINavigationController *navigationController = segue.destinationViewController;
        //OTBEditProfilesViewController *controller = (OTBEditProfilesViewController *) navigationController.topViewController;
        //editProfileViewController.profile = sender;
        //[segue.destinationViewController editProfileViewController];
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

    if (!selectedProfile.data.selected) {
        
        for (NSUInteger i = 0; i < profiles.count; i++) {
            
            ProfileDoc *clear = [profiles objectAtIndex:i];

            if (clear.data.selected) {
                
                clear.data.selected = NO;
                [clear saveData];
            }
        }

        selectedProfile.data.selected = YES;
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

- (IBAction)cancelButton:(id)sender {
    
    [self.slidingViewController resetTopView];
}

- (IBAction)addButton:(id)sender {
}
@end

