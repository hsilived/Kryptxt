//
//  OTBMainViewController.m
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBMainViewController.h"

@implementation OTBMainViewController

@synthesize profile, profiles, rightDrawerButton;

#define degreesToRadians(x)(M_PI * x / 180.0)

#pragma mark - System Methods

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    generalHelpers = [[GeneralHelpers alloc] init];
    validationMethods = [[ValidationMethods alloc] init];
    appModel = [AppModel sharedManager];
    
    [generalHelpers createBackgroundLayerWithView:containerView BorderWidth:2 CornerRadius:10 BackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:(1.0)] BorderColor:[UIColor colorWithRed:2/255.0 green:18/255.0 blue:137/255.0 alpha:(1.0)]];
    
    //put border around top panel
    [generalHelpers addDesignToView:inputPanel BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];
    
    //put border around bottom panel
    [generalHelpers addDesignToView:outputPanel BorderWidth:1 CornerRadius:10 BorderColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:(1.0)]];

    //add the logo image to the navigation bar
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kryptxt-logo-b.png"]];

    //add the logo image to the navigation bar
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kryptxt-title"]];
    [navItem setTitleView:imageView];
    
    tempCode.font = [UIFont fontWithName:@"Capture it" size:tempCode.font.pointSize];
    
    //rotate the confidential image slightly in the center to look stamped
    confidentialView.transform = CGAffineTransformRotate(confidentialView.transform, degreesToRadians(8));

    downArrow.arrowDirection = ArrowDirectionDown;
    upArrow.arrowDirection = ArrowDirectionUp;
    
    [self setupKeyboardToolbar];
    
    [generalHelpers enlargeInfoButton:infoButton];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if (inputView.text.length == 0) {
        
        upArrow.hidden = YES;
        downArrow.hidden = YES;
    }

    [self setupRightMenuButton];

    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.  You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[OTBProfilesViewController class]])
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [self loadDefaults];

    [self loadProfileInfo];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self loadSlideUpMenu];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setTitle:nil];
    containerView = nil;
    confidentialView = nil;
    navBar = nil;
    navItem = nil;
    containerImage = nil;
    //[super viewDidUnload];
}

#pragma mark - Profile Methods

- (void)loadDefaults {

    profiles = [ProfileDatabase loadProfileDocs];

    if (profile == nil)
        profile = [[ProfileDoc alloc] initWithProfileAlias:@"" ProfileCode:@"0" ProfileName:@"" ProfileNumber:@"" ProfileEmail:@"" ProfileSelected:NO];

    if (profiles.count < 1) {
                
        profile.data.profileAlias = @"Default Profile";
        profile.data.profileCode = @"01234567";
        profile.data.profileName = @"Some Close Friend";
        profile.data.profileSelected = YES;

        [profile saveData];
        
        profiles = [ProfileDatabase loadProfileDocs];
    }
}

- (void)loadProfileInfo {

    profileCode = @"????????";
    tempCode.text = @"";

    for (NSUInteger i = 0; i < profiles.count; i++) {
        
        ProfileDoc *tempProfile = [profiles objectAtIndex:i];

        if (tempProfile.data.profileSelected) {
            
            //assign the selected profile to the profileDoc
            profile = tempProfile;

            if (tempProfile.data.profileCode != NULL)
                profileCode = [NSString stringWithFormat:@"%@", tempProfile.data.profileCode];

            if (![currentProfile.text isEqualToString:tempProfile.data.profileAlias]) {
            
                inputView.text = @"";
                outputView.text = @"";
            }

            currentProfile.text = tempProfile.data.profileAlias;

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

    for (NSUInteger x = 0; x < 8; x++) {
        
        [code addObject:[profileCode substringWithRange:NSMakeRange(x, 1)]];
        DLog(@"code digit %d - %@", x, [code objectAtIndex:x]);
    }

    int direction = [[code objectAtIndex:6] intValue];

    for (NSUInteger x = 1; x < 6; x++) {
        
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

    for (NSUInteger i = 0; i < alphaCode.length; i++)
        [masterCode addObject:[NSString stringWithFormat:@"%c", [alphaCode characterAtIndex:i]]];

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

- (void)clearText {

    [menu closeMenu];
    
    upArrow.hidden = YES;
    downArrow.hidden = YES;
    outputView.text = @"";
    inputView.text = @"";
}

- (void)sendEmail {

    [menu closeMenu];
    
    if (profile.data.profileEmail.length == 0) {
        
        [validationMethods validationPopupForObject:currentProfile withContent:@"Profile needs an email address." withView:self.view];
        return;
    }

    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to send first." withView:self.view];
        return;
    }

        NSString *email = profile.data.profileEmail;
    NSString *message = [self constructMessage];
        
        if (email) {
        
            NSArray *recipients = [[NSArray alloc] initWithObjects:email, nil];

        [appModel sendEmailWithMessageBody:message andRecipient:recipients andSubject:@"Check out Piggie Latin." inView:self];
        }
    else {

        [appModel sendEmailWithMessageBody:message inView:self];
    }
}

- (NSString *)constructMessage {
    
    NSString *message = outputView.text;

    return message;
}

- (void)sendText {

    [menu closeMenu];
        
//    if (profile.data.profileNumber.length == 0) {
//        
//        [validationMethods validationPopupForObject:currentProfile withContent:@"Profile needs a phone number." withView:self.view];
//        return;
//    }

    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to text first." withView:self.view];
        return;
    }

    NSString *message = [self constructMessage];
    NSString *phone = profile.data.profileNumber;
    NSArray *recipients = nil;

    if (phone)
        recipients = [[NSArray alloc] initWithObjects:phone, nil];
        
    [appModel sendSMSer:recipients messageBody:message inView:self];

    return;
    }

- (void)sendFacebook {
    
    [menu closeMenu];
    
    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to first." withView:self.view];
        return;
}

    NSString *postText = [NSString stringWithFormat:@"%@\n\nDownload Piggie Latin today.", outputView.text];
    UIImage *postImage = [appModel createPostPicWithText:postText andFacebook:YES];
    NSString *URL = @"http://itunes.apple.com/app/id595771878";

    [appModel sendFacebookWithMessage:postText andImage:postImage andURL:URL inView:self];
}

- (void)sendLikeFacebook {

    [appModel sendLikeFacebookInView:self];
}

- (void)sendTweet {
    
    [menu closeMenu];
    
    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to first." withView:self.view];
        return;
}

    NSString *postText = [NSString stringWithFormat:@"%@\n\nDownload Piggie Latin today.", outputView.text];
    UIImage *postImage = [appModel createPostPicWithText:postText  andFacebook:NO];
    NSString *url = @"http://itunes.apple.com/app/id595771878";

    [appModel sendTweetWithMessage:postText andImage:postImage andURL:url inView:self];
}

- (void)sendLikeTweet {

    [appModel sendLikeTweetInView:self];
}


- (void)CopyToClipboard {

    if (outputView.text.length == 0) {
        
        [validationMethods validationPopupForObject:inputView withContent:@"Convert a message to copy first." withView:self.view];
        return;
    }

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [generalHelpers removeCrap:outputView.text];
}

- (void)PasteFromClipboard {

    [menu closeMenu];
    
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

    if (inputView.text.length > 0) {
        
        upArrow.hidden = YES;
        downArrow.hidden = NO;

        [self convertText];
    }
}

#pragma mark - Helper Actions

- (void)showAlertWarning {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh Oh!" message:@"There is no default Profile setup, or the default Profile does not have a 'Code' setup with it. You must ensure that there is at least one profile and ensure that it is selected" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - text conversion

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    DLog(@"the %@ key was pressed", text);

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

        for (NSUInteger x = 0; x < letter.length; x++)
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

    for (NSUInteger i = 0; i < string1.length; i++) {
        
        //get the individual letter from the string
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

            for (NSUInteger x = 0; x < letter.length; x++)
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

    for (NSUInteger i = 0; i < string1.length; i++) {

        //get the individual letter from the string
        NSString *iChar = [NSString stringWithFormat:@"%c", [string1 characterAtIndex:i]];

        for (NSUInteger x = 0; x < masterCode.count; x++) {

            //get the ascii code# for each letter
            int asciiCode = [string1 characterAtIndex:i];

            if ((asciiCode > 64 && asciiCode < 91) || (asciiCode > 96 && asciiCode < 123)) {

                NSString *codeChar = [NSString stringWithFormat:@"%@", [masterCode objectAtIndex:x]];

                if ([iChar.lowercaseString isEqualToString:codeChar.lowercaseString]) {

                    if ([codeChar.lowercaseString isEqualToString:iChar])
                        temp = [[alphabet objectAtIndex:x] lowercaseString];
                    else
                        temp = [alphabet objectAtIndex:x];

                    break;
                }
            }
            else
                temp = iChar;
        }

        result = [NSString stringWithFormat:@"%@%@", result, temp];
    }

    inputView.text = result;
}

# pragma mark - Delegates & Seque Shit

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"jumpToEditProfile"] || [segue.identifier isEqualToString:@"jumpToEditProfile2"]) {
        
        OTBEditProfilesViewController *controller = segue.destinationViewController;
        controller.profile = profile;
    }
}

#pragma mark - Info Popup

- (void)infoOpen {
    
    if (infoPopup)
        [infoPopup finishCloseAnimation];
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    self.slidingViewController.panGesture.enabled = NO;
    
    infoPopup = [ModalPopup modalPopupWithDelegate:self];
    
    [infoPopup presentInView:self.view.window];
    
    [self.view addSubview:infoPopup];
}

- (void)modalPopupFinished {
    
    infoPopup = nil;
    
    if (menu.isOpen)
        [menu closeMenu];
    
    [self replaceSlidingOnPage];
    //self.slidingViewController.panGesture.enabled = YES;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([segue.identifier isEqualToString:@"jumpToEditProfile"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        OTBEditProfilesViewController *controller = (OTBEditProfilesViewController *) navigationController.topViewController;
//        controller.profile = _profileDoc;
//    }
//}

# pragma mark - slide out methods

- (void)revealUnderRight {
    
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

- (void)setupRightMenuButton {
    
    rightDrawerButton = [[LineBarButtonItem alloc] initWithTarget:self andAction:@selector(revealUnderRight) andStyle:LineBarButtonItemStyleList];
    [navItem setRightBarButtonItem:rightDrawerButton animated:YES];
    rightDrawerButton.buttonColor = [UIColor whiteColor];
    rightDrawerButton.buttonHighlightColor = [UIColor whiteColor];
}
#pragma mark - SlideUpMenu methods

- (IBAction)openSlideUpMenu:(id)sender {
    
    [validationMethods dismissAllPopTipViews];
    [menu openMenu];
}

- (void)loadSlideUpMenu {
    
    if (!menu) {
        
        menu = [SlideUpMenu SlideUpMenuWithDelegate:self];
        [self.view addSubview:menu];
        
        menu.blur = YES;
        menu.blurType = BlurTypeDark;
        menu.menuBackgroundColor = 0.1f;
        
        NSArray *icon1 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStyleMessage], @"Text", @"sendText", nil];
        NSArray *icon2 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStyleEmail], @"Email", @"sendEmail", nil];
        //NSArray *icon3 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStyleFacebook], @"Facebook", @"sendFacebook", nil];
        //NSArray *icon4 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStyleTwitter], @"Twitter", @"sendTweet", nil];
        //        NSArray *icon5 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStyleWhatsApp], @"Whatsapp", @"whatsappMethod", nil];
        //        NSArray *icon6 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStyleInstagram], @"Instagram", @"instagramMethod", nil];
        //        NSArray *icon7 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpIconButtonStylePinterest], @"Pinterest", @"pinterestMethod", nil];
        
        NSArray *button1 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleTrash], @"Clear", @"clearText", nil];
        NSArray *button2 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleCopy], @"Copy", @"CopyToClipboard", nil];
        NSArray *button3 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStylePaste], @"Paste", @"PasteFromClipboard", nil];
        //NSArray *button4 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleTags], @"Favorite", @"saveTag", nil];
        //        NSArray *button5 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleDef], @"- Acro", @"saveAcro", nil];
        //        NSArray *button6 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleDef], @"- Def", @"saveDef", nil];
        //NSArray *button7 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleInfo], @"Intro", @"introOpen", nil];
        NSArray *button8 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SlideUpLineButtonStyleHints], @"About", @"infoOpen", nil];
        
        menu.sections = [NSArray arrayWithObjects:[NSArray arrayWithObjects:icon1, icon2, nil], [NSArray arrayWithObjects:button1, button2, button3, button8, nil], nil];
        [menu presentInView:self.view];
    }
}

- (void)slideUpMenuOpened {
    
    //blockerView.hidden = NO;
    [self removeSlidingOnPage];
}

- (void)slideUpMenuClosed {
    
    //blockerView.hidden = YES;
    
    //if (!hintsOpen)
        [self replaceSlidingOnPage];
}

- (void)removeSlidingOnPage {
    
    self.slidingViewController.panGesture.enabled = NO;
    self.slidingViewController.resetStrategy = ECNone;
}

- (void)replaceSlidingOnPage {
    
    if (!menu.isOpen) {
        
        self.slidingViewController.panGesture.enabled = YES;
        self.slidingViewController.resetStrategy = ECPanning | ECTapping;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [menu reloadMenu];
}

@end
