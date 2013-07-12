//
//  OTBProfilesViewController.m
//  Profiles
//

#import "OTBProfilesViewController.h"
#import "ProfileDoc.h"
#import "ProfileData.h"
#import "ProfileDatabase.h"

@implementation OTBProfilesViewController
@synthesize profiles = _profiles;
@synthesize editProfileViewController = _editProfileViewController;

#pragma mark - View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"Profiles";
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    _profiles = [ProfileDatabase loadProfileDocs];

    [self.tableView reloadData];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

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
    _editProfileViewController.profileDoc = doc;

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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ProfileDoc *doc = [_profiles objectAtIndex:indexPath.row];
        [doc deleteDoc];
        [_profiles removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//some code to make this profile the seleted one
    ProfileDoc *doc = [_profiles objectAtIndex:indexPath.row];

    if (!doc.data.selected) {
        for (int i = 0; i < _profiles.count; i++) {
            ProfileDoc *clear = [_profiles objectAtIndex:i];

            if (clear.data.selected) {
                clear.data.selected = NO;
                [clear saveData];
            }
        }

        doc.data.selected = YES;
    }

    [doc saveData];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//go back to main view now
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    self.editProfileViewController = nil;
}

- (void)viewDidUnload {
// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
// For example: self.myOutlet = nil;
}

- (void)dealloc {

    _profiles = nil;
    _editProfileViewController = nil;
}

@end

