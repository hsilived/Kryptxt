//
//  ProfileData.h
//  Profiles
//

#import <Foundation/Foundation.h>

@interface ProfileData : NSObject <NSCoding>

@property(copy) NSString *profileAlias;
@property(copy) NSString *profileCode;
@property(copy) NSString *profileName;
@property(copy) NSString *profileNumber;
@property(copy) NSString *profileEmail;
@property(assign) BOOL profileSelected;

- (void)toggleSelected;

- (id)initWithProfileAlias:(NSString *)_profileAlias ProfileCode:(NSString *)_profileCode ProfileName:(NSString *)_profileName ProfileNumber:(NSString *)_profileNumber ProfileEmail:(NSString *)_profileEmail ProfileSelected:(BOOL)_profileSelected;
@end
