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
#import "ECSlidingViewController.h"
#import "LineBarButtonItem.h"
#import "SlideUpMenu.h"
#import "AppModel.h"
#import "ModalPopup.h"
#import "Arrow.h"

@interface OTBMainViewController : UIViewController <ModalPopupDelegate, SlideUpMenuDelegate> {
    
    GeneralHelpers* generalHelpers;
    ValidationMethods *validationMethods;
    OTBEditProfilesViewController *editProfileViewController;
    AppModel *appModel;
    ModalPopup *infoPopup;
    
    IBOutlet Arrow *downArrow;
    IBOutlet Arrow *upArrow;
    IBOutlet UILabel *tempCode;
    IBOutlet UILabel *currentProfile;
    IBOutlet UITextView *inputView;
    IBOutlet UITextView *outputView;
    IBOutlet UIView *inputPanel;
    IBOutlet UIView *outputPanel;
    IBOutlet UIButton *outputButton;
    IBOutlet UIButton *infoButton;
    IBOutlet UIView *containerView;
    IBOutlet UIView *confidentialView;
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
    
    SlideUpMenu *menu;
}

@property(retain) ProfileDoc *profile;
@property(retain) NSMutableArray *profiles;
@property (strong, nonatomic) LineBarButtonItem *rightDrawerButton;

#pragma mark - System Methods

- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)viewDidUnload;

#pragma mark - profile Methods

- (void)loadProfileInfo;
- (void)setupProfileCode;
- (NSString *)compileAlphaCodeWithArray:(NSMutableArray *)array;
- (NSMutableArray *)rearrangeArray:(NSMutableArray *)array WithShift:(NSInteger)shift WithDirection:(NSInteger)direction;

#pragma mark - ActionSheet Methods

- (void)sendText;
- (void)CopyToClipboard;
- (void)PasteFromClipboard;

#pragma mark - top Keyboard bar setup & events

- (void)setupKeyboardToolbar;
- (void)cancelKeyboard;
- (void)doneKeyboard;

#pragma mark - text conversion

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)encryptLetter:(NSString *)letter;
- (void)decryptText;

# pragma mark - slide out methods

- (void)revealUnderRight;
- (void)setupRightMenuButton;

- (IBAction)openSlideUpMenu:(id)sender;

@end
