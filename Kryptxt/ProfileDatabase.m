//
//  ProfileDatabase.m
//  Profiles
//

@implementation ProfileDatabase

+ (NSString *)getPrivateDocsDir {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];

    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    return documentsDirectory;
}

+ (NSMutableArray *)loadProfileDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [ProfileDatabase getPrivateDocsDir];
    DLog(@"Loading Profiles from %@", documentsDirectory);

    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    if (files == nil) {
        
        DLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }

    // Create ProfileDoc for each file
    NSMutableArray *returningProfiles = [NSMutableArray arrayWithCapacity:files.count];

    for (NSString *file in files) {
        
        if ([file.pathExtension compare:@"Profile" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            ProfileDoc *doc = [[ProfileDoc alloc] initWithDocPath:fullPath];
            [returningProfiles addObject:doc];
        }
    }

    return returningProfiles;
}

+ (NSString *)nextProfileDocPath {
    
    // Get private docs dir
    NSString *documentsDirectory = [ProfileDatabase getPrivateDocsDir];

    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    if (files == nil) {
        
        DLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }

    // Search for an available name
    int maxNumber = 0;

    for (NSString *file in files) {
        
        if ([file.pathExtension compare:@"Profile" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            
            NSString *fileName = [file stringByDeletingPathExtension];
            maxNumber = MAX(maxNumber, fileName.intValue);
        }
    }

    // Get available name
    NSString *availableName = [NSString stringWithFormat:@"%d.Profile", maxNumber + 1];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
}

@end
