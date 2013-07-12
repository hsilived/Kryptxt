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

//- (id)initWithTitle:(NSString*)title ProfileCode:(NSString *)profileCode;
//- (id)initWithTitle:(NSString*)title ProfileCode:(NSString *)profileCode Selected:(BOOL)selected;
- (id)initWithTitle:(NSString *)title ProfileCode:(NSString *)profileCode ContactName:contactName ContactNumber:contactNumber ContactEmail:(NSString *)contactEmail Selected:(BOOL)selected;
@end
