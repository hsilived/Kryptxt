//
//  OTBMainViewController.m
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBMainViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "OTBNavigationTitle.h"

@implementation OTBMainViewController

#pragma mark - System Methods
#define degreesToRadians(x)(M_PI * x / 180.0)

@synthesize profiles = _profiles;

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    generalHelpers = [[GeneralHelpers alloc] init];
    validationMethods = [[ValidationMethods alloc] init];
    
    [generalHelpers createBackgroundLayerWithView:containerPanel BorderWidth:1 CornerRadius:10 BackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:(1.0)] BorderColor:[UIColor colorWithRed:106/255.0 green:127/255.0 blue:147/255.0 alpha:(1.0)]];
    
    //put border around top panel
    [generalHelpers addDesignToView:inputPanel BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    
    //put border around bottom panel
    [generalHelpers addDesignToView:outputPanel BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];

    //add the logo image to the navigation bar
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kryptxt-logo-b.png"]];

    OTBNavigationTitle *imageView = [[OTBNavigationTitle alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];
    
    //navItem.titleView = imageView;
    [navItem setTitleView:imageView];
    //[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:228/255.0 green:231/255.0 blue:238/255.0 alpha:1.0]];
    //[navBar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                [UIColor colorWithRed:128/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], UITextAttributeTextColor,
//                                [UIColor whiteColor], UITextAttributeTextShadowColor,
//                                [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset,
//                                nil];
//    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
//    
    //[self.navigationController setToolbarHidden:NO];
    
    [self setupRightMenuButton];
    
    tempCode.font = [UIFont fontWithName:@"Capture it" size:tempCode.font.pointSize];

    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[OTBProfilesViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//    [doubleTap setNumberOfTapsRequired:2];
//    [self.view addGestureRecognizer:doubleTap];
//    
//    UITapGestureRecognizer *twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
//    [twoFingerDoubleTap setNumberOfTapsRequired:2];
//    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
//    [self.view addGestureRecognizer:twoFingerDoubleTap];
    //[self setupRightMenuButton];
    
    confidentalView.transform = CGAffineTransformRotate(confidentalView.transform, degreesToRadians(8));
    [self setupKeyboardToolbar];
    
    [generalHelpers enlargeInfoButton:infoButton];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    NSLog(@"Center will appear");
    
    if (inputView.text.length == 0) {
        
        upArrow.hidden = YES;
        downArrow.hidden = YES;
    }

    [self loadDefaults];

    [self loadProfileInfo];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"Center did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"Center will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"Center did disappear");
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setTitle:nil];
    containerPanel = nil;
    confidentalView = nil;
    navBar = nil;
    navItem = nil;
    containerImage = nil;
    [super viewDidUnload];
}

#pragma mark - Profile Methods

- (void)loadDefaults {

    _profiles = [ProfileDatabase loadProfileDocs];

    if (self.profileDoc == nil) {
        
        self.profileDoc = [[ProfileDoc alloc] initWithTitle:@"" ProfileCode:@"0" ContactName:@"" ContactNumber:@"" ContactEmail:@"" Selected:NO];
    }

    if (_profiles.count < 1) {
        
        self.profileDoc.data.title = @"Default Profile";
        self.profileDoc.data.profileCode = @"01234567";
        self.profileDoc.data.contactName = @"Some Close Friend";
        self.profileDoc.data.selected = YES;

        [self.profileDoc saveData];
    }
}

- (void)loadProfileInfo {

    _profiles = [ProfileDatabase loadProfileDocs];
    profileCode = @"????????";
    tempCode.text = @"";

    for (int i = 0; i < _profiles.count; i++) {
        
        ProfileDoc *doc = [_profiles objectAtIndex:i];

        if (doc.data.selected) {
            
            //assign the selected profile to the profileDoc
            _profileDoc = doc;

            if (doc.data.profileCode != NULL)
                profileCode = [NSString stringWithFormat:@"%@", doc.data.profileCode];

            if (![currentProfile.text isEqualToString:doc.data.title]) {
                inputView.text = @"";
                outputView.text = @"";
            }

            currentProfile.text = doc.data.title;

            break;
        }
    }

    if ([profileCode isEqualToString:@"????????"] || [profileCode isEqualToString:@"0"] || [profileCode isEqualToString:@""]) {
        [self showAlertWarning];
    }
    else {
        
        alphaCode = @"";

        letterBlock1 = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", nil];
        letterBlock2 = [NSMutableArray arrayWithObjects:@"E", @"F", @"G", @"H", @"I", @"J", @"K", nil];
        letterBlock3 = [NSMutableArray arrayWithObjects:@"L", @"M", @"N", nil];
        letterBlock4 = [NSMutableArray arrayWithObjects:@"O", @"P", @"Q", @"R", @"S", nil];
        letterBlock5 = [NSMutableArray arrayWithObjects:@"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];

        alphabet = [NSMutableArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];

        [self setupProfileCode];
    }
}

- (void)setupProfileCode {

    tempCode.text = profileCode;

    NSMutableArray *code = [NSMutableArray arrayWithCapacity:8];

    for (int x = 0; x < 8; x++) {
        
        [code addObject:[profileCode substringWithRange:NSMakeRange(x, 1)]];
        DLog(@"code digit %d - %@", x, [code objectAtIndex:x]);
    }

    int direction = [[code objectAtIndex:6] intValue];

    for (int x = 1; x < 6; x++) {
        
        int shift = [[code objectAtIndex:x] intValue];

        switch (x) {
            case 1:
                [self rearrangeArray:letterBlock1 WithShift:shift WithDirection:direction];
                [self compileAlphaCodeWithArray:letterBlock1];
                break;

            case 2:
                [self rearrangeArray:letterBlock2 WithShift:shift WithDirection:direction];
                [self compileAlphaCodeWithArray:letterBlock2];
                break;

            case 3:
                [self rearrangeArray:letterBlock3 WithShift:shift WithDirection:direction];
                [self compileAlphaCodeWithArray:letterBlock3];
                break;

            case 4:
                [self rearrangeArray:letterBlock4 WithShift:shift WithDirection:direction];
                [self compileAlphaCodeWithArray:letterBlock4];
                break;

            case 5:
                [self rearrangeArray:letterBlock5 WithShift:shift WithDirection:direction];
                [self compileAlphaCodeWithArray:letterBlock5];
                break;

            default:
                break;
        }
    }

    DLog(@"AlphaCode %@", alphaCode);

    masterCode = [[NSMutableArray alloc] initWithCapacity:alphaCode.length];
    for (int i = 0; i < alphaCode.length; i++) {
        NSString *ichar = [NSString stringWithFormat:@"%c", [alphaCode characterAtIndex:i]];
        [masterCode addObject:ichar];
    }

    DLog(@"_masterCode count %d", masterCode.count);
}

- (NSString *)compileAlphaCodeWithArray:(NSMutableArray *)array {

    return alphaCode = [NSString stringWithFormat:@"%@%@", alphaCode, [[array valueForKey:@"description"] componentsJoinedByString:@""]];
}

- (NSMutableArray *)rearrangeArray:(NSMutableArray *)array WithShift:(NSInteger)shift WithDirection:(NSInteger)direction {

    if (shift > array.count) {
        
        do shift = shift - array.count;
        while (shift > array.count);
    }

    if (shift == array.count)
        shift = 1;

    if (direction % 2 != 0)
        shift = -shift;

    if (shift == 0) {
        
        //let's mix this up and send this shift opposite all of the others
        if ((direction % 2 != 0) || (direction == 0))
            shift = -1;
        else
            shift = 1;
    }

    NSInteger count = array.count;

    DLog(@"shift %d", shift);

    if (shift > 0) {
        
        //shifting letters to the right
        for (NSInteger i = shift; i > 0; i--) {
            NSObject *obj = [array lastObject];
            [array insertObject:obj atIndex:0];
            [array removeLastObject];
        }
    }
    else {
        
        //shifting letters to the left
        for (NSInteger i = -shift; i > 0; i--) {
            NSObject *obj = [array objectAtIndex:0];
            [array insertObject:obj atIndex:array.count];
            [array removeObjectAtIndex:0];
        }
    }

    for (int x = 0; x < count; x++)
        DLog(@"array %@", [array objectAtIndex:x]);

    return array;
}


#pragma mark - ActionSheet Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        //clear text;
        [self clearText];
    }
    if (buttonIndex == 1) {
        //text message;
        [self sendText];
    }
    else if (buttonIndex == 2) {
        //email;
        [self sendEmail];
    }
    else if (buttonIndex == 3) {
        //copy;
        [self CopyToClipboard];
    }
    else if (buttonIndex == 4) {
        //paste;
        [self PasteFromClipboard];
    }
    else if (buttonIndex == 5) {
        //cancel;
    }
}

- (void)clearText {

    upArrow.hidden = YES;
    downArrow.hidden = YES;
    outputView.text = @"";
    inputView.text = @"";
}

- (void)sendEmail {

    if (_profileDoc.data.contactEmail.length == 0) {
        
        [validationMethods validationPopupForObject:currentProfile withContent:@"Profile needs an email address." withView:self.view];
        return;
    }

    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to send first." withView:self.view];
        return;
    }

    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
        mailComposeVC.mailComposeDelegate = self;

        NSString *email = _profileDoc.data.contactEmail;
        
        if (email) {
            NSArray *recipients = [[NSArray alloc] initWithObjects:email, nil];

            [mailComposeVC setToRecipients:recipients];
        }

        [mailComposeVC setSubject:@"Email Subject here."];
        [mailComposeVC setMessageBody:outputView.text isHTML:NO];
        [self presentModalViewController:mailComposeVC animated:YES];

    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    [controller dismissModalViewControllerAnimated:YES];
}

- (void)sendText {

    if (_profileDoc.data.contactNumber.length == 0) {
        
        [validationMethods validationPopupForObject:currentProfile withContent:@"Profile needs a phone number." withView:self.view];
        return;
    }

    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to text first." withView:self.view];
        return;
    }

    NSString *phone = _profileDoc.data.contactNumber;

    if (phone) {
        
        NSArray *recipients = [[NSArray alloc] initWithObjects:phone, nil];

        [self sendSMSer:recipients messageBody:outputView.text];
    }
}

- (void)sendSMSer:(NSArray *)toRecipient messageBody:(NSString *)messageBody {

    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;

    messageController.recipients = toRecipient;
    messageController.body = messageBody;
    [self presentModalViewController:messageController animated:YES];
}

- (void)messageComposeViewControllerDidCancel:(MFMessageComposeViewController *)messageController {

    [self dismissModalViewControllerAnimated:YES];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)messageController didFinishWithResult:(MessageComposeResult)result {

    [self dismissModalViewControllerAnimated:YES];
}


- (void)CopyToClipboard {

    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to copy first." withView:self.view];
        return;
    }

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = outputView.text;
}

- (void)PasteFromClipboard {

    upArrow.hidden = NO;
    downArrow.hidden = YES;

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    outputView.text = [NSString stringWithFormat:@"%@", pasteboard.string];

    [self decryptText];
}


#pragma mark - top Keyboard bar setup & events

- (void)setupKeyboardToolbar {
    
    //add the done and cancel bar to the keyboard
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    keyboardToolbar.barStyle = UIBarStyleBlack;
    keyboardToolbar.items = [NSArray arrayWithObjects:
            [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelKeyboard)],
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
            [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneKeyboard)],
            nil];

    [keyboardToolbar sizeToFit];
    inputView.inputAccessoryView = keyboardToolbar;
}

- (void)cancelKeyboard {

    [inputView resignFirstResponder];
    inputView.text = @"";
}

- (void)doneKeyboard {

    [inputView resignFirstResponder];

    if ([profileCode isEqualToString:@"????????"] || [profileCode isEqualToString:@"0"] || [profileCode isEqualToString:@""]) {
        [self showAlertWarning];
        return;
    }

    upArrow.hidden = YES;
    downArrow.hidden = NO;

    [self convertText];
}


#pragma mark - Helper Actions

- (void)showAlertWarning {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh Oh!" message:@"There is no default Profile setup, or the default Profile does not have a 'Code' setup with it. You must ensure that there is at least one profile and ensure that it is selected" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    DLog(@"the %@ key was pressed", text);

//encrypt the individual letter
//[self encryptLetter: text];

//ALERT this probably needs to come off when outputting to devices
//inputView.text = [textView.text stringByAppendingString:text];

    return TRUE;
}

- (void)encryptLetter:(NSString *)letter {

    NSString *temp;

    if (letter.length == 1) {
        
        //get the ascii code# for each letter
        unichar asciiCode = [letter characterAtIndex:0];

        DLog(@"asciiCode - %d", asciiCode);

        //check if the letter is an alpha character
        if ((asciiCode > 64 && asciiCode < 91) || (asciiCode > 96 && asciiCode < 123)) {
            
            //check if it lowercase or uppercase
            if ([letter.lowercaseString isEqualToString:letter])
                temp = [[masterCode objectAtIndex:(asciiCode - 96 - 1)] lowercaseString];
            else
                temp = [masterCode objectAtIndex:(asciiCode - 64 - 1)];
        }
        else
            temp = letter;

        DLog(@"should output - %@", temp);

        outputView.text = [NSString stringWithFormat:@"%@%@", outputView.text, temp];
    }
    else if (letter.length > 1) {
        outputView.text = [outputView.text substringWithRange:NSMakeRange(0, outputView.text.length - letter.length)];

        for (int x = 0; x < letter.length; x++)
            [self encryptLetter:[letter substringWithRange:NSMakeRange(x, 1)]];
    }
    else {
        DLog(@"should output backspace");

        outputView.text = [outputView.text substringWithRange:NSMakeRange(0, outputView.text.length - 1)];
    }
    DLog(@"outputView - %@", outputView.text);
}

- (void)convertText {

    NSString *string1;

    outputView.text = @"";

    string1 = inputView.text;

    if (string1.length < 1)
        return;

    for (int i = 0; i < string1.length; i++) {
        
        //get the idividual letter from the string
        NSString *letter = [NSString stringWithFormat:@"%c", [string1 characterAtIndex:i]];


        NSString *temp;

        if (letter.length == 1) {
            
            //get the ascii code# for each letter
            unichar asciiCode = [letter characterAtIndex:0];

            DLog(@"asciiCode - %d", asciiCode);

            //check if the letter is an alpha character
            if ((asciiCode > 64 && asciiCode < 91) || (asciiCode > 96 && asciiCode < 123)) {
                
                //check if it lowercase or uppercase
                if ([letter.lowercaseString isEqualToString:letter])
                    temp = [[masterCode objectAtIndex:(asciiCode - 96 - 1)] lowercaseString];
                else
                    temp = [masterCode objectAtIndex:(asciiCode - 64 - 1)];
            }
            else
                temp = letter;

            DLog(@"should output - %@", temp);

            outputView.text = [NSString stringWithFormat:@"%@%@", outputView.text, temp];
        }
        else if (letter.length > 1) {
            
            outputView.text = [outputView.text substringWithRange:NSMakeRange(0, outputView.text.length - letter.length)];

            for (int x = 0; x < letter.length; x++)
                [self encryptLetter:[letter substringWithRange:NSMakeRange(x, 1)]];
        }
        else {
            
            DLog(@"should output backspace");

            outputView.text = [outputView.text substringWithRange:NSMakeRange(0, outputView.text.length - 1)];
        }

        DLog(@"outputView - %@", outputView.text);
    }
}

- (void)decryptText {

    NSString *string1, *result = @"", *temp = @"";

    //close keyboard
    [inputView resignFirstResponder];

    string1 = outputView.text;

    if (string1.length < 1)
        return;

    for (int i = 0; i < string1.length; i++) {

        //get the idividual letter from the string
        NSString *ichar = [NSString stringWithFormat:@"%c", [string1 characterAtIndex:i]];

        for (int x = 0; x < masterCode.count; x++) {

            //get the ascii code# for each letter
            int asciiCode = [string1 characterAtIndex:i];

            if ((asciiCode > 64 && asciiCode < 91) || (asciiCode > 96 && asciiCode < 123)) {
                NSString *codeChar = [NSString stringWithFormat:@"%@", [masterCode objectAtIndex:x]];

                if ([ichar.lowercaseString isEqualToString:codeChar.lowercaseString]) {

                    if ([codeChar.lowercaseString isEqualToString:ichar])
                        temp = [[alphabet objectAtIndex:x] lowercaseString];
                    else
                        temp = [alphabet objectAtIndex:x];

                    break;
                }
            }
            else
                temp = ichar;
        }

        result = [NSString stringWithFormat:@"%@%@", result, temp];
    }

    inputView.text = result;
}


#pragma mark - IBActions

- (IBAction)showActionSheet:(id)sender; {

    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Send Message" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Clear Text", @"Text Message", @"Email", @"Copy", @"Paste", nil];

    popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popupQuery showInView:self.view];
}

- (IBAction)infoOpen:(UIButton *)sender {

    OTBModalPopup *acSheet = [OTBModalPopup modalPopupWithDelegate:self];
//	acSheet.dismissAfterwards = YES; // Default: NO
//	acSheet.shouldDrawShadow = NO;   // Default: YES

//NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
//UIView* v2 =  [views objectAtIndex:0];

    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v1 = [views objectAtIndex:1];

    views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v3 = [views objectAtIndex:2];

    views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v4 = [views objectAtIndex:3];

    views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v5 = [views objectAtIndex:4];

    views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v6 = [views objectAtIndex:5];

    views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v7 = [views objectAtIndex:6];

    views = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:self options:nil];
    UIView *v8 = [views objectAtIndex:7];

// Put the views inside an NSArray:
    NSArray *pages = [NSArray arrayWithObjects:v1, v3, v4, v5, v6, v7, v8, nil];

    [acSheet setPagesInArray:pages]; // next page
    [acSheet presentInView:sender.superview.window];
}

# pragma mark - slideout methods

//- (void)doubleTap:(UITapGestureRecognizer *)gesture {
//    
//    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
//}
//
//- (void)twoFingerDoubleTap:(UITapGestureRecognizer *)gesture {
//    
//    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"jumpToEditProfile"]) {
        
        OTBEditProfilesViewController *controller = segue.destinationViewController;
        //UINavigationController *navigationController = segue.destinationViewController;
        //OTBEditProfilesViewController *controller = (OTBEditProfilesViewController *) navigationController.topViewController;
        //editProfileViewController = [[OTBEditProfilesViewController alloc] init];
        controller.profile = _profileDoc;
    }
}

- (IBAction)revealUnderRight:(id)sender {
    
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (void)setupRightMenuButton {
    
    MMDrawerBarButtonItem *rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(revealUnderRight:)];
    [navItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

@end
