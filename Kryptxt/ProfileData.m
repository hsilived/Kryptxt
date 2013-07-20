//
//  ProfileData.m
//  Profiles
//

@implementation ProfileData
@synthesize title, selected, profileCode, contactName, contactNumber, contactEmail;

- (id)initWithTitle:(NSString *)_title ProfileCode:(NSString *)_profileCode ContactName:(NSString *)_contactName ContactNumber:(NSString *)_contactNumber ContactEmail:(NSString *)_contactEmail Selected:(BOOL)_selected {

    if ((self = [super init])) {
        
        title = [_title copy];
        profileCode = [_profileCode copy];
        contactName = [_contactName copy];
        contactNumber = [_contactNumber copy];
        contactEmail = [_contactEmail copy];
        selected = _selected;
    }
    return self;
}

- (void)toggleSelected {

    selected = !selected;
}

- (void)dealloc {

    title = nil;
    //[super dealloc];
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:title forKey:@"Title"];
    [encoder encodeObject:profileCode forKey:@"ProfileCode"];
    [encoder encodeObject:contactName forKey:@"ContactName"];
    [encoder encodeObject:contactNumber forKey:@"ContactNumber"];
    [encoder encodeObject:contactEmail forKey:@"ContactEmail"];
    [encoder encodeBool:selected forKey:@"Selected"];
}

- (id)initWithCoder:(NSCoder *)decoder {

    NSString *_title = [decoder decodeObjectForKey:@"Title"];
    NSString *_profileCode = [decoder decodeObjectForKey:@"ProfileCode"];
    NSString *_contactName = [decoder decodeObjectForKey:@"ContactName"];
    NSString *_contactNumber = [decoder decodeObjectForKey:@"ContactNumber"];
    NSString *_contactEmail = [decoder decodeObjectForKey:@"ContactEmail"];
    BOOL _selected = [decoder decodeBoolForKey:@"Selected"];
    
    return [self initWithTitle:_title ProfileCode:_profileCode ContactName:_contactName ContactNumber:_contactNumber ContactEmail:_contactEmail Selected:_selected];
}

@end
