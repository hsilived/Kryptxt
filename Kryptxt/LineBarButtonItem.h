//
//  LineBarButtonItem.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    LineBarButtonItemStyleSave, // Default
    LineBarButtonItemStyleAdd,
    LineBarButtonItemStyleClose,
    LineBarButtonItemStyleEdit,
    LineBarButtonItemStyleList,
} LineBarButtonItemStyle;

@interface LineBarButtonItem : UIBarButtonItem

@property (nonatomic) LineBarButtonItemStyle buttonStyle;
@property (nonatomic) UIColor *buttonColor;
@property (nonatomic) UIColor *buttonHighlightColor;

- (id)initWithTarget:(id)target andAction:(SEL)action andStyle:(LineBarButtonItemStyle)style;

@end
