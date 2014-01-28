//
//  ProfileDoc.h
//  ProfileDoc
//

#import <Foundation/Foundation.h>

@class ProfileData;

@interface ProfileDoc : NSObject

@property(nonatomic, retain) ProfileData *data;
//@property (retain) UIImage *thumbImage;
//@property (retain) UIImage *fullImage;
@property(copy) NSString *docPath;

- (id)init;

- (id)initWithDocPath:(NSString *)docPath;

- (id)initWithProfileAlias:(NSString *)title ProfileCode:(NSString *)profileCode ProfileName:(NSString *)profileName ProfileNumber:(NSString *)profileNumber ProfileEmail:(NSString *)profileEmail ProfileSelected:(BOOL)profileSelected;

- (void)saveData;

//- (void)saveImages;
- (void)deleteDoc;

@end
