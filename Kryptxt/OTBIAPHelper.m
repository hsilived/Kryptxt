//
//  OTBIAPHelper.m
//  Kryptxt
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "OTBIAPHelper.h"

@implementation OTBIAPHelper

+ (OTBIAPHelper *)sharedInstance {
    
    static dispatch_once_t once;
    static OTBIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:@"com.orangethinkbox.kryptxt.unlimitedprofiles", nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
