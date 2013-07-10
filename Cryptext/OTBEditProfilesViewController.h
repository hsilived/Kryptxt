//
//  EditProfilesViewController.h
//  Cryptext
//
//  Created by DeviL on 2012-11-27.
//  Copyright (c) 2012 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardHelper.h"
#import "PeoplePicker.h"
#import <QuartzCore/QuartzCore.h>
#import "ValidationMethods.h"

@class ProfileDoc;

@protocol OTBEditProfilesViewControllerDelegate

@end

@interface OTBEditProfilesViewController : UIViewController <UIPickerViewDelegate> {
    NSArray *digits;
    NSMutableDictionary *labels;
}
@property(weak, nonatomic) id <OTBEditProfilesViewControllerDelegate> delegate;

@property(nonatomic, strong) ValidationMethods *validationMethods;
@property(nonatomic, strong) KeyboardHelper *kbHelper;
@property(nonatomic, strong) PeoplePicker *peoplePicker;
@property(retain) ProfileDoc *profileDoc;

@property(retain) NSMutableArray *profiles;
@property(nonatomic, assign) NSString *profileCode;
@property(strong, nonatomic) IBOutlet UIView *containerPanel;

@property(strong, nonatomic) IBOutlet UIView *mainView;
@property(strong, nonatomic) IBOutlet UITextField *profileName;
@property(strong, nonatomic) IBOutlet UITextField *contactName;
@property(strong, nonatomic) IBOutlet UITextField *contactNumber;
@property(strong, nonatomic) IBOutlet UITextField *contactEmail;
@property(strong, nonatomic) IBOutlet UIPickerView *codeGen;
@property(strong, nonatomic) IBOutlet UIView *contactCode;
@property(strong, nonatomic) IBOutlet UILabel *contactCode1;
@property(strong, nonatomic) IBOutlet UILabel *contactCode2;
@property(strong, nonatomic) IBOutlet UILabel *contactCode3;
@property(strong, nonatomic) IBOutlet UILabel *contactCode4;
@property(strong, nonatomic) IBOutlet UILabel *contactCode5;
@property(strong, nonatomic) IBOutlet UILabel *contactCode6;
@property(strong, nonatomic) IBOutlet UILabel *contactCode7;
@property(strong, nonatomic) IBOutlet UILabel *contactCode8;
@property(strong, nonatomic) NSMutableString *code;
@property(strong, nonatomic) UIView *modalBackground;
@property(strong, nonatomic) UIView *navBackground;

@property(strong, nonatomic) UIView *pickerDisplayView;

- (IBAction)showActionSheet:(id)sender;

- (IBAction)showPicker:(id)sender;

- (void)randomize;

- (void)cancelButton;

- (void)saveButton;

- (void)onDoneCodePicking;

- (void)nextFromCodePicker;

- (IBAction)closeFirstPicker:(id)sender;

- (void)closePicker;

- (void)createBackgroundLayerWithView:(UIView *)view;

@end
