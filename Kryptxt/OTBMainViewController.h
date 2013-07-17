//
//  OTBMainViewController.h
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import "OTBEditProfilesViewController.h"
#import "OTBProfilesViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import  <QuartzCore/QuartzCore.h>
#import "ValidationMethods.h"
#import "GeneralHelpers.h"
#import "OTBModalPopup.h"
#import "ECSlidingViewController.h"

@interface OTBMainViewController : UIViewController <OTBModalPopupDelegate, MFMailComposeViewControllerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate> {
    
    GeneralHelpers* generalHelpers;
    ValidationMethods *validationMethods;
    OTBEditProfilesViewController *editProfileViewController;
    OTBProfilesViewController *profiles;
    
    IBOutlet UIImageView *downArrow;
    IBOutlet UIImageView *upArrow;
    IBOutlet UILabel *tempCode;
    IBOutlet UILabel *currentProfile;
    IBOutlet UITextView *inputView;
    IBOutlet UITextView *outputView;
    IBOutlet UIView *inputPanel;
    IBOutlet UIView *outputPanel;
    IBOutlet UIButton *outputButton;
    IBOutlet UIButton *infoButton;
    IBOutlet UIView *containerPanel;
    IBOutlet UIView *confidentalView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UIImageView *containerImage;
    
    NSString *profileCode;
    NSString *alphaCode;
    NSMutableArray *letterBlock1;
    NSMutableArray *letterBlock2;
    NSMutableArray *letterBlock3;
    NSMutableArray *letterBlock4;
    NSMutableArray *letterBlock5;
    NSMutableArray *masterCode;
    NSMutableArray *alphabet;
}

@property(retain) ProfileDoc *profileDoc;
@property(retain) NSMutableArray *profiles;

- (void)loadProfileInfo;

- (void)setupProfileCode;

- (NSString *)compileAlphaCodeWithArray:(NSMutableArray *)array;

- (NSMutableArray *)rearrangeArray:(NSMutableArray *)array WithShift:(NSInteger)shift WithDirection:(NSInteger)direction;

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)sendText;

- (void)sendSMSer:(NSArray *)toRecipient messageBody:(NSString *)messageBody;

- (void)messageComposeViewControllerDidCancel:(MFMessageComposeViewController *)messageController;

- (void)messageComposeViewController:(MFMessageComposeViewController *)messageController didFinishWithResult:(MessageComposeResult)result;

- (void)CopyToClipboard;

- (void)PasteFromClipboard;

- (void)setupKeyboardToolbar;

- (void)cancelKeyboard;

- (void)doneKeyboard;

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)encryptLetter:(NSString *)letter;

- (void)decryptText;

- (IBAction)showActionSheet:(id)sender;

- (IBAction)infoOpen:(id)sender;
- (IBAction)revealUnderRight:(id)sender;

@end
