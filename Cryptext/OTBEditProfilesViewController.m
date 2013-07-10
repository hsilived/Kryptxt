//
//  OTBEditProfilesViewController.m
//  Cryptext
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBEditProfilesViewController.h"
#import "ProfileDoc.h"
#import "ProfileData.h"
#import "ProfileDatabase.h"

@implementation OTBEditProfilesViewController

@synthesize profiles = _profiles;
@synthesize profileCode;
@synthesize kbHelper;

- (void)viewDidLoad {

    [super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    self.navigationItem.leftBarButtonItem = item;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];

    self.validationMethods = [[ValidationMethods alloc] init];

    self.kbHelper = [[KeyboardHelper alloc] initWithViewController:self onDoneSelector:@selector(onDone)];

    self.peoplePicker = [[PeoplePicker alloc] initWithViewController:self onDoneSelector:@selector(onDonePicking)];

    [self createBackgroundLayerWithView:_containerPanel];

// In your viewDidLoad or wherever you initialize the view.
    _pickerDisplayView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 320)];
    [self.view insertSubview:_pickerDisplayView atIndex:100];
//[self performSelector:@selector(animateIn) withObject:nil afterDelay:0.25];
}

- (void)viewWillAppear:(BOOL)animated {

    _profiles = [ProfileDatabase loadProfileDocs];

    if (self.profileDoc == nil) {
        self.title = @"New Profile";
    }
    else {
        self.title = @"Edit Profile";

        _profileName.text = _profileDoc.data.title;
        profileCode = _profileDoc.data.profileCode;

        _contactName.text = _profileDoc.data.contactName;
        _contactNumber.text = _profileDoc.data.contactNumber;
        _contactEmail.text = _profileDoc.data.contactEmail;

        if (profileCode != @"0") {
            NSUInteger numComponents = [self numberOfComponentsInPickerView:_codeGen];

            for (int i = 0; i < numComponents; i++) {
                UILabel *contactCode = (UILabel *) [self.view viewWithTag:i + 100];
                contactCode.text = [NSString stringWithFormat:@"%@", [profileCode substringWithRange:NSMakeRange(i, 1)]];
                [_code appendFormat:@"%@", [profileCode substringWithRange:NSMakeRange(i, 1)]];
            }

            NSLog(@"%@", _code);
        }
    }

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    [self.kbHelper disable];
}

#pragma mark - Background Layer

- (void)createBackgroundLayerWithView:(UIView *)view {

    view.layer.borderColor = [[UIColor colorWithRed:128 / 255.0 green:0 / 255.0 blue:128 / 255.0 alpha:(1.0)] CGColor];
    view.layer.backgroundColor = [[UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:(1.0)] CGColor];
    view.layer.borderWidth = 2;
    view.layer.cornerRadius = 20;

    view.layer.shadowRadius = 5;
    view.layer.shadowOffset = CGSizeMake(0, 10);
    view.layer.shadowColor = [[UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:(0.9)] CGColor];
    view.layer.masksToBounds = NO;
    view.layer.shadowOpacity = 0.6;
}

- (IBAction)showActionSheet:(id)sender {
//find height of screen to setup where the popup ends
    int height = [UIScreen mainScreen].bounds.size.height;
    int width = [UIScreen mainScreen].bounds.size.width;

    UIView *page = self.navigationController.topViewController.view;

    _modalBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _modalBackground.backgroundColor = [UIColor blackColor];
    _modalBackground.alpha = 0.7;
    [page insertSubview:_modalBackground atIndex:2];


    _navBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    _navBackground.backgroundColor = [UIColor blackColor];
    _navBackground.alpha = 0.7;
    [self.navigationController.view.superview insertSubview:_navBackground atIndex:20];

    [self.view endEditing:YES];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];

//find height of screen to setup where the popup ends
    CGRect initialFrame = self.view.frame;

    [_pickerDisplayView setFrame:CGRectMake(0, initialFrame.size.height - 217, 320, 320)];
    [UIView commitAnimations];


    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    _codeGen = [[UIPickerView alloc] initWithFrame:pickerFrame];
    _codeGen.showsSelectionIndicator = NO;
    _codeGen.delegate = self;

    for (int i = 0; i < 8; i++) {
        int number = [[profileCode substringWithRange:NSMakeRange(i, 1)] intValue];

        [_codeGen selectRow:number inComponent:i animated:YES];
    }
    [_codeGen reloadAllComponents];

    [_pickerDisplayView addSubview:_codeGen];

//define the image we want to use for the selector image
    UIImage *selectorImage = [UIImage imageNamed:@"selectionIndicator.png"];
    UIView *customSelector = [[UIImageView alloc] initWithImage:selectorImage];

//set the x and y values for where to put the selector image
    customSelector.frame = CGRectMake(_codeGen.frame.origin.x, (_codeGen.frame.origin.y + (_codeGen.bounds.size.height / 2) - 24), _codeGen.bounds.size.width, 47);



//add the custom selector indicator to the view
    [_pickerDisplayView addSubview:customSelector];



//setup toolbar above picker
    UIToolbar *barHelper = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    barHelper.barStyle = UIBarStyleBlack;
    barHelper.tintColor = [UIColor colorWithRed:149 / 255.0 green:78 / 255.0 blue:150 / 255.0 alpha:(0.5)];
    barHelper.alpha = 1.0;

    UISegmentedControl *segPrevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Prev", @"Prev"), NSLocalizedString(@"Next", @"Next"), nil]];
    segPrevNext.segmentedControlStyle = UISegmentedControlStyleBar;
    segPrevNext.momentary = YES;
    [segPrevNext addTarget:self action:@selector(nextFromCodePicker) forControlEvents:UIControlEventValueChanged];
    segPrevNext.tintColor = [UIColor blackColor];

    UIBarButtonItem *btnExtra = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Random Code", @"Random Code") style:UIBarButtonItemStyleBordered target:self action:@selector(randomize)];
    btnExtra.tintColor = [UIColor blackColor];

    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done") style:UIBarButtonItemStyleDone target:self action:@selector(onDoneCodePicking)];
    btnDone.tintColor = [UIColor blackColor];

    UIBarButtonItem *seperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];

    [barHelper setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:segPrevNext], seperator, btnExtra, seperator, btnDone, nil]];

    [_pickerDisplayView addSubview:barHelper];

//set prev button to disabled because we are at the top of the page
    [segPrevNext setEnabled:NO forSegmentAtIndex:0];
    [segPrevNext setEnabled:YES forSegmentAtIndex:1];

    [_pickerDisplayView setBounds:CGRectMake(0, 0, 320, 405)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    if ([_profileName isFirstResponder] && [touch view] != _profileName)
        [self resignFirstResponder];

    [super touchesBegan:touches withEvent:event];
}

- (void)nextFromCodePicker {

    [self onDoneCodePicking];

    UITextView *nextObj = (UITextView *) [self.view viewWithTag:1];
    [nextObj becomeFirstResponder];
}

- (IBAction)closeFirstPicker:(id)sender {

    [self closePicker];
}

- (void)closePicker {

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [_pickerDisplayView setFrame:CGRectMake(0, 500, 320, 320)];
    [UIView commitAnimations];
}

- (void)onDoneCodePicking {

    NSUInteger numComponents = [self numberOfComponentsInPickerView:_codeGen];

    _code = [NSMutableString string];

    for (NSUInteger i = 0; i < numComponents; ++i) {
        NSUInteger selectedRow = [_codeGen selectedRowInComponent:i];
        NSString *title = [self pickerView:_codeGen titleForRow:selectedRow forComponent:i];

        UILabel *contactCode = (UILabel *) [self.view viewWithTag:i + 100];
        contactCode.text = [NSString stringWithFormat:@"%@", title];
        [_code appendFormat:@"%@", title];
    }

    NSLog(@"%@", _code);

    profileCode = _code;

    _modalBackground.hidden = YES;
    _navBackground.hidden = YES;

    [self.view endEditing:YES];

    [self closePicker];
}

- (void)onDonePicking {

    _contactNumber.text = _peoplePicker.contactNumber;
    _contactName.text = _peoplePicker.contactName;
    _contactEmail.text = _peoplePicker.contactEmail;

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 8;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [[NSNumber numberWithInt:row] stringValue];
}

#pragma mark - Actions

- (IBAction)showPicker:(id)sender {

    [self.peoplePicker showPicker];
}

- (void)randomize {

    for (int i = 0; i < 8; i++) {
        int number = (arc4random() % 9);

        [_codeGen selectRow:number inComponent:i animated:YES];
    }
    [_codeGen reloadAllComponents];
}

- (void)cancelButton {

    NSLog(@"cancel button was clicked");

//[self performSegueWithIdentifier:@"Profiles" sender:self];

    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
//[self pushViewController:@"Profiles" animated:YES];
}

- (void)saveButton {

    if (_profileName.text.length == 0) {
        [_validationMethods validationPopupForObject:_profileName withContent:@"Profile needs a name." withView:self.view];
        return;
    }

    NSLog(@"%@", self.profileDoc.data.title.lowercaseString);
    NSLog(@"%@", _profileName.text.lowercaseString);

    if ((self.profileDoc == nil) || (![self.profileDoc.data.title.lowercaseString isEqualToString:_profileName.text.lowercaseString])) {
        for (int i = 0; i < _profiles.count; i++) {
            ProfileDoc *temp = [_profiles objectAtIndex:i];

            NSString *tempProfileName = temp.data.title.lowercaseString;
            NSString *profileName = _profileName.text.lowercaseString;

            NSLog(@"%@", tempProfileName);
            NSLog(@"%@", profileName);

            if ([tempProfileName isEqualToString:profileName]) {
                [_validationMethods validationPopupForObject:_profileName withContent:@"Profile name is already used." withView:self.view];
                return;
            }
        }
    }

    if (profileCode == NULL || profileCode == @"????????" || profileCode == @"0" || profileCode == @"") {
        [_validationMethods validationPopupForObject:_contactCode withContent:@"Profile code needs to be selected." withView:self.view];
        return;
    }

    if (_contactName.text.length == 0) {
        [_validationMethods validationPopupForObject:_contactName withContent:@"Contact needs a name." withView:self.view];
        return;
    }

    if (_contactNumber.text.length == 0 && _contactEmail.text.length == 0) {
        [_validationMethods validationPopupForObject:_contactNumber withContent:@"Contact needs a phone No. or Email." withView:self.view];
        return;
    }

    if (self.profileDoc == nil) {
        self.profileDoc = [[ProfileDoc alloc] initWithTitle:@"" ProfileCode:@"0" ContactName:@"" ContactNumber:@"" ContactEmail:@"" Selected:NO];
    }

    self.profileDoc.data.title = _profileName.text;
    self.profileDoc.data.profileCode = profileCode;
    self.profileDoc.data.contactName = _contactName.text;
    self.profileDoc.data.contactNumber = _contactNumber.text;
    self.profileDoc.data.contactEmail = _contactEmail.text;
    self.profileDoc.data.selected = NO;

    [self.profileDoc saveData];

    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {

    [self setProfileName:nil];
    [self setProfileDoc:nil];
    [self setProfileCode:nil];
    [self setContactCode:nil];
    [self setContactCode:nil];
    [self setContactCode:nil];
    [self setContactCode:nil];
    [self setContactCode1:nil];
    [self setContactCode2:nil];
    [self setContactCode3:nil];
    [self setContactCode4:nil];
    [self setContactCode5:nil];
    [self setContactCode6:nil];
    [self setContactCode7:nil];
    [self setContactCode8:nil];
    [self setContainerPanel:nil];
    [self setContactName:nil];
    [self setContactNumber:nil];
    [self setContactEmail:nil];
    [super viewDidUnload];
}

@end
