//
//  UIView+viewRecursion.m
//  Kryptxt
//
//  Created by DeviL on 2013-09-30.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "UIView+viewRecursion.h"

@implementation UIView (viewRecursion)

- (NSMutableArray*)allSubViews {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:self];
    
    for (UIView *subview in self.subviews) {
        
        [arr addObjectsFromArray:[subview allSubViews]];
    }
    return arr;
}

@end
