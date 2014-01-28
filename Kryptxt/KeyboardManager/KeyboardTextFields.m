//
//  KeyboardManager.m
//  Kryptxt
//
//  Created by DeviL on 12/22/2013.
//  Copyright (c) 2013 Orange Think Box. All rights reserved.
//

#import "KeyboardTextFields.h"

@implementation KeyboardTextFields

@synthesize textViewDelegate, textFieldDelegate, segPrevNext;

//NSString *Prev = @"";

- (id)initWithViewController:(UIViewController *)vc onDoneSelector:(SEL)done {

	self = [self initWithViewController:vc];
	
    if (self)
	onDoneSelector = done;

	return self;
}

- (id)initWithViewController:(UIViewController *)vc onDoneAction:(t_KeyboardManagerOnDone)onDone {

	self = [self initWithViewController:vc];
	
    if (self)
        onDoneBlock = onDone;

	return self;
}

- (id)initWithViewController:(UIViewController *)vc {

	if ( !vc.isViewLoaded )
		[NSException raise:@"KeyboardHelperException" format:@"KeyboardHelper Error: View not loaded.\n Initialize keyboard helper in viewDidLoad method."];
	
	self = [super init];
	
    if (self)  {
    
        viewController = vc;
	
		textFieldsAndViews = [NSMutableArray new];
		
        barHelper = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, vc.view.bounds.size.width, 44)];
		barHelper.barStyle = UIBarStyleBlackTranslucent;
		
		self.segPrevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Prev", @"Next", nil]];
		segPrevNext.segmentedControlStyle = UISegmentedControlStyleBar;
		segPrevNext.momentary = YES;
		[segPrevNext addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
		
		UIBarButtonItem* btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDone:)];
        
		UIBarButtonItem* separator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
        
		[barHelper setItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:segPrevNext], separator, btnDone, nil]];

        [textFieldsAndViews removeAllObjects];
        [self allSubViews:viewController.view];
        [self orderTextBoxes];	}

	return self;
}

- (NSMutableArray *)allSubViews:(UIView *)start {
    
    for (UIView *subview in start.subviews) {
        
        if (!subview.hidden && subview.alpha && subview.isUserInteractionEnabled && ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]])) {
            
            if ([subview respondsToSelector:@selector(setInputAccessoryView:)])
                [subview performSelector:@selector(setInputAccessoryView:) withObject:barHelper];
            
            [subview performSelector:@selector(setDelegate:) withObject:self];
            
            //NSLog(@"adding text field %d", subview.tag);
            
            [textFieldsAndViews addObject:subview];
        }
        
        [self allSubViews:subview];
    }
    
    return textFieldsAndViews;
}

- (void)orderTextBoxes {
    
    // order
    [textFieldsAndViews sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
		CGPoint origin1 = [(UIView *)obj1 frame].origin;
		CGPoint origin2 = [(UIView *)obj2 frame].origin;
		
        if (origin1.y <= origin2.y || origin1.x <= origin2.x)
			return  NSOrderedAscending;
        
		return NSOrderedDescending;
	}];
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

- (void)updateBarHelper {

	id obj = [textFieldsAndViews objectAtIndex:0];
    
	if (obj == selectedTextFieldOrView) {
	
        [segPrevNext setEnabled:NO forSegmentAtIndex:0];
        [segPrevNext setEnabled:YES forSegmentAtIndex:1];
	}
    else if ( [textFieldsAndViews lastObject] == selectedTextFieldOrView )  {
    
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

        //Prev = @"NO";
        
		int index = [textFieldsAndViews indexOfObject:selectedTextFieldOrView];
		id nextObj = [textFieldsAndViews objectAtIndex:index + 1];
		[nextObj becomeFirstResponder];
	}
	
}

- (void)onPrev:(id)sender {

    if (selectedTextFieldOrView != [textFieldsAndViews objectAtIndex:0]) {

        //Prev = @"YES";
        
		int index = [textFieldsAndViews indexOfObject:selectedTextFieldOrView];
		id nextObj = [textFieldsAndViews objectAtIndex:index - 1];
		[nextObj becomeFirstResponder];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    selectedTextFieldOrView = textField;
    
    [self updateBarHelper];
    
    if (self.textFieldDelegate && [textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
		return [textFieldDelegate textFieldShouldBeginEditing:textField];
    
	return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    selectedTextFieldOrView = textView;
    
    [self updateBarHelper];
    
    if (self.textViewDelegate && [textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
		return [textViewDelegate textViewShouldBeginEditing:textView];
    
	return YES;
}

@end
