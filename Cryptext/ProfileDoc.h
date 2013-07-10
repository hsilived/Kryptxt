//
//  ProfileDoc.h
//  ProfileDoc
//

#import <Foundation/Foundation.h>

@class ProfileData;

@interface ProfileDoc : NSObject

@property (nonatomic, retain) ProfileData *data;
//@property (retain) UIImage *thumbImage;
//@property (retain) UIImage *fullImage;
@property (copy) NSString *docPath;

- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (id)initWithTitle:(NSString *)title ProfileCode:(NSString *)profileCode ContactName:contactName ContactNumber:contactNumber ContactEmail:(NSString *)contactEmail Selected:(BOOL)selected;
- (void)saveData;
//- (void)saveImages;
- (void)deleteDoc;

@end
