//
//  KeyboardHelper.h
//  KeyboardHelperDemo
//
//  Created by Shaikh Sonny Aman on 7/23/12.
//  Copyright (c) 2012 XappLab!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^t_KeyboardHelperOnDone)(void);

@interface KeyboardHelper : NSObject <UITextFieldDelegate, UITextViewDelegate> {
    
    float statusBarHeight;
    BOOL enabled;
    
    SEL onDoneSelector;
    SEL onExtraSelector;
    UIViewController *viewController;
    CGRect initialFrame;
    CGRect kbRect;
    float distanceFromKeyBoardTop;
    BOOL shouldSelectNextOnEnter;
    
    NSMutableArray *textFieldsAndViews;
    UIToolbar *barHelper;
    NSArray *barButtonSetNormal;
    NSArray *barButtonSetAtFirst;
    NSArray *barButtonSetAtLast;
    UIView *selectedTextFieldOrView;
    NSString *extraButton;
    t_KeyboardHelperOnDone onDoneBlock;
}

@property(nonatomic) UIBarButtonItem *btnExtra;
@property(nonatomic, strong) UISegmentedControl *segPrevNext;
@property(nonatomic, assign) id <UITextViewDelegate> textViewDelegate;
@property(nonatomic, assign) id <UITextFieldDelegate> textFieldDelegate;


- (id)initWithViewController:(UIViewController *)viewController;
- (id)initWithViewController:(UIViewController *)viewController onDoneSelector:(SEL)done;
- (id)initWithViewController:(UIViewController *)vc onDoneSelector:(SEL)done extraButton:(NSString *)extraText onExtraSelector:(SEL)extra;
- (id)initWithViewController:(UIViewController *)viewController onDoneAction:(t_KeyboardHelperOnDone)onDone;

- (void)enable;
- (void)disable;
- (void)reload;

@end
