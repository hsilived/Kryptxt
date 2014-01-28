//
//  EditProfilesViewController.h
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeoplePicker.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ValidationMethods.h"
#import "AppModel.h"
#import "GeneralHelpers.h"
#import "LineBarButtonItem.h"
#import "KeyboardTextFields.h"
#import "IQKeyBoardManager.h"

@class ProfileDoc;

@protocol OTBEditProfilesViewControllerDelegate

@end

@interface OTBEditProfilesViewController : UIViewController  <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverControllerDelegate, UIActionSheetDelegate> {
    
    GeneralHelpers* generalHelpers;
    ValidationMethods *validationMethods;
    //KeyboardHelper *kbHelper;
    KeyboardTextFields *textFields;
    PeoplePicker *peoplePicker;
    AppModel *appModel;
    LineBarButtonItem *closeButton;
    LineBarButtonItem *saveButton;
    
    NSArray *digits;
    NSMutableDictionary *labels;
    
    IBOutlet UIView *containerView;
    IBOutlet UIView *mainView;
    IBOutlet UITextField *profileAliasText;
    IBOutlet UITextField *profileNameText;
    IBOutlet UITextField *profileNumberText;
    IBOutlet UITextField *profileEmailText;
    IBOutlet UIView *profileCodeView;
    IBOutlet UILabel *contactCode1;
    IBOutlet UILabel *contactCode2;
    IBOutlet UILabel *contactCode3;
    IBOutlet UILabel *contactCode4;
    IBOutlet UILabel *contactCode5;
    IBOutlet UILabel *contactCode6;
    IBOutlet UILabel *contactCode7;
    IBOutlet UILabel *contactCode8;
    IBOutlet UILabel *characterCountLabel;
    IBOutlet UINavigationItem *navItem;
    IBOutlet UILabel *backupCodeLabel;
    IBOutlet UILabel *backupCodeTextLabel;
    IBOutlet UIButton *sendInviteButton;
    
    NSString *profileCode;
    NSString *backupCode;
    UIPickerView *codeGen;
    NSMutableString *code;
    NSMutableArray *profiles;
    UIView *modalBackground;
    UIView *navBackground;
    UIView *pickerDisplayView;
}

@property(weak, nonatomic) id <OTBEditProfilesViewControllerDelegate> delegate;

@property(retain) ProfileDoc *profile;

@property (strong, nonatomic) UIPopoverController *popover;

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (IBAction)showCodePicker:(id)sender;
- (IBAction)showPicker:(id)sender;

- (void)onDoneCodePicking;
- (void)optionFromCodePicker:(id)sender;
- (IBAction)closeFirstPicker:(id)sender;

- (void)closePicker;
- (IBAction)resetCode:(id)sender;
- (IBAction)sendInvite:(id)sender;


@end
