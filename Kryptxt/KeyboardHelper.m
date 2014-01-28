//
//  KeyboardHelper.m
//  KeyboardHelperDemo
//
//  Created by Shaikh Sonny Aman on 7/23/12.
//  Copyright (c) 2012 XappLab!. All rights reserved.
//

#import "KeyboardHelper.h"

@implementation KeyboardHelper

@synthesize textViewDelegate, textFieldDelegate, segPrevNext;

NSString *Prev = @"";

- (id)initWithViewController:(UIViewController *)vc onDoneSelector:(SEL)done {

    self = [self initWithViewController:vc];

    if (self)
        onDoneSelector = done;

    return self;
}

- (id)initWithViewController:(UIViewController *)vc onDoneSelector:(SEL)done extraButton:(NSString *)extraText onExtraSelector:(SEL)extra {

    if (self) {
        
        extraButton = extraText;
        onDoneSelector = done;
        onExtraSelector = extra;
    }

    self = [self initWithViewController:vc];

    return self;
}

- (id)initWithViewController:(UIViewController *)vc onDoneAction:(t_KeyboardHelperOnDone)onDone {

    self = [self initWithViewController:vc];

    if (self)
        onDoneBlock = onDone;

    return self;
}

- (id)initWithViewController:(UIViewController *)vc {

    if (!vc.isViewLoaded)
        [NSException raise:@"KeyboardHelperException" format:@"KeyboardHelper Error: View not loaded.\n Initialize keyboard helper in viewDidLoad method."];

    self = [super init];

    if (self) {

        enabled = NO;
        viewController = vc;
        distanceFromKeyBoardTop = 5;
        shouldSelectNextOnEnter = YES;

        textFieldsAndViews = [NSMutableArray new];

        initialFrame = vc.view.frame;
        //self.initialFrame = vc.navigationController.view.frame;
        statusBarHeight = 0;

        DLog(@"initialFrame - %f,%f,%f,%f", vc.view.frame.origin.x, vc.view.frame.origin.y, vc.view.frame.size.width, vc.view.frame.size.height);

//        if (![UIApplication sharedApplication].isStatusBarHidden) {
//
//            CGRect rect = [[UIApplication sharedApplication] statusBarFrame];
//            initialFrame.origin.y -= rect.size.height;
//            //initialFrame.size.height += rect.size.height;
//            statusBarHeight = rect.size.height;
//        }

        if (vc.navigationController)
            initialFrame.size.height -= vc.navigationController.toolbar.frame.size.height;

        //NSLog(@"initialFrame - %f,%f,%f,%f", initialFrame.origin.x, initialFrame.origin.y, initialFrame.size.width, initialFrame.size.height);

        barHelper = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, vc.view.bounds.size.width, 44)];
        barHelper.barStyle = UIBarStyleBlackTranslucent;

        // segmented control idea was given by Adam Roberts, Managing Director at Enigmatic Flare, 2012
        self.segPrevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Prev", @"Next", nil]];
        segPrevNext.segmentedControlStyle = UISegmentedControlStyleBar;
        segPrevNext.momentary = YES;
        [segPrevNext addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];

        if (extraButton != NULL && ![extraButton isEqualToString:@""]) {

            _btnExtra = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@", extraButton] style:UIBarButtonItemStyleBordered target:self action:@selector(onExtra:)];
        }

        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDone:)];

        UIBarButtonItem *separator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];

        if (_btnExtra != NULL)
            [barHelper setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:segPrevNext], separator, _btnExtra, separator, btnDone, nil]];
        else
            [barHelper setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:segPrevNext], separator, btnDone, nil]];

        [self reload];
    }

    return self;
}

- (void)reload {

    [textFieldsAndViews removeAllObjects];

    for (UIView *tempView in viewController.view.subviews) {

        if ([tempView isKindOfClass:[UIView class]]) {

            for (UIView *tempView2 in tempView.subviews) {

                if (!tempView2.hidden && tempView2.alpha && tempView2.isUserInteractionEnabled && ([tempView2 isKindOfClass:[UITextField class]] || [tempView2 isKindOfClass:[UITextView class]])) {

                    if ([tempView2 respondsToSelector:@selector(setInputAccessoryView:)])
                        [tempView2 performSelector:@selector(setInputAccessoryView:) withObject:barHelper];

                    [tempView2 performSelector:@selector(setDelegate:) withObject:self];
                    [textFieldsAndViews addObject:tempView2];

                    DLog(@"Text box - %d", tempView2.tag);
                }
            }
        }
        else {

            if (!tempView.hidden && tempView.alpha && tempView.isUserInteractionEnabled && ([tempView isKindOfClass:[UITextField class]] || [tempView isKindOfClass:[UITextView class]])) {

                if ([tempView respondsToSelector:@selector(setInputAccessoryView:)])
                    [tempView performSelector:@selector(setInputAccessoryView:) withObject:barHelper];

                [tempView performSelector:@selector(setDelegate:) withObject:self];

                [textFieldsAndViews addObject:tempView];
            }
        }
    }

    // order
    [textFieldsAndViews sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {

        CGPoint origin1 = [(UIView *) obj1 frame].origin;
        CGPoint origin2 = [(UIView *) obj2 frame].origin;

        if (origin1.y < origin2.y || origin1.x < origin2.x)
            return NSOrderedAscending;

        return NSOrderedDescending;
    }];

    [self enable];
}

- (void)enable {

    if (!enabled) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

        enabled = YES;
    }
}

- (void)disable {

    if (enabled) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        enabled = NO;
    }
}

- (void)segmentValueChanged:(UISegmentedControl *)sender {

    switch (sender.selectedSegmentIndex) {
            
        case 0:
            [self onPrev:nil];
            break;
        case 1:
            [self onNext:nil];
            break;
        default:
            break;
    }
}

- (void)updateViewPosition {

    //top of the keyboard
    float kbTopY = kbRect.origin.y;

    //space that is visible between status bar and keyboard + (padding between text box and keyboard top)
    float visibleYWithPadding = kbTopY - distanceFromKeyBoardTop - statusBarHeight;

    //current text box
    CGRect txtFrame = selectedTextFieldOrView.frame;

    //space between bottom of this textbox and the top of the (keyboard or next text object????)
    float visibleY = visibleYWithPadding - txtFrame.size.height;

    CGRect currentFrame = viewController.view.frame;

    DLog(@"currentFrame - %f,%f,%f,%f", currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);

    CGRect newFrame = initialFrame;

    DLog(@"top of keyboard - %f", kbTopY);
    DLog(@"space that is visible between status bar and keyboard - %f (%f - %f - %f)", visibleYWithPadding, kbTopY, distanceFromKeyBoardTop, statusBarHeight);
    DLog(@"space between bottom of this textbox and the top of the (keyboard or next text object????) - %f (%f - %f)", visibleY, visibleYWithPadding, txtFrame.size.height);

    int top = selectedTextFieldOrView.frame.origin.y + 74;

    DLog(@"top of text box %d - %d", selectedTextFieldOrView.tag, top);

    if (top > visibleY) {
        
        UIInterfaceOrientation orientation = viewController.interfaceOrientation;

        if (UIInterfaceOrientationIsPortrait(orientation)) {

            float offset = initialFrame.origin.y - currentFrame.origin.y;
            float diff = top - visibleY - offset;

            DLog(@"offset (%f - %f)- %f", initialFrame.origin.y, currentFrame.origin.y, offset);
            DLog(@"diff (%d - %f - %f)- %f", top, visibleY, offset, diff);

            if (orientation == UIInterfaceOrientationPortraitUpsideDown)
                newFrame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y + diff, currentFrame.size.width, currentFrame.size.height);
            else
                newFrame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y - diff, currentFrame.size.width, currentFrame.size.height);
        }
        else {

            if (orientation == UIInterfaceOrientationLandscapeRight) {

                DLog(@"KeyboardHelper: TBD: LandScape Mode");
            }
            else {

                float offset = initialFrame.origin.x - currentFrame.origin.x;
                float diff = top - visibleY - offset;
                newFrame = CGRectMake(currentFrame.origin.x - diff + kbRect.origin.x, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
            }

        }
    }

    DLog(@"currentFrame - %f,%f,%f,%f", currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height);
    DLog(@"newFrame - %f,%f,%f,%f", newFrame.origin.x, newFrame.origin.y, newFrame.size.width, newFrame.size.height);

    if (!CGRectEqualToRect(newFrame, currentFrame))
        [UIView animateWithDuration:0.3 animations:^(void) {
            viewController.view.frame = newFrame;
        }];
}

- (void)updateBarHelper {

    if (!CGRectIsEmpty(kbRect))
        [self updateViewPosition];

    id obj = [textFieldsAndViews objectAtIndex:0];

    if ((selectedTextFieldOrView.tag != 0) && (selectedTextFieldOrView.tag == 5) && (![extraButton isEqualToString:@""]))
        _btnExtra.enabled = true;
    else
        _btnExtra.enabled = false;

    if (obj == selectedTextFieldOrView) {

        [segPrevNext setEnabled:NO forSegmentAtIndex:0];
        [segPrevNext setEnabled:YES forSegmentAtIndex:1];
    }
    else if ([textFieldsAndViews lastObject] == selectedTextFieldOrView) {

        [segPrevNext setEnabled:NO forSegmentAtIndex:1];
        [segPrevNext setEnabled:YES forSegmentAtIndex:0];
    }
    else {

        [segPrevNext setEnabled:YES forSegmentAtIndex:0];
        [segPrevNext setEnabled:YES forSegmentAtIndex:1];
    }
}

- (void)onNext:(id)sender {

    if (selectedTextFieldOrView != [textFieldsAndViews lastObject]) {

        Prev = @"NO";

		 int index = [textFieldsAndViews indexOfObject:selectedTextFieldOrView];
        id nextObj = [textFieldsAndViews objectAtIndex:index + 1];
        [nextObj becomeFirstResponder];
    }

}

- (void)onPrev:(id)sender {

    if (selectedTextFieldOrView != [textFieldsAndViews objectAtIndex:0]) {

        Prev = @"YES";

        int index = [textFieldsAndViews indexOfObject:selectedTextFieldOrView];
        id nextObj = [textFieldsAndViews objectAtIndex:index - 1];
        [nextObj becomeFirstResponder];
    }
}

- (void)onExtra:(id)sender {

    if (onExtraSelector) {

        if ([viewController respondsToSelector:onExtraSelector]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [viewController performSelector:onExtraSelector];
            #pragma clang diagnostic pop

        }
    }
}

- (void)onDone:(id)sender {

    [selectedTextFieldOrView resignFirstResponder];

    if (onDoneSelector) {

        if ([viewController respondsToSelector:onDoneSelector]) {

            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [viewController performSelector:onDoneSelector];
            #pragma clang diagnostic pop
        }
    }
    else if (onDoneBlock) {
        onDoneBlock();
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    selectedTextFieldOrView = textField;
    [self updateBarHelper];

    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [textFieldDelegate textFieldShouldBeginEditing:textField];

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [textFieldDelegate textFieldDidBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        return [textFieldDelegate textFieldShouldEndEditing:textField];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [textFieldDelegate textFieldDidEndEditing:textField];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textField: shouldChangeCharactersInRange: replacementString:)])
        return [textFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {

    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [textFieldDelegate textFieldShouldClear:textField];

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (shouldSelectNextOnEnter)
        [self onNext:nil];

    return YES;
}

#pragma mark - UITextViewDelegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    selectedTextFieldOrView = textView;
    [self updateBarHelper];

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        return [textViewDelegate textViewShouldBeginEditing:textView];

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        return [textViewDelegate textViewShouldEndEditing:textView];

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [textViewDelegate textViewDidBeginEditing:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView {

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [textViewDelegate textViewDidEndEditing:textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textView: shouldChangeTextInRange: replacementText:)])
        return [textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewDidChange:)])
        [textViewDelegate textViewDidChange:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {

    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [textViewDelegate textViewDidChangeSelection:textView];
}

#pragma mark - KeyBoard notifications

- (void)keyboardWillShow:(NSNotification *)notify {

    kbRect = [(NSValue *) [notify.userInfo valueForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    [self updateViewPosition];
}

- (void)keyboardWillHide:(NSNotification *)notify {

    [UIView animateWithDuration:0.25 animations:^(void) {
        viewController.view.frame = initialFrame;
    }];
}
@end
