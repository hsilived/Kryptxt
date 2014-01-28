//
//  Arrow.h
//  Watchoo
//
//  Created by DeviL on 2013-05-11.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    
    ArrowDirectionUp, // Default
    ArrowDirectionDown,
} ArrowDirection;

@interface Arrow : UIView

@property (nonatomic, strong) UIColor *arrowBackgroundColor;
@property (nonatomic, strong) UIColor *arrowBorderColor;
@property (nonatomic, strong) UIColor *arrowHighlightColor;
@property (nonatomic) ArrowDirection arrowDirection;

@property (nonatomic, strong) IBOutlet UITextView *inputTextView;
@property (nonatomic, strong) IBOutlet UITextView *outputTextView;
@property (nonatomic, strong) IBOutlet UIButton *convertButton;

@end
