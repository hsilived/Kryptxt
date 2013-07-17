//
//  ProfileDatabase.h
//  Profiles
//


#import <Foundation/Foundation.h>

@interface ProfileDatabase : NSObject

+ (NSMutableArray *)loadProfileDocs;

+ (NSString *)nextProfileDocPath;

@end
