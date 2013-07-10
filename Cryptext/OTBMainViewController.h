//
//  OTBMainViewController.h
//  Cryptext
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBEditProfilesViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import  <QuartzCore/QuartzCore.h>
#import "ValidationMethods.h"
#import "OTBModalPopup.h"

@interface OTBMainViewController : UIViewController <OTBModalPopupDelegate, MFMailComposeViewControllerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) ValidationMethods* validationMethods;

@property (strong, nonatomic) IBOutlet UIImageView *downArrow;
@property (strong, nonatomic) IBOutlet UIImageView *upArrow;
@property (retain) ProfileDoc *profileDoc;
@property (strong, nonatomic) IBOutlet UILabel *tempCode;
@property (strong, nonatomic) IBOutlet UILabel *currentProfile;
@property (weak, nonatomic) IBOutlet UITextView *inputView;
@property (weak, nonatomic) IBOutlet UITextView *outputView;
@property (weak, nonatomic) IBOutlet UIView *InputPanel;
@property (weak, nonatomic) IBOutlet UIView *OutputPanel;
@property (strong, nonatomic) IBOutlet UIButton *outputButton;

@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (nonatomic, assign) NSString *profileCode;
@property (nonatomic, strong) NSString *alphaCode;
@property (nonatomic, strong) NSMutableArray *letterBlock1;
@property (nonatomic, strong) NSMutableArray *letterBlock2;
@property (nonatomic, strong) NSMutableArray *letterBlock3;
@property (nonatomic, strong) NSMutableArray *letterBlock4;
@property (nonatomic, strong) NSMutableArray *letterBlock5;
@property (nonatomic, strong) NSMutableArray *masterCode;
@property (nonatomic, strong) NSMutableArray *alphabet;
@property (retain) NSMutableArray *profiles;

@property (retain) OTBEditProfilesViewController *editProfileViewController;

- (void) loadProfileInfo;
- (void) setupProfileCode;
- (NSString *) compileAlphaCodeWithArray:(NSMutableArray *)array;
- (NSMutableArray *)rearrangeArray:(NSMutableArray *)array WithShift:(NSInteger)shift WithDirection:(NSInteger)direction;

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void) sendText;
- (void) sendSMSer: (NSArray *)toRecipient messageBody: (NSString *)messageBody;
- (void) messageComposeViewControllerDidCancel: (MFMessageComposeViewController *) messageController;
- (void) messageComposeViewController: (MFMessageComposeViewController *) messageController didFinishWithResult: (MessageComposeResult) result;
- (void) CopyToClipboard;
- (void) PasteFromClipboard;

- (void) setupKeyboardToolbar;
- (void) cancelKeyboard;
- (void) doneKeyboard;

- (BOOL) textView: (UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void) encryptLetter:(NSString *)letter;
- (void) decryptText;

- (IBAction)showActionSheet:(id)sender;
- (IBAction)infoOpen:(id)sender;

@end
