//
//  PeoplePicker.h
//  Piggie
//
//  Created by DeviL on 2013-01-01.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

typedef void(^t_PeoplePickerOnDone)(void);

@interface PeoplePicker : ABPeoplePickerNavigationController <ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) NSString *contactName;
@property (strong, nonatomic) NSString *contactNumber;
@property (strong, nonatomic) NSString *contactEmail;
@property (nonatomic, assign) UIViewController* viewController;
@property (nonatomic, assign) SEL onDoneSelector;
@property (nonatomic, strong) t_PeoplePickerOnDone onDoneBlock;

- (id) initWithViewController:(UIViewController*)viewController;
- (id) initWithViewController:(UIViewController*)viewController onDoneSelector:(SEL)done;
- (void) showPicker;

@end