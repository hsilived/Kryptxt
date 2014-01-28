//
//  DLog.h
//  Kryptxt
//
//  Created by DeviL on 2013-07-06.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#define IS_IPAD UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

#ifdef __IPHONE_7_0
# define ALIGN_CENTER NSTextAlignmentCenter
#else
# define ALIGN_CENTER NSTextAlignmentCenter
#endif

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define DLog_ENABLE_LOGGING      0

#if DLog_ENABLE_LOGGING
#define DLog(xx, ...) NSLog(@"%s(%d): " xx, ((strrchr(__FILE__, '/') ? : __FILE__- 1) + 1), __LINE__, ##__VA_ARGS__)
#else
#define DLog(xx, ...) ((void)0)
#endif

#define RLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);

//#define DLog(format, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define DLogRect(r) RLog(@"%s x=%f, y=%f, w=%f, h=%f", #r, r.origin.x, r.origin.y, r.size.width, r.size.height)