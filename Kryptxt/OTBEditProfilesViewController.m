//
//  OTBEditProfilesViewController.m
//  Kryptxt
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

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    generalHelpers = [[GeneralHelpers alloc] init];
    validationMethods = [[ValidationMethods alloc] init];
    kbHelper = [[KeyboardHelper alloc] initWithViewController:self onDoneSelector:@selector(onDone)];
    peoplePicker = [[PeoplePicker alloc] initWithViewController:self onDoneSelector:@selector(onDonePicking)];

    [generalHelpers createBackgroundLayerWithView:containerPanel BorderWidth:1 CornerRadius:10 BackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:(1.0)] BorderColor:[UIColor colorWithRed:106/255.0 green:127/255.0 blue:147/255.0 alpha:(1.0)]];

    [generalHelpers addDesignToView:profileName BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:contactName BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:contactNumber BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:contactEmail BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButton)];
    
    _pickerDisplayView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 320)];
    [self.view insertSubview:_pickerDisplayView atIndex:100];
}

- (void)viewWillAppear:(BOOL)animated {

    _profiles = [ProfileDatabase loadProfileDocs];

    if (self.profileDoc == nil) {
        self.title = @"New Profile";
    }
    else {
        self.title = @"Edit Profile";

        profileName.text = _profileDoc.data.title;
        characterCountLabel.text = [NSString stringWithFormat:@"%i", profileName.text.length];
        profileCode = _profileDoc.data.profileCode;

        contactName.text = _profileDoc.data.contactName;
        contactNumber.text = _profileDoc.data.contactNumber;
        contactEmail.text = _profileDoc.data.contactEmail;

        if ([profileCode isEqualToString:@"0"]) {
            
            NSUInteger numComponents = [self numberOfComponentsInPickerView:codeGen];

            for (int i = 0; i < numComponents; i++) {
                
                UILabel *_contactCode = (UILabel *) [self.view viewWithTag:i + 100];
                _contactCode.text = [NSString stringWithFormat:@"%@", [profileCode substringWithRange:NSMakeRange(i, 1)]];
                [code appendFormat:@"%@", [profileCode substringWithRange:NSMakeRange(i, 1)]];
            }

            DLog(@"%@", code);
        }
    }

    [super viewWillAppear:animated];
    
    [kbHelper enable];
    
    kbHelper.textFieldDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {

    [kbHelper disable];
}

#pragma mark - Text Field Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 666) {
        
        int textLength = textField.text.length;
        //NSString *currentText = textField.text;
        
        if (textLength + string.length > 18 && range.length == 0) {
            
            // don't allow change
            return NO;
        }
        if (string.length > 0)
            characterCountLabel.text = [NSString stringWithFormat:@"%i", textLength + string.length];
        else
            characterCountLabel.text = [NSString stringWithFormat:@"%i", textLength - 1];
    }
    
    return YES;
}

- (IBAction)showActionSheet:(id)sender {
    
    //find height of screen to setup where the popup ends
    int height = [UIScreen mainScreen].bounds.size.height;
    int width = [UIScreen mainScreen].bounds.size.width;

    UIView *page = self.navigationController.topViewController.view;

    modalBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    modalBackground.backgroundColor = [UIColor blackColor];
    modalBackground.alpha = 0.7;
    [page insertSubview:modalBackground atIndex:2];


    navBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    navBackground.backgroundColor = [UIColor blackColor];
    navBackground.alpha = 0.7;
    [self.navigationController.view.superview insertSubview:navBackground atIndex:20];

    [self.view endEditing:YES];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];

    //find height of screen to setup where the popup ends
    CGRect initialFrame = self.view.frame;

    [_pickerDisplayView setFrame:CGRectMake(0, initialFrame.size.height - 217, 320, 320)];
    [UIView commitAnimations];


    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    codeGen = [[UIPickerView alloc] initWithFrame:pickerFrame];
    codeGen.showsSelectionIndicator = NO;
    codeGen.delegate = self;

    for (int i = 0; i < 8; i++) {
        
        int number = [[profileCode substringWithRange:NSMakeRange(i, 1)] intValue];

        [codeGen selectRow:number inComponent:i animated:YES];
    }
    [codeGen reloadAllComponents];

    [_pickerDisplayView addSubview:codeGen];

    //define the image we want to use for the selector image
    UIImage *selectorImage = [UIImage imageNamed:@"selectionIndicator.png"];
    UIView *customSelector = [[UIImageView alloc] initWithImage:selectorImage];

    //set the x and y values for where to put the selector image
    customSelector.frame = CGRectMake(codeGen.frame.origin.x, (codeGen.frame.origin.y + (codeGen.bounds.size.height / 2) - 24), codeGen.bounds.size.width, 47);



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
    
    if ([profileName isFirstResponder] && [touch view] != profileName)
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

    NSUInteger numComponents = [self numberOfComponentsInPickerView:codeGen];

    code = [NSMutableString string];

    for (NSUInteger i = 0; i < numComponents; ++i) {
        NSUInteger selectedRow = [codeGen selectedRowInComponent:i];
        NSString *title = [self pickerView:codeGen titleForRow:selectedRow forComponent:i];

        UILabel *_contactCode = (UILabel *) [self.view viewWithTag:i + 100];
        _contactCode.text = [NSString stringWithFormat:@"%@", title];
        [code appendFormat:@"%@", title];
    }

    DLog(@"%@", code);

    profileCode = code;

    modalBackground.hidden = YES;
    navBackground.hidden = YES;

    [self.view endEditing:YES];

    [self closePicker];
}

- (void)onDonePicking {

    contactNumber.text = peoplePicker.contactNumber;
    contactName.text = peoplePicker.contactName;
    contactEmail.text = peoplePicker.contactEmail;

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
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

    [peoplePicker showPicker];
}

- (void)randomize {

    for (int i = 0; i < 8; i++) {
        
        int number = (arc4random() % 9);

        [codeGen selectRow:number inComponent:i animated:YES];
    }
    [codeGen reloadAllComponents];
}

- (void)cancelButton {

    DLog(@"cancel button was clicked");

    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)saveButton {

    if (profileName.text.length == 0) {
        [validationMethods validationPopupForObject:profileName withContent:@"Profile needs a name." withView:self.view];
        return;
    }

    DLog(@"%@", self.profileDoc.data.title.lowercaseString);
    DLog(@"%@", profileName.text.lowercaseString);

    if ((self.profileDoc == nil) || (![self.profileDoc.data.title.lowercaseString isEqualToString:profileName.text.lowercaseString])) {
         
        for (int i = 0; i < _profiles.count; i++) {
            
            ProfileDoc *temp = [_profiles objectAtIndex:i];

            NSString *tempProfileName = temp.data.title.lowercaseString;
            NSString *_profileName = profileName.text.lowercaseString;

            DLog(@"%@", tempProfileName);
            DLog(@"%@", _profileName);

            if ([tempProfileName isEqualToString:_profileName]) {
                
                [validationMethods validationPopupForObject:_profileName withContent:@"Profile name is already used." withView:self.view];
                return;
            }
        }
    }

    if (profileCode == NULL || [profileCode isEqualToString:@"????????"] || [profileCode isEqualToString:@"0"] || [profileCode isEqualToString:@""]) {
        
        [validationMethods validationPopupForObject:contactCode withContent:@"Profile code needs to be selected." withView:self.view];
        return;
    }

    if (contactName.text.length == 0) {
        
        [validationMethods validationPopupForObject:contactName withContent:@"Contact needs a name." withView:self.view];
        return;
    }

    if (contactNumber.text.length == 0 && contactEmail.text.length == 0) {
        
        [validationMethods validationPopupForObject:contactNumber withContent:@"Contact needs a phone No. or Email." withView:self.view];
        return;
    }

    if (self.profileDoc == nil)
        self.profileDoc = [[ProfileDoc alloc] initWithTitle:@"" ProfileCode:@"0" ContactName:@"" ContactNumber:@"" ContactEmail:@"" Selected:NO];

    self.profileDoc.data.title = profileName.text;
    self.profileDoc.data.profileCode = profileCode;
    self.profileDoc.data.contactName = contactName.text;
    self.profileDoc.data.contactNumber = contactNumber.text;
    self.profileDoc.data.contactEmail = contactEmail.text;
    self.profileDoc.data.selected = NO;

    [self.profileDoc saveData];

    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {

    [self setProfileDoc:nil];
    profileCode = nil;
    characterCountLabel = nil;
    [super viewDidUnload];
}

@end
