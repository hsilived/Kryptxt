//
//  DLog.h
//  GoWithTheFlow
//
//  Created by DeviL on 2013-07-06.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#ifdef DEBUG
#define DLog(xx, ...) NSLog(@"%s(%d): " xx, ((strrchr(__FILE__, '/') ? : __FILE__- 1) + 1), __LINE__, ##__VA_ARGS__)
#else
#define DLog(xx, ...) ((void)0)
#endif

#define DLogRect(r) DLog(@"%s x=%f, y=%f, w=%f, h=%f", #r, r.origin.x, r.origin.y, r.size.width, r.size.height)
