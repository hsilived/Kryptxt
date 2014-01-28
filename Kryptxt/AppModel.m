//
//  AppModel.m
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "AppModel.h"
#import "OTBIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "Reachability.h"

static AppModel *sharedManager;

@implementation AppModel

@synthesize firstTime, borderColor, reachable;

+ (AppModel *)sharedManager {
    
	static dispatch_once_t done;
	dispatch_once(&done, ^{ sharedManager = [[AppModel alloc] init]; });
    
	return sharedManager;
}

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        [self loadSettings];

        borderColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        
        //check for internet connection
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        Reachability *reach = [Reachability reachabilityWithHostname:@"www.google.com"];
        reach.reachableOnWWAN = YES;
        reach.reachableBlock = ^(Reachability * reachability) {
            dispatch_async(dispatch_get_main_queue(), ^{
                reachable = YES;
            });
        };
        
        reach.unreachableBlock = ^(Reachability * reachability) {
            dispatch_async(dispatch_get_main_queue(), ^{
                reachable = NO;
            });
        };
        
        [reach startNotifier];
    }
    
    return self;
}

#pragma mark - String Methods

- (NSString *)cleanText:(NSString *)text {
    
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    text = [text stringByReplacingOccurrencesOfString:@"..." withString:@"…"];
    
    text = [text stringByReplacingOccurrencesOfString:@"FUCK" withString:@"F**K"];
    text = [text stringByReplacingOccurrencesOfString:@"Fuck" withString:@"F**k"];
    text = [text stringByReplacingOccurrencesOfString:@"fuck" withString:@"f**k"];
    text = [text stringByReplacingOccurrencesOfString:@"BITCH" withString:@"B**CH"];
    text = [text stringByReplacingOccurrencesOfString:@"Bitch" withString:@"B**ch"];
    text = [text stringByReplacingOccurrencesOfString:@"bitch" withString:@"b**ch"];
    text = [text stringByReplacingOccurrencesOfString:@"CUNT" withString:@"C*NT"];
    text = [text stringByReplacingOccurrencesOfString:@"Cunt" withString:@"C*nt"];
    text = [text stringByReplacingOccurrencesOfString:@"cunt" withString:@"c*nt"];
    text = [text stringByReplacingOccurrencesOfString:@"COCK" withString:@"C*CK"];
    text = [text stringByReplacingOccurrencesOfString:@"Cock" withString:@"C*ck"];
    text = [text stringByReplacingOccurrencesOfString:@"cock" withString:@"c*ck"];
    text = [text stringByReplacingOccurrencesOfString:@"SHIT" withString:@"SH*T"];
    text = [text stringByReplacingOccurrencesOfString:@"Shit" withString:@"Sh*t"];
    text = [text stringByReplacingOccurrencesOfString:@"shit" withString:@"sh*t"];
    
    return text;
}

- (NSString *)unConvertText:(NSString *)text {
    
    text = [text stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"&40;" withString:@"@"];
    text = [text stringByReplacingOccurrencesOfString:@"&#044;" withString:@","];
    text = [text stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    //text = [text stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    text = [text stringByReplacingOccurrencesOfString:@"&43;" withString:@"+"];
    text = [text stringByReplacingOccurrencesOfString:@"’" withString:@"'"];
    text = [text stringByReplacingOccurrencesOfString:@"'" withString:@"\'"];
    
    return text;
}

- (NSString *)stripTextOfSpaces:(NSString *)text {
    
    text = text.lowercaseString;
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"?" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"!" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@":" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@";" withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"." withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@"," withString:@" "];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return text;
}

+ (NSString *)CapitalizeSentences:(NSString *)stringToProcess {
    
    NSMutableString *processedString = [stringToProcess mutableCopy];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    
    // Ironically, the tokenizer will only tokenize sentences if the first letter of the sentence is capitalized...
    stringToProcess = [stringToProcess uppercaseStringWithLocale:locale];

    CFStringTokenizerRef stringTokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, (__bridge CFStringRef)(stringToProcess), CFRangeMake(0, [stringToProcess length]), kCFStringTokenizerUnitSentence, (__bridge CFLocaleRef)(locale));
    
    while (CFStringTokenizerAdvanceToNextToken(stringTokenizer) != kCFStringTokenizerTokenNone) {
        
        CFRange sentenceRange = CFStringTokenizerGetCurrentTokenRange(stringTokenizer);
        
        if (sentenceRange.location != kCFNotFound && sentenceRange.length > 0) {
            
            NSRange firstLetterRange = NSMakeRange(sentenceRange.location, 1);
            
            NSString *uppercaseFirstLetter = [[processedString substringWithRange:firstLetterRange] uppercaseStringWithLocale:locale];
            
            [processedString replaceCharactersInRange:firstLetterRange withString:uppercaseFirstLetter];
        }
    }
    
    CFRelease(stringTokenizer);
    
    return processedString;
}

- (NSUInteger)countOccurrencesOfString:(NSString *)search FromString:(NSString *)str {
    
    NSUInteger count = 0, length = [str length];
    NSRange range = NSMakeRange(0, length);
    
    while(range.location != NSNotFound) {
        
        range = [str rangeOfString: search options:0 range:range];
        
        if(range.location != NSNotFound) {
            
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    
    return count;
}

- (void)loadSettings {
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    if ([settings objectForKey:@"firstTime"] != nil)
        firstTime = [settings boolForKey:@"firstTime"];
    else {
        
        firstTime = YES;
        [settings setBool:firstTime forKey:@"firstTime"];
        
        [settings synchronize];
    }
}

#pragma mark - View rotaters

//- (void)rotateLeft:(UIView *)someView {
//
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.0];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    someView.transform = CGAffineTransformRotate(someView.transform, (-90 * M_PI / 180));
//    [UIView commitAnimations];
//}
//
//- (void)rotateRight:(UIView *)someView {
//
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.0];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    someView.transform = CGAffineTransformRotate(someView.transform, (90 * M_PI / 180));
//    [UIView commitAnimations];
//}

- (CGSize)currentSize {
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        size = CGSizeMake(size.height, size.width);
    
    if (!application.statusBarHidden)
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    
    //size.height -= view.navigationController.navigationBar.frame.size.height;
    return size;
}

- (void)adjustTextForObject:(UITextView *)tv {
    
    int tvBoundsHeight = tv.bounds.size.height;
    int tvContentSizeHeight = tv.contentSize.height;
    int tvZoomScale = tv.zoomScale;
    
    CGSize size = [tv.text sizeWithFont:tv.font constrainedToSize:CGSizeMake(tv.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    //labelFrame = label.frame;
    //labelFrame.size.height = size.height;
    //label.frame = labelFrame;
    
    if (size.height >= tvBoundsHeight) {
        
        int dif = size.height - tvBoundsHeight + 20;
        tv.frame = CGRectMake(tv.frame.origin.x, tv.frame.origin.y - (dif / 2), tv.frame.size.width, tv.frame.size.height + dif);
    }
    
    CGFloat topCorrect = (tvBoundsHeight - tvContentSizeHeight * tvZoomScale) / 2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    
    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
    tv.textAlignment = NSTextAlignmentCenter;
}

- (void)centerTextInTextView:(UITextView *)tv {
    
    CGFloat topCorrect = (tv.bounds.size.height - tv.contentSize.height * tv.zoomScale) / 2.0;
    topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
    tv.contentOffset = (CGPoint){ .x = 0, .y = -topCorrect};
}
    
- (void)adjustInfoTextForObject:(UITextView *)tv {
    
    int tvBoundsHeight = tv.bounds.size.height;
    int tvContentSizeHeight = tv.contentSize.height;
    int tvZoomScale = tv.zoomScale;
    
    CGSize size = [tv.text sizeWithFont:tv.font constrainedToSize:CGSizeMake(tv.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    if (size.height >= tvBoundsHeight) {
        
        int dif = size.height - tvBoundsHeight + 20;
        tv.frame = CGRectMake(tv.frame.origin.x, tv.frame.origin.y, tv.frame.size.width, tv.frame.size.height + dif);
    }
    
    CGFloat topCorrect = (tvBoundsHeight - tvContentSizeHeight * tvZoomScale) / 2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    
    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
}

#pragma mark - Message Methods

- (void)sendSMSer:(NSArray *)toRecipient messageBody:(NSString *)messageBody inView:(UIViewController *)vc {
    
    parent = vc;
    
    Class message = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (message != nil) {
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        
        messageController.recipients = toRecipient;
        messageController.body = messageBody;
        
        if ([message canSendText])
            [parent presentViewController:messageController animated:YES completion:nil];
    }
}

- (void)messageComposeViewControllerDidCancel:(MFMessageComposeViewController *)messageController {
    
    [parent dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)messageController didFinishWithResult:(MessageComposeResult)result {
    
    [parent dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendEmailWithMessageBody:(NSString *)messageBody inView:(UIViewController *)vc {
    
    [self sendEmailWithMessageBody:messageBody andSubject:@"Check out Kryptxt." inView:vc];
}

- (void)sendEmailWithMessageBody:(NSString *)messageBody andSubject:(NSString *)subject inView:(UIViewController *)vc {
    
    parent = vc;
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
        mailComposeVC.mailComposeDelegate = self;
        //[mailComposeVC setToRecipients:nil];
        [mailComposeVC setSubject:subject];
        [mailComposeVC setMessageBody:messageBody isHTML:NO];
        [parent presentViewController:mailComposeVC animated:YES completion:nil];
        
    }
}

- (void)sendEmailWithMessageBody:(NSString *)messageBody andRecipient:(NSArray *)recipient andSubject:(NSString *)subject inView:(UIViewController *)vc {
    
    parent = vc;
    
    MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
    mailComposeVC.mailComposeDelegate = self;
    
    if ([MFMailComposeViewController canSendMail]) {

        [mailComposeVC setToRecipients:recipient];
        [mailComposeVC setSubject:subject];
        [mailComposeVC setMessageBody:messageBody isHTML:NO];
        [mailComposeVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [parent presentViewController:mailComposeVC animated:YES completion:nil];
        
    }
}

//- (void)email {
//    
//    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
//    [composer setMailComposeDelegate:self];
//    
//    if ([MFMailComposeViewController canSendMail]) {
//        [composer setToRecipients:[NSArray arrayWithObjects:@"xyz@gmail.com", nil]];
//        [composer setSubject:@""];
//        
//        //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
//        
//        [composer setMessageBody:@"" isHTML:NO];
//        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//        [parent presentViewController:composer animated:YES completion:nil];
//    }
//    else {
//    }
//}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (error) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [parent dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [parent dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)isSocialFrameworkAvailable {
    
    // whether the iOS6 Social framework is available?
    return NSClassFromString(@"SLComposeViewController") != nil;
}

+ (BOOL)isTwitterAvailable {
    
    static BOOL available;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        available = NSClassFromString(@"TWTweetComposeViewController") != nil;
    });
    return available;
}

+ (BOOL)isSocialAvailable {
    
    static BOOL available;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        available = NSClassFromString(@"SLComposeViewController") != nil;
    });
    return available;
}

- (UIImage *)createPostPicWithText:(NSString *)text andFacebook:(BOOL)facebook {
    
    int width, start = 0;
    
    if (facebook) {
        width = 500;
        start = 154;
    }
    else {
        width = 346;
    }
    
    UIView *screenGrabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 144)];
    screenGrabView.backgroundColor = [UIColor whiteColor];
    
    if (facebook) {
    
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-72@2x.png"]];
        tempImageView.frame = CGRectMake(0, 0, 144, 144);
        [screenGrabView addSubview:tempImageView];
    }
    
    UILabel *piggieLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 5, 346, 20)];
    piggieLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20.0];
    piggieLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    piggieLabel.text = @"Kryptxt says....";
    
    UILabel *defLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 50, 346, 94)];
    defLabel.text = [self unConvertText:text];
    defLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:22.0];
    defLabel.lineBreakMode = NSLineBreakByWordWrapping;
    defLabel.numberOfLines = 0;
    [defLabel sizeToFit];
    
    [screenGrabView addSubview:piggieLabel];
    [screenGrabView addSubview:defLabel];
    
    UIGraphicsBeginImageContext(screenGrabView.frame.size);
    [screenGrabView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return sourceImage;
}

- (void)sendLikeFacebookInView:(UIViewController *)vc {
    
    NSString *postText = @"Want to talk in fun secret code? Kryptxt is an app that can help you talk to your friends in a cool language.\n\nDownload Kryptxt today.";
    UIImage *postImage = [UIImage imageNamed:@"Icon-72@2x.png"];
    NSString *URL = @"http://itunes.apple.com/app/id595771878";
    
    [self sendFacebookWithMessage:postText andImage:postImage andURL:URL inView:vc];
}

- (void)sendFacebookWithMessage:(NSString *)message andImage:(UIImage *)image andURL:(NSString *)url inView:(UIViewController *)vc {
    
    parent = vc;
    message = [self unConvertText:message];
    
    if ([AppModel isSocialAvailable] && [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [composeController setInitialText:message];
        
        if (image != nil)
            [composeController addImage:image];
        
        if (url && ![url  isEqual: @""])
            [composeController addURL: [NSURL URLWithString:url]];
        
        [parent presentViewController:composeController animated:YES completion:nil];
    }
}

- (void)sendLikeTweetInView:(UIViewController *)vc {
    
    NSString *postText = [NSString stringWithFormat:@"Want to talk in fun secret code? Kryptxt is just the app."];
    UIImage *postImage = [UIImage imageNamed:@"Icon-72@2x.png"];
    NSString *url = @"http://itunes.apple.com/app/id595771878";//37 characters
    
    [self sendTweetWithMessage:postText andImage:postImage andURL:url inView:vc];
}

- (void)sendTweetWithMessage:(NSString *)message andImage:(UIImage *)image andURL:(NSString *)url inView:(UIViewController *)vc {
    
    parent = vc;
    message = [self unConvertText:message];
    
    // prepare the message to be shared
    NSString *combineMessage = message;
    //NSString *combineMessage = [NSString stringWithFormat:@"%@ %@", [message substringToIndex:100], url];
    NSString *escapedMessage = [combineMessage stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    RLog(@"%@", escapedMessage);
    NSString *appURL = [NSString stringWithFormat:@"twitter://post?message=%@", escapedMessage];
    
    
    if ([AppModel isSocialAvailable] &&  [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        //Create an instance of the Tweet Sheet
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // Sets the completion handler.  Note that we don't know which thread the block will be called on, so we need to ensure that any UI updates occur on the main queue
        composeController.completionHandler = ^(SLComposeViewControllerResult result) {
            
            switch(result) {
                    
                //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    break;
                    
                //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    break;
            }
            
            //  dismiss the Tweet Sheet
            dispatch_async(dispatch_get_main_queue(), ^{
                [parent dismissViewControllerAnimated:NO completion:^{
                    RLog(@"Tweet Sheet has been dismissed.");
                }];
            });
        };
        
        //  Adds an image to the Tweet.
        if (image != nil)
            [composeController addImage:image];
        
        if (url && ![url  isEqual: @""])
            [composeController addURL: [NSURL URLWithString:url]];
        
        if (message.length > 80)
            message = [message substringToIndex:80];
        
        
        //  Set the initial body of the Tweet
        NSUInteger idx = message.length;
        
        while (![composeController setInitialText:message]) {
            
            idx -= 10;
            if (idx > 10)
                message = [NSString stringWithFormat:@"%@…", [message substringToIndex:idx]];
        }
        
        if (idx != message.length)
            [composeController setInitialText:[NSString stringWithFormat:@"%@…", [message substringToIndex:idx - 10]]];

        //  Presents the Tweet Sheet to the user
        [parent presentViewController:composeController animated:NO completion:^{
            RLog(@"Tweet sheet has been presented.");
        }];
    }
    else {
        
        // else, we have to fallback to app or browser
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appURL]]) {
            
            // twitter app available!
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
        }
        else {
            
            // worse come to worse, open twitter page in browser
            NSString *web = [NSString stringWithFormat:@"https://twitter.com/intent/tweet?text=%@", escapedMessage];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:web]];
        }
    }
}

#pragma mark - Image Methods

- (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:2];
    [roundedRect fillWithBlendMode: kCGBlendModeNormal alpha:1.0f];
    [color setFill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - in app purchases

- (BOOL)isNetworkAvailable {
    
    CFNetDiagnosticRef diag;
    diag = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"www.apple.com"]);

    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (diag, NULL);
    
    CFRelease (diag);
    
    if ( status == kCFNetDiagnosticConnectionUp) {
        
        //RLog (@"Connection is up");
        return YES;
    }
    else {
        
        RLog (@"Connection is down");
        return NO;
    }
}

-(void)reachabilityChanged:(NSNotification*)note {
    
    Reachability * reach = [note object];
    
    if([reach isReachable])
        reachable = YES;
    else
        reachable = NO;
}

- (BOOL)validatePurchase {
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    fullVersion = [settings boolForKey:@"FullVersion"];
    
    if (fullVersion)
        return YES;
    
    if (![[OTBIAPHelper sharedInstance] productPurchased:@"com.orangethinkbox.kryptxt.unlimitedprofiles"]) {
        
        if (![self isNetworkAvailable]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh Oh!" message:@"Sorry, but there doesn't appear to be any internet connection, and we cannot verify whether or not you have previously purchased this functionality." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 53;
            [alert show];
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh Oh!" message:@"You can only add 2 profiles in the free version. If you purchase the full version you may have as many profiles as you like.\n Only $0.99" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes Please!", nil];
            
            [alert addButtonWithTitle:@"Restore Puchases"];
            
            alert.tag = 50;
            [alert show];
        }
        return NO;
    }
    else
        return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 50) {
        
        if (buttonIndex == 1) {
            
            if (_products.count > 0) {
                
                SKProduct *product = _products[0];
                RLog(@"Buying %@...", product.localizedTitle);
                
                [[OTBIAPHelper sharedInstance] buyProduct:product];
            }
            else {
                
                RLog (@"Warning: no products returned");
            }
        }
        else if (buttonIndex == 2) {
            
            [self restorePurchases];
        }
    }
}

- (void)loadProducts {
    
    _products = nil;
    
    [[OTBIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success)
            _products = products;
    }];
    
    RLog(@"Trying to check for purchased products");
    
    for (SKProduct *product in _products) {
        
        if ([[OTBIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
            
            RLog(@"Unpurchased %@", product.localizedTitle);
        }
        else{
            
            RLog(@"Purchased %@", product.localizedTitle);
            
            NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
            
            if (!fullVersion) {
                
                [settings setBool:YES forKey:@"FullVersion"];
                [settings synchronize];
            }
        }
    }
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    RLog(@"Buying %@...", product.productIdentifier);
    [[OTBIAPHelper sharedInstance] buyProduct:product];
    
}

- (void)productPurchased:(NSNotification *)notification {
    
    //NSString * productIdentifier = notification.object;
    
    //RLog(@"Hooray Bought %@", productIdentifier);
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setBool:YES forKey:@"FullVersion"];
    [settings synchronize];
    
    //    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
    //        if ([product.productIdentifier isEqualToString:productIdentifier]) {
    //            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    //            *stop = YES;
    //        }
    //    }];
    
}

- (void)restorePurchases {
    
    [[OTBIAPHelper sharedInstance] restoreCompletedTransactions];
}

@end
