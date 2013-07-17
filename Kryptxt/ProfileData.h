//
//  ProfileData.h
//  Profiles
//

#import <Foundation/Foundation.h>

@interface ProfileData : NSObject <NSCoding>

@property(copy) NSString *title;
@property(copy) NSString *profileCode;
@property(copy) NSString *contactName;
@property(copy) NSString *contactNumber;
@property(copy) NSString *contactEmail;
@property(assign) BOOL selected;

- (void)toggleSelected;

- (id)initWithTitle:(NSString *)_title ProfileCode:(NSString *)_profileCode ContactName:(NSString *)_contactName ContactNumber:(NSString *)_contactNumber ContactEmail:(NSString *)_contactEmail Selected:(BOOL)_selected;
@end
