//
//  ProfileData.m
//  Profiles
//

#import "ProfileData.h"

@implementation ProfileData
@synthesize title = _title;
@synthesize selected = _selected;
@synthesize profileCode = _profileCode;
@synthesize contactName = _contactName;
@synthesize contactNumber = _contactNumber;
@synthesize contactEmail = _contactEmail;

- (id)initWithTitle:(NSString *)title ProfileCode:(NSString *)profileCode ContactName:contactName ContactNumber:contactNumber ContactEmail:(NSString *)contactEmail Selected:(BOOL)selected {

    if ((self = [super init])) {
        _title = [title copy];
        _profileCode = [profileCode copy];
        _contactName = [contactName copy];
        _contactNumber = [contactNumber copy];
        _contactEmail = [contactEmail copy];
        _selected = selected;
    }
    return self;
}

- (void)toggleSelected {

    self.selected = !self.selected;
}

- (void)dealloc {

    _title = nil;
//[super dealloc];
}

#pragma mark NSCoding

#define kTitleKey               @"Title"
#define kProfileCodeKey         @"ProfileCode"
#define kContactNameKey         @"ContactName"
#define kContactNumberKey       @"ContactNumber"
#define kContactEmailKey        @"ContactEmail"
#define kProfileSelectedKey     @"Selected"

- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeObject:_profileCode forKey:kProfileCodeKey];
    [encoder encodeObject:_contactName forKey:kContactNameKey];
    [encoder encodeObject:_contactNumber forKey:kContactNumberKey];
    [encoder encodeObject:_contactEmail forKey:kContactEmailKey];
    [encoder encodeBool:_selected forKey:kProfileSelectedKey];
}

- (id)initWithCoder:(NSCoder *)decoder {

    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    NSString *profileCode = [decoder decodeObjectForKey:kProfileCodeKey];
    NSString *contactName = [decoder decodeObjectForKey:kContactNameKey];
    NSString *contactNumber = [decoder decodeObjectForKey:kContactNumberKey];
    NSString *contactEmail = [decoder decodeObjectForKey:kContactEmailKey];
    BOOL selected = [decoder decodeBoolForKey:kProfileSelectedKey];
    return [self initWithTitle:title ProfileCode:profileCode ContactName:contactName ContactNumber:contactNumber ContactEmail:contactEmail Selected:selected];
}

@end
