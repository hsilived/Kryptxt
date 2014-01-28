//
//  KeyboardTextFields.h
//  Kryptxt
//
//  Created by DeviL on 12/22/2013.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^t_KeyboardManagerOnDone)(void);

@interface KeyboardTextFields : NSObject <UITextFieldDelegate, UITextViewDelegate> {
    
    SEL onDoneSelector;
    UIViewController *viewController;
    BOOL shouldSelectNextOnEnter;
    
    NSMutableArray *textFieldsAndViews;
    UIToolbar *barHelper;
    NSArray *barButtonSetNormal;
    NSArray *barButtonSetAtFirst;
    NSArray *barButtonSetAtLast;
    UIView *selectedTextFieldOrView;
    t_KeyboardManagerOnDone onDoneBlock;
    
    UIView *textFieldView;
}

@property (nonatomic, strong) UISegmentedControl* segPrevNext;
@property (nonatomic, assign) id<UITextViewDelegate> textViewDelegate;
@property (nonatomic, assign) id<UITextFieldDelegate> textFieldDelegate;

- (id) initWithViewController:(UIViewController*)viewController;
- (id) initWithViewController:(UIViewController*)viewController onDoneSelector:(SEL)done;
- (id) initWithViewController:(UIViewController*)viewController onDoneAction:(t_KeyboardManagerOnDone)onDone;

@end
