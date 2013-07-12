//
//  PeoplePicker.m
//  Piggie
//
//  Created by DeviL on 2013-01-01.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "PeoplePicker.h"


@implementation PeoplePicker

- (id)init {

    if ((self = [super init])) {
    }

    return self;
}

- (id)initWithViewController:(UIViewController *)vc onDoneSelector:(SEL)done {

    self = [self initWithViewController:vc];

    if (self)
        self.onDoneSelector = done;

    return self;
}

- (id)initWithViewController:(UIViewController *)vc {

    if (!vc.isViewLoaded) {
        [NSException raise:@"PeoplePickerException" format:@"PeoplePicker Error: View not loaded.\n Initialize PeoplePicker helper in viewDidLoad method."];
        return nil;
    }

    self = [super init];

    if (self) {
        self.viewController = vc;
    }

    return self;
}

- (void)showPicker {

    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    picker.modalPresentationStyle = UIModalPresentationPageSheet;

    [_viewController presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {

    [_viewController dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {

    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {

    NSString *name = (__bridge_transfer NSString *) ABRecordCopyValue(person, kABPersonFirstNameProperty);

    ABMutableMultiValueRef phones;
    phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (phones == nil || ABMultiValueGetCount(phones) == 0) {
        CFArrayRef linkedContacts = ABPersonCopyArrayOfAllLinkedPeople(person);
        phones = ABMultiValueCreateMutable(kABPersonPhoneProperty);
        ABMultiValueRef linkedPhones;
        for (int i = 0; i < CFArrayGetCount(linkedContacts); i++) {
            ABRecordRef linkedContact = CFArrayGetValueAtIndex(linkedContacts, i);
            linkedPhones = ABRecordCopyValue(linkedContact, kABPersonPhoneProperty);
            if (linkedPhones != nil && ABMultiValueGetCount(linkedPhones) > 0) {
                for (int j = 0; j < ABMultiValueGetCount(linkedPhones); j++) {
                    ABMultiValueAddValueAndLabel(phones, ABMultiValueCopyValueAtIndex(linkedPhones, j), ABMultiValueCopyLabelAtIndex(linkedPhones, j), NULL);
                }
            }
            CFRelease(linkedPhones);
        }
        CFRelease(linkedContacts);

        if (ABMultiValueGetCount(phones) == 0) {
            CFRelease(phones);
            return NO;
        }

    }
//else
//    return NO;
//ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSString *mobile = @"[None]";
    NSString *mobileLabel;

    for (int i = 0; i < ABMultiValueGetCount(phones); i++) {
//NSString *phone = (NSString *)ABMultiValueCopyValueAtIndex(phones, i);
//DLog(@"%@", phone);
        mobileLabel = (__bridge NSString *) ABMultiValueCopyLabelAtIndex(phones, i);

        if ([mobileLabel isEqualToString:(NSString *) kABPersonPhoneMobileLabel])
            DLog(@"mobile:");
        else if ([mobileLabel isEqualToString:(NSString *) kABPersonPhoneIPhoneLabel])
            DLog(@"iphone:");
        else if ([mobileLabel isEqualToString:(NSString *) kABPersonPhonePagerLabel])
            DLog(@"pager:");


        mobile = (__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, i);
        DLog(@"%@", mobile);
    }

    NSString *email = nil;
    ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);

    if (emails)
        email = (__bridge NSString *) ABMultiValueCopyValueAtIndex(emails, 0);

    [_viewController dismissModalViewControllerAnimated:YES];

    self.contactName = name;
    self.contactNumber = mobile;
    self.contactEmail = email;

    [self onDone];

    return NO;
}


- (void)displayPerson:(ABRecordRef)person {
// Request authorization to Address Book
    ABAddressBookRef addressBook = ABAddressBookCreate();

    __block BOOL accessGranted = NO;

    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);

        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });

        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }

    if (accessGranted) {
        NSString *name = (__bridge_transfer NSString *) ABRecordCopyValue(person, kABPersonFirstNameProperty);

//ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
//NSString *mobilephone1 = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, 0);

//ABMultiValueRef phone2 = ABRecordCopyValue(person, kABPersonPhoneProperty);
//NSString *mobilephone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone2, 0);
//DLog(@"mobile - %@", mobilephone);

        ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSString *mobile = @"[None]";
        NSString *mobileLabel;

        for (int i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString *) ABMultiValueCopyLabelAtIndex(phones, i);

            if ([mobileLabel isEqualToString:(NSString *) kABPersonPhoneMobileLabel])
                DLog(@"mobile:");
            else if ([mobileLabel isEqualToString:(NSString *) kABPersonPhoneIPhoneLabel])
                DLog(@"iphone:");
            else if ([mobileLabel isEqualToString:(NSString *) kABPersonPhonePagerLabel])
                DLog(@"pager:");

            mobile = (__bridge NSString *) ABMultiValueCopyValueAtIndex(phones, i);
            DLog(@"%@", mobile);
        }

        self.contactName = name;
        self.contactNumber = mobile;
        self.contactEmail = mobile;
    }
}

- (void)onDone {

    if (self.onDoneSelector) {
        if ([_viewController respondsToSelector:_onDoneSelector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [_viewController performSelector:_onDoneSelector];
#pragma clang diagnostic pop
        }
    }
    else if (self.onDoneBlock) {
        _onDoneBlock();
    }
}

@end
