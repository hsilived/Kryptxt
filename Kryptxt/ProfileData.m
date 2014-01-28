//
//  ProfileData.m
//  Profiles
//

@implementation ProfileData

@synthesize profileAlias, profileCode, profileName, profileNumber, profileEmail, profileSelected;

- (id)initWithProfileAlias:(NSString *)_profileAlias ProfileCode:(NSString *)_profileCode ProfileName:(NSString *)_profileName ProfileNumber:(NSString *)_profileNumber ProfileEmail:(NSString *)_profileEmail ProfileSelected:(BOOL)_profileSelected {

    if ((self = [super init])) {
        
        profileAlias = [_profileAlias copy];
        profileCode = [_profileCode copy];
        profileName = [_profileName copy];
        profileNumber = [_profileNumber copy];
        profileEmail = [_profileEmail copy];
        profileSelected = _profileSelected;
    }
    return self;
}

- (void)toggleSelected {

    profileSelected = !profileSelected;
}

- (void)dealloc {

    profileAlias = nil;
    profileCode = nil;
    profileName = nil;
    profileNumber = nil;
    profileEmail = nil;
    profileSelected = nil;
    //[super dealloc];
}

#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {

    [encoder encodeObject:profileAlias forKey:@"ProfileAlias"];
    [encoder encodeObject:profileCode forKey:@"ProfileCode"];
    [encoder encodeObject:profileName forKey:@"ProfileName"];
    [encoder encodeObject:profileNumber forKey:@"ProfileNumber"];
    [encoder encodeObject:profileEmail forKey:@"ProfileEmail"];
    [encoder encodeBool:profileSelected forKey:@"ProfileSelected"];
}

- (id)initWithCoder:(NSCoder *)decoder {

    NSString *_profileAlias = [decoder decodeObjectForKey:@"ProfileAlias"];
    NSString *_profileCode = [decoder decodeObjectForKey:@"ProfileCode"];
    NSString *_profileName = [decoder decodeObjectForKey:@"ProfileName"];
    NSString *_profileNumber = [decoder decodeObjectForKey:@"ProfileNumber"];
    NSString *_profileEmail = [decoder decodeObjectForKey:@"ProfileEmail"];
    BOOL _profileSelected = [decoder decodeBoolForKey:@"ProfileSelected"];
    
    return [self initWithProfileAlias:_profileAlias ProfileCode:_profileCode ProfileName:_profileName ProfileNumber:_profileNumber ProfileEmail:_profileEmail ProfileSelected:_profileSelected];
}

@end
