//
//  ButtonSection.h
//  SlideUpMenu
//
//  Created by DeviL on 2013-10-07.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonSection : UIScrollView

typedef enum {
    
    ButtonSectionTypeLine, // Default
    ButtonSectionTypeIcon
} ButtonSectionType;

//Button Layout properties
@property (nonatomic) ButtonSectionType buttonSectionType;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic) int buttonSectionHeight;
@property (nonatomic) int buttonSectionPadding;
@property (nonatomic) int buttonSectionIconWidth;

- (id)initWithType:(ButtonSectionType)buttonSectionType;

@end
