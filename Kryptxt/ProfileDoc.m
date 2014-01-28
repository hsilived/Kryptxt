//
//  ProfileDoc.m
//  Profiles
//

#define kDataKey @"Data"
#define kDataFile @"data.plist"
//#define kThumbImageFile @"thumbImage.png"
//#define kFullImageFile  @"fullImage.png"

@implementation ProfileDoc
@synthesize data = _data;
//@synthesize thumbImage = _thumbImage;
//@synthesize fullImage = _fullImage;
@synthesize docPath = _docPath;

- (ProfileData *)data {

    if (_data != nil) return _data;

    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSData *codedData = [[NSData alloc] initWithContentsOfFile:dataPath];

    if (codedData == nil) return nil;

    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
    _data = [unarchiver decodeObjectForKey:kDataKey];
    [unarchiver finishDecoding];

    return _data;
}

- (id)init {

    if ((self = [super init])) {}

    return self;
}

- (id)initWithDocPath:(NSString *)docPath {

    if ((self = [super init]))
        _docPath = [docPath copy];

    return self;
}

- (id)initWithProfileAlias:(NSString *)profileAlias ProfileCode:(NSString *)profileCode ProfileName:profileName ProfileNumber:profileNumber ProfileEmail:(NSString *)profileEmail ProfileSelected:(BOOL)profileSelected {

    if ((self = [super init]))
        _data = [[ProfileData alloc] initWithProfileAlias:profileAlias ProfileCode:profileCode ProfileName:profileName ProfileNumber:profileNumber ProfileEmail:profileEmail ProfileSelected:profileSelected];

    return self;
}

- (void)dealloc {

    _data = nil;
//_fullImage = nil;
//_thumbImage = nil;
    _docPath = nil;
}

- (BOOL)createDataPath {

    if (_docPath == nil)
        self.docPath = [ProfileDatabase nextProfileDocPath];

    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:_docPath withIntermediateDirectories:YES attributes:nil error:&error];

    if (!success)
        DLog(@"Error creating data path: %@", [error localizedDescription]);

    return success;
}

- (void)saveData {

    if (_data == nil) return;

    [self createDataPath];

    NSString *dataPath = [_docPath stringByAppendingPathComponent:kDataFile];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_data forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
}

/*
- (UIImage *)thumbImage
{
    if (_thumbImage != nil) return _thumbImage;
    
    NSString *thumbImagePath = [_docPath stringByAppendingPathComponent:kThumbImageFile];
    return [UIImage imageWithContentsOfFile:thumbImagePath];  
}

- (UIImage *)fullImage
{ 
    if (_fullImage != nil) return _fullImage;
    
    NSString *fullImagePath = [_docPath stringByAppendingPathComponent:kFullImageFile];
    return [UIImage imageWithContentsOfFile:fullImagePath]; 
}

- (void)saveImages
{
    if (_thumbImage == nil || _fullImage == nil) return;
    
    [self createDataPath];
    
    NSString *thumbImagePath = [_docPath stringByAppendingPathComponent:kThumbImageFile];
    NSData *thumbImageData = UIImagePNGRepresentation(_thumbImage);
    [thumbImageData writeToFile:thumbImagePath atomically:YES];
    
    NSString *fullImagePath = [_docPath stringByAppendingPathComponent:kFullImageFile];
    NSData *fullImageData = UIImagePNGRepresentation(_fullImage);
    [fullImageData writeToFile:fullImagePath atomically:YES];
    
    self.thumbImage = nil;
    self.fullImage = nil;
}
*/

- (void)deleteDoc {

    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_docPath error:&error];

    if (!success)
        DLog(@"Error removing document path: %@", error.localizedDescription);
}


@end