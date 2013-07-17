//
//  EditProfilesViewController.h
//  Kryptxt
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardHelper.h"
#import "PeoplePicker.h"
#import <QuartzCore/QuartzCore.h>
#import "ValidationMethods.h"
#import "GeneralHelpers.h"

@class ProfileDoc;

@protocol OTBEditProfilesViewControllerDelegate

@end

@interface OTBEditProfilesViewController : UIViewController  <UITextFieldDelegate, UIPickerViewDelegate> {
    
    GeneralHelpers* generalHelpers;
    ValidationMethods *validationMethods;
    KeyboardHelper *kbHelper;
    PeoplePicker *peoplePicker;
    
    NSArray *digits;
    NSMutableDictionary *labels;
    UIPopoverController *popover;
    IBOutlet UIView *containerPanel;
    IBOutlet UIView *mainView;
    IBOutlet UITextField *profileName;
    IBOutlet UITextField *contactName;
    IBOutlet UITextField *contactNumber;
    IBOutlet UITextField *contactEmail;
    IBOutlet UIView *contactCode;
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
    
    NSString *profileCode;
    UIPickerView *codeGen;
    NSMutableString *code;
    NSMutableArray *profiles;
    UIView *modalBackground;
    UIView *navBackground;
    UIView *pickerDisplayView;
}

@property(weak, nonatomic) id <OTBEditProfilesViewControllerDelegate> delegate;

@property(retain) ProfileDoc *profile;

- (IBAction)showActionSheet:(id)sender;

- (IBAction)showPicker:(id)sender;

- (void)randomize;

- (IBAction)cancelButton:(id)sender;

- (IBAction)saveButton:(id)sender;

- (void)onDoneCodePicking;

- (void)nextFromCodePicker;

- (IBAction)closeFirstPicker:(id)sender;

- (void)closePicker;

@end
