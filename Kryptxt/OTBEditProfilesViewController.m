//
//  OTBEditProfilesViewController.m
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBEditProfilesViewController.h"

@implementation OTBEditProfilesViewController

@synthesize profile, popover;

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    generalHelpers = [[GeneralHelpers alloc] init];
    validationMethods = [[ValidationMethods alloc] init];
    //kbHelper = [[KeyboardHelper alloc] initWithViewController:self onDoneSelector:@selector(onDoneEditing)];
    peoplePicker = [[PeoplePicker alloc] initWithViewController:self onDoneSelector:@selector(onDonePicking)];
    appModel = [AppModel sharedManager];

    [generalHelpers createBackgroundLayerWithView:containerView BorderWidth:2 CornerRadius:10 BackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:(1.0)] BorderColor:[UIColor colorWithRed:2/255.0 green:18/255.0 blue:137/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:profileAliasText BorderWidth:1 CornerRadius:5 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:profileCodeView BorderWidth:1 CornerRadius:5 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:profileNameText BorderWidth:1 CornerRadius:5 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:profileNumberText BorderWidth:1 CornerRadius:5 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    [generalHelpers addDesignToView:profileEmailText BorderWidth:1 CornerRadius:5 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];

    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        
        pickerDisplayView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 320)];
        [self.view addSubview:pickerDisplayView];
    }
        
    [IQKeyBoardManager installKeyboardManager];
    
    textFields = [[KeyboardTextFields alloc] initWithViewController:self onDoneSelector:@selector(done)];
    
    [self setupCloseButton];
    [self setupSaveButton];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if (profile == nil) {
        
        //add the logo image to the navigation bar
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kryptxt-newprofile-title.png"]];
        [navItem setTitleView:imageView];
        //navItem.title = @"New Profile";
    }
    else {
        
        //add the logo image to the navigation bar
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kryptxt-editprofile-title.png"]];
        [navItem setTitleView:imageView];
        //navItem.title = @"Edit Profile";

        profileAliasText.text = profile.data.profileAlias;
        characterCountLabel.text = [NSString stringWithFormat:@"%i", profileAliasText.text.length];
        profileCode = profile.data.profileCode;

        profileNameText.text = profile.data.profileName;
        profileNumberText.text = profile.data.profileNumber;
        profileEmailText.text = profile.data.profileEmail;

        if (![profileCode isEqualToString:@"0"]) {
            
            NSInteger numComponents = [self numberOfComponentsInPickerView:codeGen];

            for (NSUInteger i = 0; i < numComponents; i++) {
                
                UILabel *_contactCode = (UILabel *) [self.view viewWithTag:i + 100];
                _contactCode.text = [NSString stringWithFormat:@"%@", [profileCode substringWithRange:NSMakeRange(i, 1)]];
                [code appendFormat:@"%@", [profileCode substringWithRange:NSMakeRange(i, 1)]];
            }

            NSLog(@"%@", code);
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {

}

- (void)viewDidUnload {
    
    [self setProfile:nil];
    profileCode = nil;
    characterCountLabel = nil;
    navItem = nil;
    backupCodeLabel = nil;
    backupCodeTextLabel = nil;
    sendInviteButton = nil;
    [super viewDidUnload];
}

#pragma mark - Text Field Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 1) {
        
        int textLength = textField.text.length;

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

- (IBAction)showCodePicker:(id)sender {
    
    [self resignFirstResponder];
    
    if (profileCode) {
        
        backupCode = profileCode;
        backupCodeLabel.text = profileCode;
    }

    //setup toolbar above picker
    UIToolbar *barHelper = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];

    UISegmentedControl *segPrevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Prev", @"Next", nil]];
    segPrevNext.segmentedControlStyle = UISegmentedControlStyleBar;
    segPrevNext.momentary = YES;
    [segPrevNext addTarget:self action:@selector(optionFromCodePicker:) forControlEvents:UIControlEventValueChanged];
    segPrevNext.tintColor = [UIColor colorWithRed:154/255.0 green:2/255.0 blue:28/255.0 alpha:(1.0)];
    
    UIBarButtonItem *btnExtra = [[UIBarButtonItem alloc] initWithTitle:@"Random Code" style:UIBarButtonItemStyleBordered target:self action:@selector(randomize)];
    btnExtra.tintColor = [UIColor colorWithRed:154/255.0 green:2/255.0 blue:28/255.0 alpha:(1.0)];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneCodePicking)];
    btnDone.tintColor = [UIColor colorWithRed:154/255.0 green:2/255.0 blue:28/255.0 alpha:(1.0)];
    
    UIBarButtonItem *separator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    
    [barHelper setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:segPrevNext], separator, btnExtra, separator, btnDone, nil]];
    
    //set prev button to disabled because we are at the top of the page
    [segPrevNext setEnabled:YES forSegmentAtIndex:0];
    [segPrevNext setEnabled:YES forSegmentAtIndex:1];
        
    
    
    //create the code spinner picker thingy
    codeGen = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    codeGen.showsSelectionIndicator = NO;
    codeGen.delegate = self;
    codeGen.dataSource = self;

    if (![profileCode isEqualToString:@"0"]) {
        
        //load the already selected code up on to the wheels
        for (NSUInteger i = 0; i < 8; i++) {
            
            int number = [[profileCode substringWithRange:NSMakeRange(i, 1)] intValue];
            
            [codeGen selectRow:number inComponent:i animated:YES];
        }
        [codeGen reloadAllComponents];
    }
    
    //define the image we want to use for the selector image
    UIImage *selectorImage = [UIImage imageNamed:@"selectionIndicator.png"];
    UIView *customSelector = [[UIImageView alloc] initWithImage:selectorImage];
    customSelector.alpha = 0.3;
    customSelector.frame = CGRectMake(codeGen.frame.origin.x, (codeGen.frame.origin.y + (codeGen.bounds.size.height / 2) - 24), codeGen.bounds.size.width, 47);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [codeGen setFrame:CGRectMake(0, 44, 320, 260)];

        //UIPickerView *thePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        CGRect thePickerFrame = codeGen.frame;
        thePickerFrame.origin.y = barHelper.frame.size.height;
        [codeGen setFrame:thePickerFrame];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
        
        [view addSubview:barHelper];
        [view addSubview:codeGen];
        [view addSubview:customSelector];

        UIViewController *vc = [[UIViewController alloc] init];
        [vc setView:view];
        [vc setContentSizeForViewInPopover:CGSizeMake(320, 265)];
        
        popover = [[UIPopoverController alloc] initWithContentViewController:vc];
        
        [popover presentPopoverFromRect:profileCodeView.bounds inView:profileCodeView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
    else {

        //find height of screen to setup where the popup ends
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;

        UIView *page = self.view;

        modalBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        modalBackground.backgroundColor = [UIColor blackColor];
        modalBackground.alpha = 0.3;
        [page insertSubview:modalBackground atIndex:3];

        [self.view endEditing:YES];

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];

        //find height of screen to setup where the popup ends
        CGRect initialFrame = self.view.frame;

        [pickerDisplayView setFrame:CGRectMake(0, initialFrame.size.height - 217, 320, 320)];
        [UIView commitAnimations];

        UIView *background = [[UIView alloc] initWithFrame:codeGen.frame];
        background.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [pickerDisplayView addSubview:background];
        
        [pickerDisplayView addSubview:codeGen];

        //add the custom selector indicator to the view
        [pickerDisplayView addSubview:customSelector];

        [pickerDisplayView addSubview:barHelper];

        [pickerDisplayView setBounds:CGRectMake(0, 0, 320, 405)];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    
    if ([profileAliasText isFirstResponder] && [touch view] != profileAliasText)
        [self resignFirstResponder];

    [super touchesBegan:touches withEvent:event];
}

- (void)optionFromCodePicker:(id)sender {

    [self onDoneCodePicking];

    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    UITextView *nextObj;
    
    if (segmentedControl.selectedSegmentIndex == 0)
        nextObj = (UITextView *) [self.view viewWithTag:1];
    else
        nextObj = (UITextView *) [self.view viewWithTag:2];
        
    [nextObj becomeFirstResponder];
}

- (IBAction)closeFirstPicker:(id)sender {

    [self closePicker];
}

- (void)closePicker {

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [pickerDisplayView setFrame:CGRectMake(0, 600, 320, 320)];
    [UIView commitAnimations];
}

- (IBAction)resetCode:(id)sender {
    
    if (backupCode) {
        
        NSInteger numComponents = [self numberOfComponentsInPickerView:codeGen];
        
        for (NSUInteger i = 0; i < numComponents; i++) {
            
            UILabel *_contactCode = (UILabel *) [self.view viewWithTag:i + 100];
            _contactCode.text = [NSString stringWithFormat:@"%@", [backupCode substringWithRange:NSMakeRange(i, 1)]];
        }
        
        NSLog(@"reset Profile Code to %@", backupCode);
        
        profileCode = backupCode;
        backupCodeTextLabel.hidden = YES;
        backupCodeLabel.hidden = YES;
        backupCodeLabel.text = @"00000000";
        backupCode = nil;   
    }
}

- (void)onDoneEditing {
    
    [self.view endEditing:YES];
}

- (void)onDoneCodePicking {

    NSInteger numComponents = [self numberOfComponentsInPickerView:codeGen];

    code = [NSMutableString string];

    for (NSUInteger i = 0; i < numComponents; ++i) {
        
        NSInteger selectedRow = [codeGen selectedRowInComponent:i];
        NSString *title = [self pickerView:codeGen titleForRow:selectedRow forComponent:i];

        UILabel *_contactCode = (UILabel *) [self.view viewWithTag:i + 100];
        _contactCode.text = [NSString stringWithFormat:@"%@", title];
        [code appendFormat:@"%@", title];
    }

    if (![profileCode isEqualToString:code])
        profileCode = code;
    
    DLog(@"%@", code);

    if (backupCode && (![backupCode isEqualToString:code])) {
        
        backupCodeTextLabel.hidden = NO;
        backupCodeLabel.hidden = NO; 
    }
    
    modalBackground.hidden = YES;
    navBackground.hidden = YES;

    [self.view endEditing:YES];

    if (popover)
        [popover dismissPopoverAnimated:YES];
    else
        [self closePicker];
}

- (void)onDonePicking {

    profileNameText.text = peoplePicker.profileName;
    profileNumberText.text = peoplePicker.profileNumber;
    profileEmailText.text = peoplePicker.profileEmail;

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

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
//    label.backgroundColor = [UIColor whiteColor];
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
//    label.text = [NSString stringWithFormat:@" %d", row + 1];
//    return label;    
//}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    
//    NSString *title = @"sample title";
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    
//    return attString;
//    
//}

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

- (IBAction)cancelButton:(id)sender {

    DLog(@"cancel button was clicked");

    [self closeEditViewController];
}

- (void)closeEditViewController {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)validateFields {
    
    if (profileAliasText.text.length == 0) {
        
        [validationMethods validationPopupForObject:profileAliasText withContent:@"Profile needs a Alias." withView:self.view];
        return NO;
    }
    
    DLog(@"%@", profile.data.profileAlias.lowercaseString);
    DLog(@"%@", profileNameText.text.lowercaseString);
    
    if ((profile == nil) || (![profile.data.profileAlias.lowercaseString isEqualToString:profileAliasText.text.lowercaseString])) {
        
        for (NSUInteger i = 0; i < profiles.count; i++) {
            
            ProfileDoc *temp = [profiles objectAtIndex:i];
            
            NSString *tempProfileName = temp.data.profileAlias.lowercaseString;

            if ([tempProfileName isEqualToString:profileAliasText.text.lowercaseString]) {
                
                [validationMethods validationPopupForObject:profileAliasText withContent:@"Profile Alias is already used." withView:self.view];
                return NO;
            }
        }
    }
    
    if (profileCode == NULL || [profileCode isEqualToString:@"????????"] || [profileCode isEqualToString:@"0"] || [profileCode isEqualToString:@""]) {
        
        [validationMethods validationPopupForObject:profileCodeView withContent:@"Profile code needs to be selected." withView:self.view];
        return NO;
    }
    
    if (profileNameText.text.length == 0) {
        
        [validationMethods validationPopupForObject:profileNameText withContent:@"Profile contact needs a name." withView:self.view];
        return NO;
    }
    
    if (profileNumberText.text.length == 0 && profileEmailText.text.length == 0) {
        
        [validationMethods validationPopupForObject:profileNumberText withContent:@"Profile contact needs a phone No. or Email." withView:self.view];
        return NO;
    }
    
    return YES;
}

- (void)saveButton {

    profiles = [ProfileDatabase loadProfileDocs];
    
    if (![self validateFields])
        return;

    [self saveData];
    
    [self closeEditViewController];
}

- (void)saveData {
    
    if (profile == nil)
        profile = [[ProfileDoc alloc] initWithProfileAlias:@"" ProfileCode:@"0" ProfileName:@"" ProfileNumber:@"" ProfileEmail:@"" ProfileSelected:NO];
    
    profile.data.profileAlias = profileAliasText.text;
    profile.data.profileCode = profileCode;
    profile.data.ProfileName = profileNameText.text;
    profile.data.profileNumber = profileNumberText.text;
    profile.data.profileEmail = profileEmailText.text;
    profile.data.profileSelected = profile.data.profileSelected;
    
    [profile saveData];
}

- (void)setupCloseButton {
    
    closeButton = [[LineBarButtonItem alloc] initWithTarget:self andAction:@selector(closeButton) andStyle:LineBarButtonItemStyleClose];
    closeButton.buttonColor = [UIColor colorWithRed:128/255.0 green:0/255.0 blue:128/255.0 alpha:1.0];
    closeButton.buttonHighlightColor = [UIColor colorWithRed:139.0/255.0 green:135.0/255.0 blue:136.0/255.0 alpha:0.9f];
    [navItem setLeftBarButtonItem:closeButton animated:YES];
}

- (void)closeButton {
    
    [self closeEditViewController];
}

- (void)setupSaveButton {
    
    saveButton = [[LineBarButtonItem alloc] initWithTarget:self andAction:@selector(saveButton) andStyle:LineBarButtonItemStyleSave];
    saveButton.buttonColor = [UIColor colorWithRed:0.251 green:0.251 blue:0.251 alpha:1];
    saveButton.buttonHighlightColor = [UIColor colorWithRed:139.0/255.0 green:135.0/255.0 blue:136.0/255.0 alpha:0.9f];
    [navItem setRightBarButtonItem:saveButton animated:YES];
}

#pragma mark - Invite ActionSheet Methods

- (IBAction)sendInvite:(id)sender {
    
    if (![self validateFields])
        return;
    
    [self saveData];
    
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Send Invite to friend" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Send invite by Text Message", @"Send invite by Email", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popupQuery showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //text message;
        [self sendText];
    }
    else if (buttonIndex == 1) {
        //email;
        [self sendEmail];
    }
    else if (buttonIndex == 2) {
        //cancel;
    }
}

- (NSString *)composeMessage {
    
    return [NSString stringWithFormat:@"Let's chat...secretly.\nHey, %@ check out \"Kryptxt\"! it allows us to chat privately in code. I've setup a profile for you and used this key %@ setup a profile for me using the same key and you can decypher my messages.", profileNameText.text, profileCode];
}

- (void)sendEmail {
    
    if (profile.data.profileEmail.length == 0) {
        
        [validationMethods validationPopupForObject:profileEmailText withContent:@"Profile needs an email address." withView:self.view];
        return;
    }
        
        NSString *email = profile.data.profileEmail;
    NSString *message = [self composeMessage];
        
        if (email) {
        
            NSArray *recipients = [[NSArray alloc] initWithObjects:email, nil];
            
        [appModel sendEmailWithMessageBody:message andRecipient:recipients andSubject:@"Check out Piggie Latin." inView:self];
        }
    else {
        
        [appModel sendEmailWithMessageBody:message inView:self];
    }
}

- (void)sendText {
    
    if (profile.data.profileNumber.length == 0) {
        
        [validationMethods validationPopupForObject:profileNumberText withContent:@"Profile needs a phone number." withView:self.view];
        return;
    }
    
    NSString *phone = profile.data.profileNumber;
    
    if (phone) {
        
        NSArray *recipients = [[NSArray alloc] initWithObjects:phone, nil];
        
        [appModel sendSMSer:recipients messageBody:[self composeMessage] inView:self];
}

    return;
}

@end
